table 99120 Sponsor
{
    Caption = 'Sponsor';
    DataClassification = CustomerContent;
    LookupPageId = SponsorList;
    DrillDownPageId = SponsorList;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Sponsor Number';
            DataClassification = CustomerContent;
            NotBlank = true;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Customer Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Sponsor''s Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Char: Char;
                i: Integer;
                Position: Integer;
                Result: Text;
                Space: Boolean;
            begin
                // Capitalize first letter of each word
                Result := '';
                Space := true;

                for i := 1 to StrLen(Name) do begin
                    Char := Name[i];
                    if Space and (Char <> ' ') then
                        Result += UpperCase(Format(Char))
                    else
                        Result += LowerCase(Format(Char));

                    Space := Char = ' ';
                end;

                Name := Result;
            end;
        }
        field(3; "Address"; Text[100])
        {
            Caption = 'Sponsor''s Address Line 1';
            DataClassification = CustomerContent;
        }
        field(4; "Address 2"; Text[100])
        {
            Caption = 'Sponsor''s Address Line 2';
            DataClassification = CustomerContent;
        }
        field(5; "Active Status"; Boolean)
        {
            Caption = 'Active Status';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(6; "Join Date"; Date)
        {
            Caption = 'Join Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Join Date" = 0D) and (xRec."Join Date" <> 0D) then
                    Error('Join Date cannot be empty once set');
            end;
        }
        field(7; "Sponsorship Level"; Enum "SponsorshipLevel")
        {
            Caption = 'Sponsorship Level';
            DataClassification = CustomerContent;
        }
        field(8; "Sponsor Team"; Code[20])
        {
            Caption = 'Sponsor Team';
            DataClassification = CustomerContent;
            TableRelation = "FOD Team";
        }
        field(9; "Marital Status"; Enum "MaritalStatus")
        {
            Caption = 'Marital Status';
            DataClassification = CustomerContent;
        }
        field(10; "Number of Children"; Integer)
        {
            Caption = 'Number of Children';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(11; "Total Pledge Amount"; Decimal)
        {
            Caption = 'Total Pledge Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Pledge"."Pledge Amount" where("Sponsor No." = field("No.")));
            Editable = false;
        }
        field(12; "Total Contribution Amount"; Decimal)
        {
            Caption = 'Total Contribution Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Contribution"."Contribution Amount" where("Sponsor No." = field("No.")));
            Editable = false;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled);
        if IsHandled then
            exit;

        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Customer Nos.");
            "No." := NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", WorkDate(), true);
            "No. Series" := SalesSetup."Customer Nos.";
        end;

        // 設置預設值
        if "Join Date" = 0D then
            "Join Date" := WorkDate();

        if "Active Status" = false then
            "Active Status" := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Sponsor: Record Sponsor; var IsHandled: Boolean)
    begin
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure AssistEdit(): Boolean
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Customer Nos.");
        if NoSeriesMgt.SelectSeries(SalesSetup."Customer Nos.", '', "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
}
table 99122 Pledge
{
    Caption = 'Pledge';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sponsor No."; Code[20])
        {
            Caption = 'Sponsor No.';
            DataClassification = CustomerContent;
            TableRelation = Sponsor;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Pledge Date"; Date)
        {
            Caption = 'Pledge Date';
            DataClassification = CustomerContent;
        }
        field(4; "Pledge Amount"; Decimal)
        {
            Caption = 'Pledge Amount';
            DataClassification = CustomerContent;
            MinValue = 25;

            trigger OnValidate()
            begin
                if "Pledge Amount" < 25 then
                    Error('Pledge Amount must be at least $25.00');
            end;
        }
    }

    keys
    {
        key(PK; "Sponsor No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Pledge: Record Pledge;
    begin
        if "Line No." = 0 then begin
            Pledge.SetRange("Sponsor No.", "Sponsor No.");
            if Pledge.FindLast() then
                "Line No." := Pledge."Line No." + 10000
            else
                "Line No." := 10000;
        end;
    end;
}
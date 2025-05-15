table 99123 Contribution
{
    Caption = 'Contribution';
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
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Contribution Date"; Date)
        {
            Caption = 'Contribution Date';
            DataClassification = CustomerContent;
        }
        field(5; "Contribution Amount"; Decimal)
        {
            Caption = 'Contribution Amount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Sponsor No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
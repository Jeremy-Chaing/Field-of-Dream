table 99132 "Game Header"
{
    Caption = 'Game Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Game No."; Code[20])
        {
            Caption = 'Game No.';
            DataClassification = CustomerContent;
        }
        field(2; Season; Integer)
        {
            Caption = 'Season';
            DataClassification = CustomerContent;
        }
        field(3; Date; Date)
        {
            Caption = 'Game Date';
            DataClassification = CustomerContent;
        }
        field(4; "Win Team"; Code[20])
        {
            Caption = 'Win Team';
            DataClassification = CustomerContent;
            TableRelation = "FOD Team";
        }
        field(5; "Lose Team"; Code[20])
        {
            Caption = 'Lose Team';
            DataClassification = CustomerContent;
            TableRelation = "FOD Team";
        }
    }

    keys
    {
        key(PK; "Game No.")
        {
            Clustered = true;
        }
        key(K2; Date)
        {
        }
    }
}
table 99124 "Game Result"
{
    Caption = 'Game Result';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Game No."; Code[20])
        {
            Caption = 'Game No.';
            DataClassification = CustomerContent;
            TableRelation = "Game Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Team"; Code[20])
        {
            Caption = 'Team';
            DataClassification = CustomerContent;
            TableRelation = "FOD Team";
        }
        field(4; "Team Type"; Enum "Team Type")
        {
            Caption = 'Team Type';
            DataClassification = CustomerContent;
        }
        field(5; "Point"; Integer)
        {
            Caption = 'Point';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GameHeader: Record "Game Header";
                OtherGameResult: Record "Game Result";
            begin
                if Rec.Point = xRec.Point then
                    exit;

                if not GameHeader.Get(Rec."Game No.") then
                    exit;

                OtherGameResult.SetRange("Game No.", Rec."Game No.");
                OtherGameResult.SetFilter("Line No.", '<>%1', Rec."Line No.");
                if not OtherGameResult.FindFirst() then
                    exit;

                if Rec.Point > OtherGameResult.Point then begin
                    GameHeader."Win Team" := Rec.Team;
                    GameHeader."Lose Team" := OtherGameResult.Team;
                end else begin
                    GameHeader."Win Team" := OtherGameResult.Team;
                    GameHeader."Lose Team" := Rec.Team;
                end;
                GameHeader.Modify();
            end;
        }
    }

    keys
    {
        key(PK; "Game No.", "Line No.")
        {
            Clustered = true;
        }
        key(K2; "Team", "Game No.")
        {
        }
    }
}
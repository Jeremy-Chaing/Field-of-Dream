table 99121 "FOD Team"
{
    Caption = 'Team';
    DataClassification = CustomerContent;
    LookupPageId = TeamList;
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Team Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Team Name';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Team Colors"; Text[100])
        {
            Caption = 'Team Colors';
            DataClassification = CustomerContent;
        }
        field(4; "Manager Code"; Code[20])
        {
            Caption = 'Manager Code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
            NotBlank = true;
        }
        field(5; "Manager Name"; Text[100])
        {
            Caption = 'Manager Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Manager Code")));
            Editable = false;
        }
        field(6; "Activated Status"; Enum "ActivatedStatus")
        {
            Caption = 'Activated Status';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    procedure GetTotalGames(): Integer
    var
        GameResult: Record "Game Result";
        TotalGames: Integer;
    begin
        GameResult.SetRange(Team, Rec.Code);
        TotalGames := GameResult.Count;
        exit(TotalGames);
    end;

    procedure GetWins(): Integer
    var
        GameHeader: Record "Game Header";
        TotalWins: Integer;
    begin
        GameHeader.SetRange("Win Team", Rec.Code);
        TotalWins := GameHeader.Count;
        exit(TotalWins);
    end;

    procedure GetLosses(): Integer
    var
        GameHeader: Record "Game Header";
        TotalLosses: Integer;
    begin
        GameHeader.SetRange("Lose Team", Rec.Code);
        TotalLosses := GameHeader.Count;
        exit(TotalLosses);
    end;

    procedure GetWinningPercentage(): Decimal
    var
        TotalGames: Integer;
        Wins: Integer;
    begin
        TotalGames := GetTotalGames();
        if TotalGames = 0 then
            exit(0);

        Wins := GetWins();
        exit(Round(Wins / TotalGames * 100, 0.01));
    end;
}
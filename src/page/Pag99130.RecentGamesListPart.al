page 99130 "Recent Games ListPart"
{
    ApplicationArea = All;
    Caption = 'Recent Games';
    PageType = ListPart;
    SourceTable = "Game Result";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Game No."; Rec."Game No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the game number.';
                }
                field(GameDate; GameHeader.Date)
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                    ToolTip = 'Specifies the game date.';
                }
                field("Team Type"; Rec."Team Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this team was home or guest.';
                }
                field("Point"; Rec."Point")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the team points.';
                    StyleExpr = IsWinner;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if GameHeader.Get(Rec."Game No.") then
            IsWinner := (GameHeader."Win Team" = TeamCode)
        else
            Clear(GameHeader);
    end;

    trigger OnOpenPage()
    begin
        if TeamCode = '' then
            exit;

        FilterRecentGames();
    end;

    var
        TeamCode: Code[20];
        GameHeader: Record "Game Header";
        IsWinner: Boolean;

    procedure SetTeam(NewTeamCode: Code[20])
    begin
        TeamCode := NewTeamCode;
        if TeamCode <> '' then
            FilterRecentGames();
    end;

    local procedure FilterRecentGames()
    begin
        Rec.Reset();
        Rec.SetRange("Team", TeamCode);
        Rec.SetCurrentKey("Game No.");
        Rec.Ascending(false);
        Rec.SetRange("Game No.", GetLastFiveGames());
    end;

    local procedure GetLastFiveGames() GameNoFilter: Text
    var
        GameResult: Record "Game Result";
        Counter: Integer;
        MaxLength: Integer;
    begin
        MaxLength := 20;
        GameResult.Reset();
        GameResult.SetRange("Team", TeamCode);
        GameResult.SetCurrentKey("Game No.");
        GameResult.Ascending(false);

        if not GameResult.FindSet() then
            exit('');

        GameNoFilter := GameResult."Game No.";
        Counter := 1;

        repeat
            if Counter = 5 then
                break;

            // Check if adding next game number would exceed max length
            if StrLen(GameNoFilter + '|' + GameResult."Game No.") > MaxLength then
                break;

            GameNoFilter += '|' + GameResult."Game No.";
            Counter += 1;
        until GameResult.Next() = 0;
    end;
}
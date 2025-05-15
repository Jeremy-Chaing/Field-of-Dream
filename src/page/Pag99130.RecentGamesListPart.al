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
                    DrillDownPageId = "Game Result Card";
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
                field(OpponentTeam; GetOpponentTeam())
                {
                    ApplicationArea = All;
                    Caption = 'Opponent';
                    ToolTip = 'Specifies the opponent team.';
                    trigger OnDrillDown()
                    var
                        GameResultRec: Record "Game Result";
                        TeamRec: Record "FOD Team";
                    begin
                        GameResultRec.SetRange("Game No.", Rec."Game No.");
                        GameResultRec.SetFilter("Team", '<>%1', Rec.Team);
                        if GameResultRec.FindFirst() then begin
                            // 確保隊伍存在
                            if TeamRec.Get(GameResultRec.Team) then
                                Page.Run(Page::"TeamWorksheet", TeamRec)
                            else
                                Message('Team not found: %1', GameResultRec.Team);
                        end else
                            Message('No opponent found for Game No. %1', Rec."Game No.");

                    end;
                }
                field(Score; GetGameScore())
                {
                    ApplicationArea = All;
                    Caption = 'Score';
                    ToolTip = 'Specifies the final score of the game.';
                    StyleExpr = IsWinner;
                }
                field(Result; GetGameResult())
                {
                    ApplicationArea = All;
                    Caption = 'Result';
                    ToolTip = 'Specifies whether the team won or lost the game.';
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
        FilterGames();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if xRec.Team <> Rec.Team then
            FilterGames();
    end;

    var
        TeamCode: Code[20];
        GameHeader: Record "Game Header";
        IsWinner: Boolean;

    procedure SetTeam(NewTeamCode: Code[20])
    begin
        if TeamCode <> NewTeamCode then begin
            TeamCode := NewTeamCode;
            FilterGames();
            CurrPage.Update(false);
        end;
    end;

    local procedure FilterGames()
    begin
        if TeamCode = '' then
            exit;

        Rec.Reset();
        Rec.SetRange("Team", TeamCode);
        Rec.SetCurrentKey("Game No.");
        Rec.Ascending(false);

        if Rec.FindFirst() then;  // Position on first record
    end;

    local procedure GetOpponentTeam(): Code[20]
    var
        OtherGameResult: Record "Game Result";
    begin
        OtherGameResult.SetRange("Game No.", Rec."Game No.");
        OtherGameResult.SetFilter("Team", '<>%1', TeamCode);
        if OtherGameResult.FindFirst() then
            exit(OtherGameResult.Team);
    end;

    local procedure GetGameScore(): Text
    var
        OtherGameResult: Record "Game Result";
        TeamPoint: Integer;
        OpponentPoint: Integer;
    begin
        TeamPoint := Rec.Point;

        OtherGameResult.SetRange("Game No.", Rec."Game No.");
        OtherGameResult.SetFilter("Team", '<>%1', TeamCode);
        if OtherGameResult.FindFirst() then
            OpponentPoint := OtherGameResult.Point;

        exit(Format(TeamPoint) + ' - ' + Format(OpponentPoint));
    end;

    local procedure GetGameResult(): Text
    begin
        if GameHeader.Get(Rec."Game No.") then
            if GameHeader."Win Team" = TeamCode then
                exit('Win')
            else
                exit('Lose');
        exit('');
    end;
}
page 99124 "TeamWorkSheet"
{
    ApplicationArea = All;
    Caption = 'Team Work Sheet';
    PageType = Card;
    SourceTable = "FOD Team";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Team Code field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Team Name field.';
                }
                field("Manager Code"; Rec."Manager Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manager Code field.';
                }
                field("Manager Name"; Rec."Manager Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manager Name field.';
                }
                field("Team Colors"; Rec."Team Colors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Team Colors field.';
                }
                field("Activated Status"; Rec."Activated Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activated Status field.';
                }
            }
            part(RecentGames; "Recent Games ListPart")
            {
                ApplicationArea = All;
                Caption = 'Recent Games';
                SubPageLink = "Team" = FIELD(Code);
                UpdatePropagation = SubPart;
            }
            group(Statistics)
            {
                field(TotalGames; Rec.GetTotalGames())
                {
                    ApplicationArea = All;
                    Caption = 'Total Games';
                    ToolTip = 'Specifies the total number of games played.';
                    Editable = false;
                }
                field(Wins; Rec.GetWins())
                {
                    ApplicationArea = All;
                    Caption = 'Wins';
                    ToolTip = 'Specifies the number of games won.';
                    Editable = false;
                }
                field(Losses; Rec.GetLosses())
                {
                    ApplicationArea = All;
                    Caption = 'Losses';
                    ToolTip = 'Specifies the number of games lost.';
                    Editable = false;
                }
                field(WinningPercentage; Rec.GetWinningPercentage())
                {
                    ApplicationArea = All;
                    Caption = 'Winning Percentage';
                    ToolTip = 'Specifies the winning percentage.';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.RecentGames.Page.SetTeam(Rec.Code);
    end;

    trigger OnOpenPage()
    begin
        CurrPage.RecentGames.Page.SetTeam(Rec.Code);
    end;
}

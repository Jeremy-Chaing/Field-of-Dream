page 99129 "Game Result Card"
{
    ApplicationArea = All;
    Caption = 'Game Result Card';
    PageType = Card;
    SourceTable = "Game Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Game No."; Rec."Game No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the game number.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the game date.';
                }
                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the season.';
                }
                field("Win Team"; Rec."Win Team")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the winning team.';
                }
                field("Lose Team"; Rec."Lose Team")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the losing team.';
                }
            }
            part(Lines; "Game Result Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Game No." = FIELD("Game No.");
            }
        }
    }
}
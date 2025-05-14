page 99128 "Game Result List"
{
    ApplicationArea = All;
    Caption = 'Game Result List';
    PageType = List;
    SourceTable = "Game Header";
    UsageCategory = Lists;
    CardPageId = "Game Result Card";

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
        }
    }
}
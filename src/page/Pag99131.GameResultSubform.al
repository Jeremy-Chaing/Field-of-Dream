page 99131 "Game Result Subform"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "Game Result";
    AutoSplitKey = true;

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
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                }
                field("Team"; Rec."Team")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the team code.';
                }
                field("Team Type"; Rec."Team Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the team was home or guest.';
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
    var
        GameHeader: Record "Game Header";
    begin
        GameHeader.Get(Rec."Game No.");
        IsWinner := (GameHeader."Win Team" = Rec."Team");
    end;

    var
        IsWinner: Boolean;
}
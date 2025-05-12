page 99127 TeamList
{
    ApplicationArea = All;
    Caption = 'Team List';
    PageType = List;
    SourceTable = "FOD Team";
    UsageCategory = Lists;
    CardPageId = TeamWorkSheet;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the team code.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the team name.';
                }
                field("Manager Code"; Rec."Manager Code")
                {
                    ToolTip = 'Specifies the value of the Manager Code field.', Comment = '%';
                }
                field("Manager Name"; Rec."Manager Name")
                {
                    ToolTip = 'Specifies the value of the Manager Name field.', Comment = '%';
                }
                field("Team Colors"; Rec."Team Colors")
                {
                    ToolTip = 'Specifies the value of the Team Colors field.', Comment = '%';
                }
                field("Activated Status"; Rec."Activated Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the team is active.';
                    StyleExpr = StatusStyleTxt;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StatusStyleTxt := SetStatusStyle();
    end;

    local procedure SetStatusStyle(): Text
    begin
        if Rec."Activated Status" = Rec."Activated Status"::Active then
            exit('Favorable')
        else
            exit('Unfavorable');
    end;

    var
        StatusStyleTxt: Text;
}

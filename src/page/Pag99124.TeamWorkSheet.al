page 99124 TeamWorkSheet
{
    ApplicationArea = All;
    Caption = 'TeamWorkSheet';
    PageType = Worksheet;
    SourceTable = "FOD Team";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Team Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Team Name field.', Comment = '%';
                }
                field("Manager Code"; Rec."Manager Code")
                {
                    ToolTip = 'Specifies the value of the Manager Code field.', Comment = '%';
                }
                field("Manager Name"; Rec."Manager Name")
                {
                    ToolTip = 'Specifies the value of the Manager Name field.', Comment = '%';
                }
                field("Activated Status"; Rec."Activated Status")
                {
                    ToolTip = 'Specifies the value of the Activated Status field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Team Colors"; Rec."Team Colors")
                {
                    ToolTip = 'Specifies the value of the Team Colors field.', Comment = '%';
                }
            }
        }
    }
}

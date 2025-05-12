page 99122 PledgeList
{
    ApplicationArea = All;
    Caption = 'PledgeList';
    PageType = List;
    SourceTable = Pledge;
    UsageCategory = Lists;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Pledge Amount"; Rec."Pledge Amount")
                {
                    ToolTip = 'Specifies the value of the Pledge Amount field.', Comment = '%';
                }
                field("Pledge Date"; Rec."Pledge Date")
                {
                    ToolTip = 'Specifies the value of the Pledge Date field.', Comment = '%';
                }
                field("Sponsor No."; Rec."Sponsor No.")
                {
                    ToolTip = 'Specifies the value of the Sponsor No. field.', Comment = '%';
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
            }
        }
    }
}

page 99120 SponsorList
{
    ApplicationArea = All;
    Caption = 'SponsorList';
    PageType = List;
    SourceTable = Sponsor;
    UsageCategory = Lists;
    CardPageId = SponsorCard;
    Editable = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the sponsor.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update(false);
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the sponsor.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used for the sponsor.';
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the address of the sponsor.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the second line of the address of the sponsor.';
                }
                field("Join Date"; Rec."Join Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the sponsor joined.';
                }
                field("Active Status"; Rec."Active Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the sponsor is active.';
                }
                field("Sponsorship Level"; Rec."Sponsorship Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the level of sponsorship.';
                }
                field("Sponsor Team"; Rec."Sponsor Team")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the team the sponsor is supporting.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marital status of the sponsor.';
                }
                field("Number of Children"; Rec."Number of Children")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of children the sponsor has.';
                }
                field("Total Contribution Amount"; Rec."Total Contribution Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount contributed by the sponsor.';
                }
                field("Total Pledge Amount"; Rec."Total Pledge Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount pledged by the sponsor.';
                }
            }
        }
    }
}

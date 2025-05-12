page 99121 SponsorCard
{
    PageType = Card;
    SourceTable = Sponsor;
    Caption = 'Sponsor Card';
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the sponsor.';
                    Importance = Promoted;

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
                    Importance = Promoted;
                    ShowMandatory = true;
                    NotBlank = true;
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
            }

            group(Details)
            {
                field("Sponsorship Level"; Rec."Sponsorship Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the level of sponsorship.';
                }
                field("Sponsor Team"; Rec."Sponsor Team")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the team the sponsor is supporting.';
                    Lookup = true;
                    LookupPageId = TeamList;
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
            }

            group(Financial)
            {
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

            group(Pledges)
            {
                part(Pledge; PledgeListPart)
                {
                    ApplicationArea = All;
                    SubPageLink = "Sponsor No." = FIELD("No.");
                    Caption = 'Pledges for Sponsor';
                }
            }

            group(Contributions)
            {
                part(Contribution; ContributionListPart)
                {
                    ApplicationArea = All;
                    SubPageLink = "Sponsor No." = FIELD("No.");
                    Caption = 'Contributions for Sponsor';
                }
            }


        }


    }

    //自行增加按鈕功能新增Pledge和Contribution
    actions
    {
        area(processing)
        {
            action(CreateNewPledge)
            {
                Caption = 'Create Pledge';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PledgeRec: Record Pledge;
                begin
                    PledgeRec.Init();
                    PledgeRec."Sponsor No." := Rec."No.";
                    PledgeRec.Insert(true);
                    CurrPage.Update(false);
                end;
            }

            action(CreateNewContribution)
            {
                Caption = 'Create Contribution';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ContributionRec: Record Contribution;
                begin
                    ContributionRec.Init();
                    ContributionRec."Sponsor No." := Rec."No.";
                    ContributionRec.Insert(true);
                    CurrPage.Update(false);
                end;
            }

            action(OpenSponsorList)
            {
                Caption = 'Sponsor List (F5)';
                ApplicationArea = All;
                RunObject = Page "SponsorList";
            }
        }
    }
}
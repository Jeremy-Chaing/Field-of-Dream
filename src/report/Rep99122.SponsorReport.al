report 99122 "Sponsor Report"
{
    ApplicationArea = All;
    Caption = 'Sponsor Report';
    UsageCategory = ReportsAndAnalysis;
    RDLClayout = 'src/report/layout/Sponsorreport.rdl';

    dataset
    {
        dataitem(Sponsor; Sponsor)
        {
            RequestFilterFields = "No.";

            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(JoinDate; "Join Date")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; "Address 2")
            {
            }
            column(NumberofChildren; "Number of Children")
            {
            }
            column(MaritalStatus; "Marital Status")
            {
            }
            column(SponsorTeam; "Sponsor Team")
            {
            }
            column(SponsorshipLevel; "Sponsorship Level")
            {
            }
            dataitem(Pledge; Pledge)
            {
                DataItemLinkReference = Sponsor;
                DataItemLink = "Sponsor No." = field("No.");
                //下面的篩選會不見
                //DataItemTableView = sorting("Sponsor No.", "Line No.");
                column(Pledge_LineNo; "Line No.")
                {
                }
                column(PledgeDate; "Pledge Date")
                {
                }
                column(PledgeAmount; "Pledge Amount")
                {
                }

            }
            dataitem(Contribution; Contribution)
            {
                DataItemLinkReference = Sponsor;
                DataItemLink = "Sponsor No." = field("No.");
                //下面的篩選會不見
                //DataItemTableView = sorting("Sponsor No.", "Line No.");
                column(Contribution_LineNo; "Line No.")
                {
                }
                column(Contribution_Date; "Contribution Date")
                {
                }
                column(Contribution_Description; Description)
                {
                }
                column(Contribution_Amount; "Contribution Amount")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}

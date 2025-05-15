report 99122 sponsors
{
    ApplicationArea = All;
    Caption = 'sponsors';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/report/layouts/sponsors.rdl';
    dataset
    {
        dataitem(Sponsor; Sponsor)
        {
            RequestFilterFields = "No.";
            PrintOnlyIfDetail = true;
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            dataitem(Pledge; Pledge)
            {
                DataItemLinkReference = Sponsor;
                DataItemLink = "Sponsor No." = field("No.");
                DataItemTableView = sorting("Sponsor No.", "Line No.");

                column(Pledge_Line_No_; "Line No.") { }
                column(Pledge_Amount; "Pledge Amount") { }
                column(Pledge_Date; "Pledge Date") { }
            }
            dataitem(Contribution; Contribution)
            {
                DataItemLinkReference = Sponsor;
                DataItemLink = "Sponsor No." = field("No.");
                DataItemTableView = sorting("Sponsor No.", "Line No.");

                column(Contribution_Line_No_; "Line No.") { }
                column(Contribution_Description; Description) { }
                column(Contribution_Amount; "Contribution Amount") { }
                column(Contribution_Date; "Contribution Date") { }
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

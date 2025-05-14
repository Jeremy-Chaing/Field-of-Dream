page 99132 "Regenerate Game Data"
{
    Caption = 'Regenerate Game Data';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            label(ConfirmLabel)
            {
                ApplicationArea = All;
                Caption = 'This will delete all existing game data and generate new test data. Are you sure you want to continue?';
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        GameResultTestData: Codeunit "Game Result Test Data";
    begin
        if CloseAction = Action::OK then
            GameResultTestData.RegenerateGameData();
    end;
}
report 99121 "Import Sponsor Team Data New"
{
    Caption = 'Import Sponsor and Team Data';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = '選項';
                    field(ImportOption; ImportOption)
                    {
                        ApplicationArea = All;
                        Caption = '匯入選項';
                        ToolTip = '選擇要匯入的資料類型';
                        OptionCaption = '全部,只匯入團隊,只匯入贊助商';

                        trigger OnValidate()
                        begin
                            ShowWarningOnTeamImport();
                        end;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        ImportExcelData();
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        FODTeamRec: Record "FOD Team";
        SponsorRec: Record Sponsor;
        FileInStream: InStream;
        SheetName: Text;
        FileName: Text;
        ImportOption: Option All,TeamOnly,SponsorOnly;
        NoTeamErr: Label '找不到團隊 %1', Comment = '%1 = Team Name';
        DuplicateTeamErr: Label '團隊 %1 已存在，此筆資料已跳過', Comment = '%1 = Team Code';
        DuplicateSponsorErr: Label '贊助商 %1 已存在', Comment = '%1 = Sponsor No.';
        SuccessMsg: Label '匯入完成！已匯入 %1 個團隊和 %2 個贊助商。\跳過 %3 個重複的團隊。\n總共讀取 %4 列資料。', Comment = '%1 = Team Count, %2 = Sponsor Count, %3 = Skipped Count, %4 = Total Rows';
        TeamImportWarningMsg: Label '注意：匯入團隊資料時，請確保Excel檔案中的團隊代碼不重複。';
        TeamCount: Integer;
        SponsorCount: Integer;
        SkippedCount: Integer;
        TotalRowCount: Integer;
        SPRec: Record "Salesperson/Purchaser";
        NoManagerErr: Label '找不到管理者代碼 %1', Comment = '%1 = Manager Code';
        ProgressDialog: Dialog;
        ProgressMsg: Label '正在處理第 #1## 列...';
        TotalRows: Integer;
    //DebugMsg: Label '處理第 %1 列，團隊代碼: %2，團隊名稱: %3', Comment = '%1 = Row No, %2 = Team Code, %3 = Team Name';

    local procedure ImportExcelData()
    begin
        if not UploadIntoStream('選擇Excel檔案', '', 'Excel Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*', FileName, FileInStream) then
            exit;

        // 清除暫存資料
        ExcelBuffer.DeleteAll();
        Clear(TeamCount);
        Clear(SponsorCount);
        Clear(SkippedCount);
        Clear(TotalRowCount);

        // 讀取Excel檔案
        SheetName := ExcelBuffer.SelectSheetsNameStream(FileInStream);
        ExcelBuffer.OpenBookStream(FileInStream, SheetName);
        ExcelBuffer.ReadSheet();

        // 取得總列數
        ExcelBuffer.Reset();
        if ExcelBuffer.FindLast() then begin
            TotalRows := ExcelBuffer."Row No.";
            Message('Excel總列數: %1', TotalRows);
        end;

        // 顯示進度對話框
        ProgressDialog.Open(ProgressMsg);

        // 根據選項處理資料
        case ImportOption of
            ImportOption::All:
                begin
                    ImportTeams();
                    ImportSponsors();
                end;
            ImportOption::TeamOnly:
                ImportTeams();
            ImportOption::SponsorOnly:
                ImportSponsors();
        end;

        ProgressDialog.Close();
        Message(SuccessMsg, TeamCount, SponsorCount, SkippedCount, TotalRows);
    end;

    local procedure ImportTeams()
    var
        TeamCode: Code[20];
        TeamName: Text[100];
        TeamColors: Text[100];
        ManagerCode: Code[20];
        RowNo: Integer;
        ErrorOccurred: Boolean;
        TempLocation: Record "FOD Team";
    begin
        // 遍歷每一列
        for RowNo := 2 to TotalRows do begin  // 從第2列開始（跳過標題）
            Clear(ErrorOccurred);
            ProgressDialog.Update(1, RowNo);

            TeamCode := GetValueAtCell(RowNo, 1);  // A欄：團隊代碼
            TeamName := GetValueAtCell(RowNo, 2);  // B欄：團隊名稱

            //Message(DebugMsg, RowNo, TeamCode, TeamName);

            if TeamCode <> '' then begin
                // 讀取Excel資料
                ManagerCode := GetValueAtCell(RowNo, 3);  // C欄：管理者代碼
                TeamColors := GetValueAtCell(RowNo, 4);  // D欄：團隊顏色

                // 驗證管理者是否存在
                if ManagerCode <> '' then begin
                    SPRec.Reset();
                    SPRec.SetRange(Code, ManagerCode);
                    if not SPRec.FindFirst() then begin
                        Message(NoManagerErr, ManagerCode);
                        ErrorOccurred := true;
                    end;
                end;

                if not ErrorOccurred then begin
                    // 使用Get方法檢查團隊是否存在
                    TempLocation := FODTeamRec;
                    if not FODTeamRec.Get(TeamCode) then begin
                        // 如果不存在，則新增記錄
                        FODTeamRec.Init();
                        FODTeamRec.Validate(Code, TeamCode);
                        FODTeamRec.Insert(true);
                        TeamCount += 1;
                    end;

                    // 無論是新增還是修改，都更新其他欄位
                    FODTeamRec.Validate(Name, TeamName);
                    FODTeamRec.Validate("Manager Code", ManagerCode);
                    FODTeamRec.Validate("Team Colors", TeamColors);
                    FODTeamRec.Validate("Activated Status", FODTeamRec."Activated Status"::Active);
                    FODTeamRec.Modify(true);
                end;
            end;
        end;
    end;

    local procedure ImportSponsors()
    var
        SponsorNo: Code[20];
        SponsorName: Text[100];
        TeamCode: Code[20];
        SponsorshipLevel: Integer;
        Address: Text[100];
        Address2: Text[100];
        ActiveStatus: Boolean;
        JoinDate: Date;
        MaritalStatus: Option " ",Single,Married,Divorced,Widowed;
        NumberOfChildren: Integer;
        RowNo: Integer;
        ErrorOccurred: Boolean;
        TempLocation: Record Sponsor;
    begin
        // 遍歷每一列
        for RowNo := 2 to TotalRows do begin  // 從第2列開始（跳過標題）
            Clear(ErrorOccurred);
            ProgressDialog.Update(1, RowNo);

            SponsorNo := GetValueAtCell(RowNo, 1);  // A欄：贊助商編號
            SponsorName := GetValueAtCell(RowNo, 2);  // B欄：贊助商名稱

            //Message(DebugMsg, RowNo, SponsorNo, SponsorName);

            if SponsorNo <> '' then begin
                // 讀取Excel資料
                TeamCode := GetValueAtCell(RowNo, 3);  // C欄：團隊代碼
                Evaluate(SponsorshipLevel, GetValueAtCell(RowNo, 4));  // D欄：贊助等級
                Address := GetValueAtCell(RowNo, 5);  // E欄：地址
                Address2 := GetValueAtCell(RowNo, 6);  // F欄：地址2
                Evaluate(ActiveStatus, GetValueAtCell(RowNo, 7));  // G欄：啟用狀態
                Evaluate(JoinDate, GetValueAtCell(RowNo, 8));  // H欄：加入日期
                Evaluate(MaritalStatus, GetValueAtCell(RowNo, 9));  // I欄：婚姻狀態
                Evaluate(NumberOfChildren, GetValueAtCell(RowNo, 10));  // J欄：子女數量

                // 驗證團隊是否存在
                if TeamCode <> '' then begin
                    FODTeamRec.Reset();
                    FODTeamRec.SetRange(Code, TeamCode);
                    FODTeamRec.SetRange("Activated Status", FODTeamRec."Activated Status"::Active);
                    if not FODTeamRec.FindFirst() then begin
                        Message(NoTeamErr, TeamCode);
                        ErrorOccurred := true;
                    end;
                end;

                if not ErrorOccurred then begin
                    // 使用Get方法檢查贊助商是否存在
                    TempLocation := SponsorRec;
                    if not SponsorRec.Get(SponsorNo) then begin
                        // 如果不存在，則新增記錄
                        SponsorRec.Init();
                        SponsorRec.Validate("No.", SponsorNo);
                        SponsorRec.Insert(true);
                        SponsorCount += 1;
                    end;

                    // 無論是新增還是修改，都更新其他欄位
                    SponsorRec.Validate(Name, SponsorName);
                    SponsorRec.Validate("Sponsor Team", TeamCode);
                    SponsorRec.Validate("Sponsorship Level", SponsorshipLevel);
                    SponsorRec.Validate(Address, Address);
                    SponsorRec.Validate("Address 2", Address2);
                    SponsorRec.Validate("Active Status", ActiveStatus);
                    SponsorRec.Validate("Join Date", JoinDate);
                    SponsorRec.Validate("Marital Status", MaritalStatus);
                    SponsorRec.Validate("Number of Children", NumberOfChildren);
                    SponsorRec.Modify(true);
                end;
            end;
        end;
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        ExcelBuffer.Reset();
        ExcelBuffer.SetRange("Row No.", RowNo);
        ExcelBuffer.SetRange("Column No.", ColNo);
        if ExcelBuffer.FindFirst() then
            exit(ExcelBuffer."Cell Value as Text".Trim());
        exit('');
    end;

    local procedure ShowWarningOnTeamImport()
    begin
        if ImportOption = ImportOption::TeamOnly then
            Message(TeamImportWarningMsg);
    end;
}
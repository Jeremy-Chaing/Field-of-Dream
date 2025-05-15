# Field of Dream

Field of Dreams Funding (FDF) 是一個非營利組織，負責為青少棒（Little League Baseball）球隊尋找企業或個人贊助者。他們希望使用 Navision Solutions 來管理他們的內部會計及贊助管理系統。

## confirm

- Worksheet
- ~~Where is TEAM.TXT~~
- Sponsor Team column in sponsor table
- Sponsor address(at least 2 lines)

## table

- 贊助者（Sponsor）資料表 (99120)

        Sponsor Number：贊助者編號（每個贊助者需有唯一編號）

        Sponsor's Name：贊助者名稱（每個單字的首字母需大寫）(用原生 No. Series 自動取號 參考customer/vendor/item)

        Sponsor's Address：至少兩行地址

        Active Status：是否為活躍贊助者（預設大多數為活躍）

        Join Date：加入日期（不可清空已填入的日期）

        Sponsorship Level：贊助級別（Rookie、Major League、All-Star、Hall-of-Fame）

        Sponsor Team：主要贊助的球隊（每個贊助者主要支持一支球隊）

        Marital Status：婚姻狀況（Single、Married、Divorced、Widowed、Other）

        Number of Children：子女數量

- 贊助承諾（Pledge）資料表 (99122)

        Line No.：行號（用於識別每筆承諾）(Use AutoSplitKey)

        Sponsor No.：贊助者編號

        Pledge Date：承諾日期

        Pledge Amount：承諾金額（最低 $25.00）

- 贊助捐款（Contribution）資料表 (99123)

        Line No.：行號（用於識別每筆捐款）

        Sponsor No.：贊助者編號

        Description：簡短描述

        Contribution Date：捐款日期

        Contribution Amount：捐款金額

- 球隊（Team）資料表 (99121)

        Code：球隊代碼（簡短名稱）

        Team Name：球隊名稱（例如 Marlins, Cubs）

        Team Colors：球隊顏色

        Manager Code：經理代碼（來自 Salesperson/Purchaser 表）

        Manager Name：經理名稱（FlowField）

        Activated Status：啟用/停用狀態

## Spec

F6 查詢功能：

- [x] Sponsor Team 欄位需要支援 F6 查詢到 Team 表

FlowFields：

- [x] 每個 Sponsor 都應顯示總承諾金額與總捐款金額

表單類型：

- [x] Sponsor 需要卡片（Card）與清單（List）表單

- [x] Team 需要工作表（Worksheet）表單

- [x] Pledge 和 Contribution 需要 Tabular 表單

- [x] 自動編號：Pledge 和 Contribution 需要 AutoSplitKey 屬性來自動產生行號

分頁連結：

- [x] ~~Sponsor Card 上需要分別加入進入 Pledge 與 Contribution 的按鈕~~ pledge 跟 contribution 改為 sponsor 的明細行顯示在 sponsor card 即可

- [x] Menu Button 需要支援 List (F5) 功能

資料匯入：

- [x] ~~使用 Dataport 匯入 Team 和 Sponsor 資料~~ ==> import 改為用 processing only report吃 excel 檔案, 要能匯入 sponsor/team 的基本資料寫成一支或兩支都可以 (processing only report 是 report 物件, property 有一個 processing only 設為 true 即可)

資料來源為 TEAM.TXT（Comma-delimited）

報表需求：

- [ ] 顯示每個 Sponsor 的總承諾與捐款

- [ ] 需要三個 DataItems 來生成報表，報表要有表頭表身, 試試看用 setdata/getdata 輸出表頭的資料

## Precautions

- [X] Make sure to use object numbers in the range 99120 – 99129 for all of the objects.
- [x] Table ~~option~~ ==> Enum

## Extra features

- [x] 戰績追蹤
  - 於Team card 畫面用ListPart做一個Subform顯示球隊近五場比賽結果及目前排名
  
- [x] 球季比賽結果table
  - 有戰績追蹤勢必就需要一個比賽結果總表table 但僅於 Team card 畫面顯示近五場之比賽結果

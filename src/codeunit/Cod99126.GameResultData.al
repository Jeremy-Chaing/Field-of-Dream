codeunit 99126 "Game Result Data"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InsertGameResults();
    end;

    local procedure InsertGameResults()
    var
        GameHeader: Record "Game Header";
        GameResult: Record "Game Result";
    begin
        if not GameHeader.IsEmpty then
            exit;

        // LAA Games
        InsertGame(GameHeader, GameResult, 'G001', 2024, 20240301D, 'LAA', 'NYY', 5, 3);
        InsertGame(GameHeader, GameResult, 'G002', 2024, 20240303D, 'BOS', 'LAA', 6, 2);
        InsertGame(GameHeader, GameResult, 'G003', 2024, 20240305D, 'LAA', 'TOR', 4, 2);
        InsertGame(GameHeader, GameResult, 'G004', 2024, 20240307D, 'TEX', 'LAA', 3, 7);
        InsertGame(GameHeader, GameResult, 'G005', 2024, 20240309D, 'DET', 'LAA', 5, 2);

        // NYM Games
        InsertGame(GameHeader, GameResult, 'G006', 2024, 20240302D, 'NYM', 'LAD', 6, 4);
        InsertGame(GameHeader, GameResult, 'G007', 2024, 20240304D, 'AZD', 'NYM', 3, 5);
        InsertGame(GameHeader, GameResult, 'G008', 2024, 20240306D, 'NYM', 'BOS', 2, 1);
        InsertGame(GameHeader, GameResult, 'G009', 2024, 20240308D, 'TB', 'NYM', 4, 6);
        InsertGame(GameHeader, GameResult, 'G010', 2024, 20240310D, 'NYM', 'TEX', 3, 5);

        // AZD Games
        InsertGame(GameHeader, GameResult, 'G011', 2024, 20240311D, 'AZD', 'LAA', 4, 3);
        InsertGame(GameHeader, GameResult, 'G012', 2024, 20240313D, 'NYY', 'AZD', 2, 5);
        InsertGame(GameHeader, GameResult, 'G013', 2024, 20240315D, 'AZD', 'LAD', 6, 4);
        InsertGame(GameHeader, GameResult, 'G014', 2024, 20240317D, 'TOR', 'AZD', 3, 4);
        InsertGame(GameHeader, GameResult, 'G015', 2024, 20240319D, 'AZD', 'BOS', 5, 2);

        // NYY Games
        InsertGame(GameHeader, GameResult, 'G016', 2024, 20240312D, 'NYY', 'TB', 7, 3);
        InsertGame(GameHeader, GameResult, 'G017', 2024, 20240314D, 'DET', 'NYY', 4, 6);
        InsertGame(GameHeader, GameResult, 'G018', 2024, 20240316D, 'NYY', 'TEX', 5, 3);
        InsertGame(GameHeader, GameResult, 'G019', 2024, 20240318D, 'LAD', 'NYY', 3, 4);
        InsertGame(GameHeader, GameResult, 'G020', 2024, 20240320D, 'NYY', 'TOR', 6, 2);

        // LAD Games
        InsertGame(GameHeader, GameResult, 'G021', 2024, 20240321D, 'LAD', 'BOS', 5, 4);
        InsertGame(GameHeader, GameResult, 'G022', 2024, 20240323D, 'TB', 'LAD', 3, 6);
        InsertGame(GameHeader, GameResult, 'G023', 2024, 20240325D, 'LAD', 'DET', 4, 2);
        InsertGame(GameHeader, GameResult, 'G024', 2024, 20240327D, 'TEX', 'LAD', 2, 5);
        InsertGame(GameHeader, GameResult, 'G025', 2024, 20240329D, 'LAD', 'TOR', 6, 3);
    end;

    local procedure InsertGame(var GameHeader: Record "Game Header"; var GameResult: Record "Game Result"; GameNo: Code[20]; Season: Integer; GameDate: Date; HomeTeam: Code[20]; GuestTeam: Code[20]; HomePoint: Integer; GuestPoint: Integer)
    begin
        // Insert Header
        GameHeader.Init();
        GameHeader."Game No." := GameNo;
        GameHeader.Season := Season;
        GameHeader.Date := GameDate;
        if HomePoint > GuestPoint then begin
            GameHeader."Win Team" := HomeTeam;
            GameHeader."Lose Team" := GuestTeam;
        end else begin
            GameHeader."Win Team" := GuestTeam;
            GameHeader."Lose Team" := HomeTeam;
        end;
        GameHeader.Insert();

        // Insert Home Team Line
        GameResult.Init();
        GameResult."Game No." := GameNo;
        GameResult."Line No." := 10000;
        GameResult.Team := HomeTeam;
        GameResult."Team Type" := Enum::"Team Type"::Home;
        GameResult.Point := HomePoint;
        GameResult.Insert();

        // Insert Guest Team Line
        GameResult.Init();
        GameResult."Game No." := GameNo;
        GameResult."Line No." := 20000;
        GameResult.Team := GuestTeam;
        GameResult."Team Type" := Enum::"Team Type"::Guest;
        GameResult.Point := GuestPoint;
        GameResult.Insert();
    end;
}
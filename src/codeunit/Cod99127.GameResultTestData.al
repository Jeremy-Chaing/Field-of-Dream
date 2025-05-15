codeunit 99127 "Game Result Test Data"
{
    procedure RegenerateGameData()
    begin
        DeleteExistingData();
        InsertNewGameData();
    end;

    local procedure DeleteExistingData()
    var
        GameHeader: Record "Game Header";
        GameResult: Record "Game Result";
    begin
        GameResult.DeleteAll();
        GameHeader.DeleteAll();
    end;

    local procedure InsertNewGameData()
    var
        GameHeader: Record "Game Header";
        GameResult: Record "Game Result";
        TeamList: List of [Code[20]];
        HomeTeam, GuestTeam : Code[20];
        GameNo: Integer;
        GameDate: Date;
        i: Integer;
    begin
        // Add teams to list
        TeamList.Add('LAA');
        TeamList.Add('NYY');
        TeamList.Add('BOS');
        TeamList.Add('TOR');
        TeamList.Add('TEX');
        TeamList.Add('DET');
        TeamList.Add('NYM');
        TeamList.Add('LAD');
        TeamList.Add('AZD');
        TeamList.Add('TB');

        GameNo := 1;
        GameDate := 20240301D;

        // Generate 10 games for each team
        for i := 1 to TeamList.Count do begin
            HomeTeam := TeamList.Get(i);

            // Each team plays with every other team
            foreach GuestTeam in TeamList do begin
                if HomeTeam <> GuestTeam then begin
                    InsertGame(
                        GameHeader,
                        GameResult,
                        Format(GameNo, 4, '0000'),
                        2024,
                        GameDate,
                        HomeTeam,
                        GuestTeam,
                        GetRandomScore(),
                        GetRandomScore()
                    );
                    GameNo += 1;
                    GameDate := CalcDate('<+1D>', GameDate);
                end;
            end;
        end;
    end;

    local procedure GetRandomScore(): Integer
    begin
        exit(Random(10));
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
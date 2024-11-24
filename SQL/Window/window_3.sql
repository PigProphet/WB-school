-- Создание таблицы
CREATE TABLE query (
    searchid SERIAL PRIMARY KEY,
    "year" INT,
    "month" INT,
    "day" INT,
    userid INT,
    ts BIGINT,
    devicetype VARCHAR(30),
    deviceid INT,
    query TEXT
);

-- Заполнение таблицы данными
INSERT INTO query ("year", "month", "day", userid, ts, devicetype, deviceid, query) VALUES
(2024, 11, 24, 1, 1732060800, 'android', 101, 'с'),
(2024, 11, 24, 1, 1732060830, 'android', 101, 'см'),
(2024, 11, 24, 1, 1732060860, 'android', 101, 'сма'),
(2024, 11, 24, 1, 1732060890, 'android', 101, 'смартфон'),
(2024, 11, 24, 1, 1732060920, 'android', 101, 'смартфон недорогой'),
(2024, 11, 24, 2, 1732061000, 'ios', 202, 'книги'),
(2024, 11, 24, 2, 1732061060, 'ios', 202, 'книги фэнтези'),
(2024, 11, 24, 3, 1732061200, 'android', 303, 'наушники'),
(2024, 11, 24, 3, 1732061260, 'android', 303, 'наушники беспроводные'),
(2024, 11, 24, 3, 1732061320, 'android', 303, 'наушники sony'),
(2024, 11, 24, 4, 1732061500, 'android', 404, 'ноутбук'),
(2024, 11, 24, 4, 1732061560, 'android', 404, 'ноутбук игровой'),
(2024, 11, 24, 4, 1732065000, 'android', 404, 'ноут'),
(2024, 11, 24, 5, 1732061700, 'desktop', 505, 'кофемашина'),
(2024, 11, 24, 6, 1732061800, 'android', 606, 'фотоаппарат'),
(2024, 11, 24, 6, 1732061860, 'android', 606, 'фотоаппарат зеркальный'),
(2024, 11, 24, 6, 1732062000, 'android', 606, 'фото'),
(2024, 11, 24, 7, 1732062100, 'android', 707, 'велосипед'),
(2024, 11, 24, 7, 1732062160, 'android', 707, 'велосипед горный'),
(2024, 11, 24, 7, 1732062220, 'android', 707, 'вело'),
(2024, 11, 24, 8, 1732062300, 'ios', 808, 'планшет'),
(2024, 11, 24, 9, 1732062400, 'android', 909, 'телевизор'),
(2024, 11, 24, 9, 1732062460, 'android', 909, 'телевизор smart tv'),
(2024, 11, 24, 10, 1732062500, 'android', 1010, 'пылесос робот');

-- Запрос для вычисления is_final и вывода результатов
WITH next_queries AS ( 
    SELECT searchid, "year", "month", "day", userid, ts, devicetype, deviceid, q."query",
        LEAD(ts, 1) OVER w AS "next_ts",
        LEAD(LENGTH(q."query"), 1) OVER w AS "next_length",
        LEAD(q."query", 1, '') OVER w AS "next_query"
    FROM query q 
    WHERE devicetype = 'android' AND 
        "year" = 2024 AND "month" = 11 AND "day" = 24
    WINDOW w AS (PARTITION BY userid, deviceid ORDER BY ts)
),
is_final_queries AS (
    SELECT searchid, "year", "month", "day", userid, ts, devicetype, deviceid, nq."query",
    nq."next_query",
        CASE 
            WHEN "next_ts" IS NULL THEN 1
            WHEN ("next_ts" - ts) > 180 THEN 1
            WHEN LENGTH(nq."query") > "next_length" AND ("next_ts" - ts) > 60 THEN 2
            ELSE 0
        END AS "is_final"
    FROM next_queries nq
)
SELECT "year", "month", "day", userid, ts, devicetype, deviceid, ifq."query", ifq."next_query",
    ifq."is_final"
FROM is_final_queries ifq
WHERE "is_final" IN (1, 2)
ORDER BY userid, ts;
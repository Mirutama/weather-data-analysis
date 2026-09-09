import pandas as pd
import sqlite3

path="data/kanagawa.xlsx"

df=pd.read_excel(path,header=3)
df=df.iloc[2:]

df=df[["年月日",
       "最高気温(℃)",
       "最低気温(℃)",
       "平均気温(℃)",
       "降水量の合計(mm)"]]

# ① SQLiteファイルに接続（なければ作られる）
conn = sqlite3.connect("weather.db")

# ② DataFrameをテーブルとして保存
df.to_sql("weather", conn, if_exists="replace", index=False)

# ③ 保存できたか確認（SQLで件数を見る）
count = conn.execute("SELECT COUNT(*) FROM weather").fetchone()[0]
print("rows in db:", count)

result1 = conn.execute("""
SELECT AVG("平均気温(℃)")
FROM weather;
""").fetchone()[0]



result2 = conn.execute("""
SELECT strftime('%Y-%m', "年月日") AS ym,
       ROUND(AVG("平均気温(℃)"), 2)
FROM weather
GROUP BY ym
ORDER BY ym
""").fetchall()



result3=conn.execute("""
SELECT "年月日",
       "平均気温(℃)",
      ROUND(
       AVG("平均気温(℃)") OVER (
           ORDER BY "年月日"
           ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ), 2
       ) AS moving_avg_7day
FROM weather
ORDER BY"年月日";
""").fetchall()


result4=conn.execute("""
SELECT "年月日",
       "平均気温(℃)",
       ROUND(
              AVG("平均気温(℃)") OVER (
           PARTITION BY strftime('%Y-%m', "年月日")
  ), 2
       ) AS monthly_avg,
       ROUND(
       "平均気温(℃)" -
              AVG("平均気温(℃)") OVER (
           PARTITION BY strftime('%Y-%m', "年月日")
  ), 2
       ) AS diff_from_month
FROM weather      
ORDER BY "年月日";
""").fetchall()


result5=conn.execute("""
                     
SELECT ym, COUNT(*)
FROM (
    SELECT strftime('%Y-%m', "年月日") AS ym,
           ROUND(
               "平均気温(℃)" -
               AVG("平均気温(℃)") OVER (
                   PARTITION BY strftime('%Y-%m', "年月日")
               ), 2
           ) AS diff_from_month
    FROM weather
)
WHERE ABS(diff_from_month) >= 3
GROUP BY ym
ORDER BY COUNT(*) DESC;
""").fetchall()

print("平均気温の平均:", round(result1,2))
print("月別平均気温:", result2)
print("7日移動平均:", result3[:5])
print("月平均との差:", result4[:5])
print("平均との差が±3℃以上の日数:", result5)

conn.close()
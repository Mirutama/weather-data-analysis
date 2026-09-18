# Weather Data Analysis API
気象庁の気象データを題材に、Pythonによるデータ処理から
SQLiteへの保存、SQLによる分析、FastAPIによるAPI化までを実践した学習プロジェクトです。# Weather Data Analysis API

## 概要

気象庁から取得した横浜の気象データをpandasで前処理し、
SQLiteに保存してSQLによる簡単な分析を行っています。

その後、バックエンド開発の学習としてFastAPIを追加し、
SQLiteに保存した気象データをHTTP APIから取得できるようにしました。

データ分析そのものよりも、

Excel → pandas → SQLite → SQL → FastAPI → JSON

というデータ処理からWeb APIまでの一連の流れを理解することを主な目的としています。

## 使用技術

- Python
- pandas
- FastAPI
- Pydantic
- SQLite
- SQL
- Git / GitHub

## データ

気象庁の気象データを使用しています。

- 観測地点：横浜
- 対象期間：2025年12月 ～ 2026年1月
- データ件数：62日分

使用する項目：

- 年月日
- 最高気温
- 最低気温
- 平均気温
- 降水量の合計

## 処理の流れ

1. 気象データをExcelファイルからpandasで読み込む
2. 不要な行を除外する
3. 分析に必要な列を抽出する
4. DataFrameをSQLiteの`weather`テーブルに保存する
5. SQLを使って気温データを分析する

## 分析内容

### 月別平均気温

月ごとの平均気温をSQLで算出します。

```sql
SELECT strftime('%Y-%m', "年月日") AS ym,
       ROUND(AVG("平均気温(℃)"), 2)
FROM weather
GROUP BY ym
ORDER BY ym;
```

### 7日移動平均

SQLのウィンドウ関数を使用し、当日を含む直近7日間の平均気温を算出します。

```sql
AVG("平均気温(℃)") OVER (
    ORDER BY "年月日"
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
)
```

### 月平均との差

各日の平均気温と、その月の平均気温との差をウィンドウ関数で算出します。

### 月平均との差が±3℃以上の日数

月平均から3℃以上離れた日が各月に何日あったかを集計します。

## 分析結果
| 月 | 月別平均気温 | 月平均との差が±3℃以上の日数 |
| --- | ---: | ---: |
| 2025年12月 |	9.26℃ | 7日 |
| 2026年1月 | 6.67℃ | 6日 |

全期間の平均気温は約7.97℃でした。

## API

FastAPIを使用し、SQLiteに保存した気象データを取得するAPIを実装しています。

### エンドポイント

| Method | Endpoint | 内容 |
| --- | --- | --- |
| GET | `/weather/count` | 保存されているデータ件数を取得 |
| GET | `/weather/{year}` | 指定した年の気象データを取得 |
| GET | `/weather/{year}/{month}` | 指定した年月の気象データを取得 |

`/weather/{year}/{month}` では以下のクエリパラメータを利用できます。

- `limit`：取得件数を指定（1〜100、デフォルト10）
- `min_temp`：指定した最高気温以上のデータに絞り込み

また、Path / Queryによる入力値の検証、Pydanticによるレスポンスモデル、
データが存在しない場合の404レスポンスを実装しています。

## APIの実行

```bash
fastapi dev api.py
```

起動後、以下からSwagger UIを確認できます。
http://127.0.0.1:8000/docs
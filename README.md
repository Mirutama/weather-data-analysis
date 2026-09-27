# Weather Data Analysis API

気象庁の気象データを題材に、Pythonによるデータ処理、SQLによる分析、
FastAPIによるWeb API開発、PostgreSQLへのデータ保存、
Docker Composeによるコンテナ環境の構築までを実践した学習プロジェクトです。

## 概要

気象庁から取得した横浜の気象データをpandasで前処理し、
SQLによる簡単な分析を行っています。

その後、バックエンド開発の学習としてFastAPIを使用したWeb APIを実装し、
データベースをSQLiteからPostgreSQLへ移行しました。

さらにFastAPIとPostgreSQLをDockerコンテナ化し、
Docker Composeを使用してAPIとデータベースをまとめて起動できる構成にしています。

APIにはpytestによる自動テストを実装し、
主要なエンドポイントやバリデーションの動作を確認しています。

## 使用技術

- Python 3.13
- pandas
- FastAPI
- Pydantic
- PostgreSQL
- SQL
- psycopg
- pytest
- Docker
- Docker Compose
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

1. 気象庁の気象データをExcelファイルからpandasで読み込む
2. 不要な行を除外し、分析に必要な列を抽出・整形する
3. SQLを使用して気温データを分析する
4. 気象データをPostgreSQLの`weather`テーブルに保存する
5. FastAPIからPostgreSQLへ接続し、気象データを取得する
6. 取得したデータをJSON形式でHTTP APIから返す
7. pytestでAPIのレスポンスやバリデーションをテストする
8. FastAPIとPostgreSQLをDocker Composeでまとめて起動する

## 分析内容

データ分析は、プロジェクト初期にSQLiteを使用して実装しました。
その後、API開発を進める中でデータベースをPostgreSQLへ移行しています。

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

FastAPIを使用し、PostgreSQLに保存した気象データを取得するAPIを実装しています。

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

## セットアップ

### 1. リポジトリをクローン

```bash
git clone https://github.com/Mirutama/weather-data-analysis.git
cd weather-data-analysis
```

### 2. 環境変数を設定

`.env.example`を参考に、プロジェクト直下に`.env`ファイルを作成します。

```env
DB_NAME=weather_db
DB_USER=weather_user
DB_PASSWORD=your_password
```
`DB_PASSWORD`には任意のパスワードを設定してください。

`.env`はGitの管理対象外です。

### 3. Docker Composeで起動

```bash
docker compose up --build
```

初回起動時にPostgreSQLのデータベースが作成され、
`weather_dump.sql`から気象データが読み込まれます。

起動後、Swagger UIからAPIの動作を確認できます。

http://localhost:8000/docs

## テスト

APIコンテナ内でpytestを実行します。

```bash
docker compose exec api pytest
```

以下の項目をテストしています。

- `/weather/count`が正常にデータ件数を返すこと
- データが存在しない場合に404を返すこと
- 不正な入力値に対して422を返すこと
- `limit`で取得件数を制限できること
- `min_temp`で最高気温を条件に絞り込めること

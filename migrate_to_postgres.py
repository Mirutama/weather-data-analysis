import sqlite3
import psycopg 
import os
from dotenv import load_dotenv

sqlite_conn = sqlite3.connect("weather.db")

rows = sqlite_conn.execute("SELECT * FROM weather").fetchall()

load_dotenv()

postgres_conn = psycopg.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD")
)

postgres_cursor = postgres_conn.cursor()

postgres_cursor.executemany(

    "INSERT INTO weather VALUES (%s, %s, %s, %s, %s)",
    rows
)
postgres_conn.commit()

postgres_cursor.close()
sqlite_conn.close()
postgres_conn.close()
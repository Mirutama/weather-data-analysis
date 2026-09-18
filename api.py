import sqlite3

from fastapi import FastAPI, Path, Query, HTTPException
from pydantic import BaseModel

class WeatherResponse(BaseModel):
    date:str
    max_temperature:float
    min_temperature:float
    avg_temperature:float
    rainfall:float

app = FastAPI()

def get_db():
    conn = sqlite3.connect("weather.db")
    return conn

@app.get("/weather/count")
def get_weather_count():
    conn = get_db()
    cursor = conn.execute("SELECT COUNT(*) FROM weather")
    row = cursor.fetchone()
    conn.close()
    return {"count": row[0]}

@app.get("/weather/{year}")
def get_weather_by_year(year: int):
    conn = get_db()

    rows = conn.execute("""
    SELECT * FROM weather
    WHERE strftime('%Y', 年月日) = ?
    """,(str(year),)).fetchall()

    result = []

    for row in rows:
        data = {
            "date": row[0],
            "max_temperature": row[1],
            "min_temperature": row[2],
            "avg_temperature": row[3],
            "rainfall": row[4]
        }

        result.append(data)
    conn.close()
    return result

@app.get("/weather/{year}/{month}",response_model=list[WeatherResponse])

def get_year_and_month(
    year: int,
    month: int = Path(ge=1, le=12),
    limit: int = Query(10, ge=1, le=100),
    min_temp: float | None = Query(None) 
    ):
    conn = get_db()

    try:
    
        sql = """
        SELECT * FROM weather
        WHERE strftime('%Y', 年月日) = ?
        AND strftime('%m', 年月日) = ?
        """
        params =  (str(year), f"{month:02d}")

        if min_temp is not None:
            sql += 'AND "最高気温(℃)" >= ?\n '
            params += (min_temp,)

        sql += "LIMIT ?\n"
        params += (limit,)


        rows = conn.execute(sql, params).fetchall()

        if  rows == []:
            raise HTTPException(
                status_code = 404,
                detail = "Weather data not found"
            ) 

        result = []

        for row in rows:
            data = {
                "date":row[0],
                "max_temperature": row[1],
                "min_temperature": row[2],
                "avg_temperature": row[3],
                "rainfall": row[4]
            }
            result.append(data)

        return result
    
    finally:
        conn.close()
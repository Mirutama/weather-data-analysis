from fastapi.testclient import TestClient
from api import app

TestClient(app)

client = TestClient(app)

def test_weather_count():

    response = client.get("/weather/count")

    assert response.status_code == 200
    assert response.json() == {"count" : 62}

def test_weather_not_found():

    response = client.get("/weather/2024/1")

    assert response.status_code == 404
    assert response.json() == {"detail": "Weather data not found"}

def test_invalid_month():

    response = client.get("/weather/2025/13")

    assert response.status_code == 422

def test_limit():
    response = client.get("/weather/2026/1?limit=3")

    assert response.status_code == 200
    assert len(response.json()) == 3

def test_min_temp():
    response = client.get("/weather/2026/1?min_temp=10")

    assert response.status_code == 200
    assert all( i["max_temperature"]>= 10 for i in response.json() )
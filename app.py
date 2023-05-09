# Dependencies
import pandas as pd
from sqlalchemy import create_engine, func
from flask import Flask, jsonify
from config import pg_user_name, pg_password

# Database Setup
engine = create_engine(f"postgresql://{pg_user_name}:{pg_password}@localhost:5432/superhero_cinema_db")
conn = engine.connect()

# Flask Setup
app = Flask(__name__)

@app.route("/")
def index_page():
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/all-movies<br/>"
        f"/api/v1.0/mcu<br/>"
        f"/api/v1.0/dceu<br/>"
    )

@app.route("/api/v1.0/all-movies")
def all_movies():
    df = pd.read_sql("SELECT * FROM Movies",conn)
    df_json = df.to_dict(orient="records")
    return jsonify(df_json)

@app.route("/api/v1.0/mcu")
def mcu():
    df = pd.read_sql("SELECT * FROM Movies WHERE Franchise='MCU'",conn)
    df_json = df.to_dict(orient="records")
    return jsonify(df_json)

@app.route("/api/v1.0/dceu")
def dceu():
    df = pd.read_sql("SELECT * FROM Movies WHERE Franchise='DCEU'",conn)
    df_json = df.to_dict(orient="records")
    return jsonify(df_json)

if __name__ == '__main__':
    app.run(debug=True)
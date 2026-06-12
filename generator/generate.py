import csv
import random
import os
import sys

NUM_ROWS = 10


COLUMNS = ["duration_time", "ticket_price", "movie_score", "movie_title"]

def generate_row():

    return {
        "duration_time": random.randint(70, 200),
        "ticket_price": round(random.uniform(5.0, 25.0), 2),
        "movie_score": random.randint(0, 100),
        "movie_title": random.choice(["The Devil Wears Prada 2", "Backrooms", "Michael"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)

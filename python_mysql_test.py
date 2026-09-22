import sys

print(sys.executable)
print(sys.version)

import mysql.connector

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Phoenix@261997",
    database="world_tech_layoff"
)

print("Connected successfully!")

connection.close()
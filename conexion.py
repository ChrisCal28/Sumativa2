import pyodbc

# Cadena de conexión
conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=DESKTOP-9D3FH94\SQLEXPRESS;'
    'DATABASE=DBDunder;'
    'Trusted_Connection=yes;'
)
cursor = conn.cursor()

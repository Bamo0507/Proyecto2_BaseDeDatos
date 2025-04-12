set -e

echo "Ejecutando ddl.sql..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /scripts/ddl.sql
echo "ddl.sql completado."

echo "Ejecutando data.sql..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /scripts/data.sql
echo "data.sql completado."
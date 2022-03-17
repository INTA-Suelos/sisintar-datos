# Hay que bajar http://sisinta.inta.gob.ar/es/perfiles.geojson y
# extraer los ids de ahí.

# Usar jq para leer json?
# curl -s 'https://api.github.com/users/lambda' | jq -r '.name'

echo Actualizando perfiles.geojson
curl http://sisinta.inta.gob.ar/es/perfiles.geojson -f -o perfiles.geojson

cat perfiles.geojson | jq -r ".features|.[]|.properties.id" >  id-list.txt

ids=$(cat id-list.txt | tr "\n" ",")
ids=$(echo http://sisinta.inta.gob.ar/es/perfiles/{$ids}.csv)

curl -Z $ids -f -o "perfiles/#1.csv"

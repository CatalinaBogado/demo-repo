#Catalina Bogado, padron:13261, mail:catabogado10@gmail.com, mailGHUB: cbogado@fi.uba.ar
# $./parte_2.sh

#genero rutas de los archivos que voy a usar con find

pokemon_csv=$(find -type f -name "pokemon.csv")
pokemon_abilities_csv=$(find -type f -name "pokemon_abilities.csv")
ability_names_csv=$(find -type f -name "ability_names.csv")

# while read -r me va a leer el input que escriba

#./parte_1.sh 113261 resultados

while read -r nombre_ingresado
do

    #verifico que el nombre del pokemon exista

    if [ $(grep "$nombre_ingresado," $pokemon_csv | wc -l) -eq 1 ]
    then
        id=$(grep "$nombre_ingresado," $pokemon_csv | cut -d"," -f1)
    else
        echo "el pokemon: $nombre_ingresado no existe"
        echo "----------"
        continue
    fi

    altura=$(grep "$nombre_ingresado," $pokemon_csv | cut -d"," -f4)
    altura_cm=$(( $altura * 10))
    peso=$(grep "$nombre_ingresado," $pokemon_csv | cut -d"," -f5)
    peso_k=$(( $peso / 10))

    #busco la habilidad en el apokemon_abilities.csv y despues busco su valor en español en ability_names.csv

    habilidad_1=$(grep "^$id," $pokemon_abilities_csv | cut -d"," -f2 | head -n 1)
    habilidad_1=$(grep "^$habilidad_1,7," $ability_names_csv | cut -d"," -f3)
    habilidad_2=$(grep "^$id," $pokemon_abilities_csv | cut -d"," -f2 | tail -n 1)
    habilidad_2=$(grep "^$habilidad_2,7," $ability_names_csv | cut -d"," -f3)

    echo "----------"
    echo "pokemon: $nombre_ingresado"
    echo "altura: $altura_cm centimetros"
    echo "peso: $peso_k kilos"
    echo ""
    echo "habilidades:"
    echo "*$habilidad_1"
    echo "*$habilidad_2"
    echo "----------"
done


# parte 3 ./parte_2.sh < ./resultados/resultados.txt > output.txt

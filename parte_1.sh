#Catalina Bogado, padron:13261, mail:catabogado10@gmail.com, mailGHUB: cbogado@fi.uba.ar
# parte 3: $./parte_1.sh 113261 resultados

padron=$1
directorio_resultados=$2

#el siguiente if va a buscar directorios con el nombre pasado por parametro y contar la cantidad de resultados, si es 0 es porque no hay ninguno
#entonces lo crea

if [ $(find -type d -name "$directorio_resultados" | wc -l) -eq 0 ]
then
    mkdir "$directorio_resultados"
fi

tipo=$(($padron % 18 + 1))
estadistica_total=$(($padron % 100 + 350))


# touch crea un archivo pero si ya esta creado no lo sobreescribe por eso uso > que lo sobreescribe y lo deja vacio

touch "$directorio_resultados/resultados.txt" > "$directorio_resultados/resultados.txt"


#priemro genero rutas a cad archivo que voy a usar

pokemon_csv=$(find -type f -name "pokemon.csv")

pokemon_stats_csv=$(find -type f -name "pokemon_stats.csv")

pokemon_types_csv=$(find -type f -name "pokemon_types.csv")

#al while le paso el archivo pokemon.csv y con el IFS separo en la "," y le asigno una variable a cada elemento en la linea. 

while IFS="," read -r id nombre species_id altura peso base_exp
do
    #busco el id de cada pokemon en el archivo, con "^" me aseguro que busque el numero por si solo y no por cada aparicion que tiene.
    #cut corta y guarda en la variable el numero en la tercera columna
    estadisticas=$(grep "^$id," $pokemon_stats_csv | cut -d"," -f3)
    
    suma=0

    for elemento in $estadisticas
    do
        suma=$(($suma + $elemento))
    done

    #lo mismo que antes pero con head me aseguro de solo agarrar el primer valor que aparece, ya que son 2 resultados por id y solo el primero es el tipo

    num_tipo=$(grep "^$id," "$pokemon_types_csv" | cut -d"," -f2 | head -n 1)

    if [ "$suma" -ge "$estadistica_total" ] && [ "$num_tipo" -eq "$tipo" ]
    then
        echo $nombre >> "$directorio_resultados/resultados.txt"
    fi


done < "$pokemon_csv"

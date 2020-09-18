#!/bin/bash

optstring="vn:h"
number_of_tests="100"
verbose="FALSE"

while getopts ${optstring} options; do
  case ${options} in
    v)
      echo "Verbose mode ON."
      verbose="TRUE"
      ;;
    h)
      echo "This script checks whether a HDD is empty after BOS."
      echo "Usage: script_hexdump.sh [-v] [-h] [-n] [file]"
      echo "-h: this help"
      echo "-v: verbose mode"
      echo "-n: number of tests, by default, 100"
      exit
      ;;
    n)
      echo "Number: ${OPTARG}"
      number_of_tests="${OPTARG}"
      ;;
    :)
      echo "Flag -n requires parameter."
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;; 
  esac
done

shift "$((OPTIND-1))"

filename="$@"
echo "file: $@"

fallos="0";
file="${OPTIND}"

if [[ ! -r "$@" ]]; then
   echo "File not exists or not readable."
   exit 1
fi

variable_inicio=$(hexdump -n 128K "$filename" | cut -d \  -f 2-)
variable_final=$(xxd -s -16 -p "$filename")


if [ $verbose == "TRUE" ]; then
   echo "$variable_inicio"
   echo "$variable_final"
fi

primeralinea_inicio=$(echo "$variable_inicio" | sed -n 1p)
primeralinea_final="$variable_final"

if [ $verbose == "TRUE" ]; then
   echo "Primera línea: " "$primeralinea_inicio"
fi
   
if [[ "$primeralinea_inicio" == "0000 0000 0000 0000 0000 0000 0000 0000" ]]

then
   if [ $verbose == "TRUE" ]; then
      echo "Todo ceros."
   fi
else
   if [ $verbose == "TRUE" ]; then
      echo "No todo ceros."
   fi
  let "fallos+=1"
fi

if [ $verbose == "TRUE" ]; then
   echo "Primera línea del final: " "$primeralinea_final"
fi
   
if [[ "$primeralinea_final" == "00000000000000000000000000000000" ]]

then
   if [ $verbose == "TRUE" ]; then
      echo "Al final todo ceros."
   fi
else
   if [ $verbose == "TRUE" ]; then
      echo "Al final no todo ceros."
   fi
  let "fallos+=1"
fi

tamanyo=$(ls -l "$filename" | cut -d " " -f 5)

echo "Number of tests: " "$number_of_tests"

re='^[0-9]+$'
if ! [[ $number_of_tests =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

for i in $(seq 1 $number_of_tests)
do
   randomoffset=$(shuf -i 1-$tamanyo -n 1)

   echo -n "$i "
   
   if [ $verbose == "TRUE" ]; then
      echo "$tamanyo"
      echo "$randomoffset"
   fi

   variable_random=$(hexdump -s "$randomoffset" -n 128K "$filename" | cut -d \  -f 2-)

   primeralinea_random=$(echo "$variable_random" | sed -n 1p)

   if [[ "$primeralinea_random" == "0000 0000 0000 0000 0000 0000 0000 0000" ]]

   then
      if [ $verbose == "TRUE" ]; then
         echo "Random. Todo ceros."
      fi
   else
      if [ $verbose == "TRUE" ]; then
         echo "Random. No todo ceros."
      fi
      let "fallos+=1"
   fi

   if [ $verbose == "TRUE" ]; then
      echo "Primera línea random: " "$primeralinea_random"
   fi
done

let number_of_tests_all=$number_of_tests+2

echo
echo "Pruebas fallidas:" "$fallos" "de $number_of_tests_all (en $fallos pruebas se han encontrado datos)"

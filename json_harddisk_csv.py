#!/usr/bin/env python3
# Copyright 2000-2019 Reciclanet Asociación Educativa-Reciclanet Hezkuntza Elkartea www.reciclanet.org
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import json
import csv
import os

path_to_json = "./jsons/"

try:
    json_files = os.listdir(path_to_json)
except FileNotFoundError:
    print("No existe el directorio " + path_to_json +  " con los archivos JSON")
    exit()

with open("discos_duros.csv", "a+") as computer:
    csv_write_file = csv.writer(computer)
    computer.seek(0)
    csv_reader = csv.reader(computer)

    for json_file in json_files:

        with open(path_to_json + json_file, "r") as read_file:
            data_file = json.load(read_file)

            for index in data_file["components"]:
                if index["@type"] == "HardDrive":

                    for row in csv_reader:
                        if row[2] == index["serialNumber"]:
                            print("El archivo/disco ya está procesado: porque coinciden los S/N")
                            break
                    else:
                        print("Añadiendo línea... S/N: " + index["serialNumber"] + ", Label: " +  data_file["label"])

                        try:
                            hdd_manufacturer = index["manufacturer"]
                        except KeyError:
                            hdd_manufacturer = "-"

                        csv_write_file.writerow([
                            hdd_manufacturer,
                            index["model"],
                            index["serialNumber"],
                            "Sobrescritura",
                            str(index["size"] / 1000) + " GB",
                            "",
                            data_file["label"],
                            ])
                    break
                else:
                    continue

#!/bin/bash


create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Directory created successfully: $1"
    fi
}

create_directory "${HOME}/data/mariadb"
create_directory "${HOME}/data/wordpress"
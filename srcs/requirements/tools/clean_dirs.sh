#!/bin/bash

delete_directory() {
    if [ -d "$1" ]; then
        sudo rm -rf "$1"
        echo "Deleted directory: $1"
    fi
}

delete_directory "${HOME}/data/mariadb"
delete_directory "${HOME}/data/wordpress"
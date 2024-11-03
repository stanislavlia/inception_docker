#!/bin/sh

exec mysqladmin ping --silent --user=root --password="$(cat /run/secrets/db_root_password)"

#!/bin/bash

# Este script determina qué ambiente está ACTIVO (Blue o Green)
# y cambia el tráfico al ambiente INACTIVO.

# --- 1. Determinar el estado actual ---
# Buscamos en el archivo default.conf si se está usando la palabra 'green' o 'blue'
# head -1 toma la primera línea encontrada.

CURRENT_ACTIVE=$(grep -E 'backend_(blue|green)' ./nginx/default.conf | head -1)

if [[ $CURRENT_ACTIVE == *"backend_blue"* ]]; then
    # Si encontramos 'backend_blue', el activo actual es BLUE.
    FROM_COLOR="blue"
    TO_COLOR="green"
elif [[ $CURRENT_ACTIVE == *"backend_green"* ]]; then
    # Si encontramos 'backend_green', el activo actual es GREEN.
    FROM_COLOR="green"
    TO_COLOR="blue"
else
    echo "ERROR: No se pudo determinar el ambiente activo en default.conf."
    exit 1
fi

echo "---"
echo "Ambiente actualmente ACTIVO: ${FROM_COLOR}"
echo "Conmutando el tráfico a: ${TO_COLOR}"
echo "---"

# --- 2. Ejecutar la Conmutación ---

# Reemplazar todas las referencias al ambiente actual (${FROM_COLOR}) por el nuevo ambiente (${TO_COLOR})
sed -i "s/backend_${FROM_COLOR}/backend_${TO_COLOR}/g" ./nginx/default.conf
sed -i "s/frontend_${FROM_COLOR}/frontend_${TO_COLOR}/g" ./nginx/default.conf

# --- 3. Recargar Nginx ---
echo "Recargando configuración de Nginx..."
docker exec nginx_proxy nginx -s reload

echo "¡CONMUTACIÓN EXITOSA! El tráfico ahora está dirigido al ambiente ${TO_COLOR}."

#!/bin/bash

# Configuración
SNAPSHOT_NAME="auto-snapshot"  # Nombre base del snapshot
MAX_SNAPSHOTS=2  # Número máximo de snapshots a mantener

# Obtener la lista de todas las máquinas virtuales (excluyendo plantillas, IDs >= 900)
VM_IDS=$(qm list | awk '{if(NR>1 && $1 < 900) print $1}')  # Excluye IDs >= 900 y la cabecera

# Función para crear snapshots
create_snapshot() {
    local vm_id=$1
    local snapshot_name="${SNAPSHOT_NAME}-$(date +%Y%m%d%H%M%S)"
    echo "Creando snapshot para la máquina virtual $vm_id..."
    qm snapshot $vm_id $snapshot_name --description "Snapshot automático"
    if [ $? -eq 0 ]; then
        echo "Snapshot creado exitosamente para la máquina virtual $vm_id."
    else
        echo "Error al crear snapshot para la máquina virtual $vm_id."
    fi
}

# Función para eliminar snapshots antiguos (mantener solo las últimas MAX_SNAPSHOTS)
delete_old_snapshots() {
    local vm_id=$1
    echo "Eliminando snapshots antiguos para la máquina virtual $vm_id..."
    
    # Obtener la lista de snapshots ordenados por fecha (más recientes primero)
    snapshot_list=$(qm listsnapshot $vm_id | awk -v snapshot_name="$SNAPSHOT_NAME" '$0 ~ snapshot_name {print $2 " " $3 " " $4}' | sort -r)
    
    # Contar el número de snapshots
    snapshot_count=$(echo "$snapshot_list" | wc -l)
    
    # Eliminar snapshots si hay más de MAX_SNAPSHOTS
    if [ $snapshot_count -gt $MAX_SNAPSHOTS ]; then
        echo "$snapshot_list" | tail -n +$(($MAX_SNAPSHOTS + 1)) | while read -r snapshot; do
            snapshot_name=$(echo "$snapshot" | awk '{print $1}')
            echo "Eliminando snapshot $snapshot_name..."
            qm delsnapshot $vm_id $snapshot_name
        done
    else
        echo "No hay snapshots antiguos para eliminar en la máquina virtual $vm_id."
    fi
}

# Crear snapshots para todas las máquinas virtuales (excluyendo plantillas)
for vm_id in $VM_IDS; do
    create_snapshot $vm_id
done

# Eliminar snapshots antiguos para todas las máquinas virtuales (excluyendo plantillas)
for vm_id in $VM_IDS; do
    delete_old_snapshots $vm_id
done

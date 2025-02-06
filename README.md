# Proxmox-Auto-Snapshots-Manager
Script Bash para Proxmox que automatiza snapshots cada 12 horas, manteniendo solo las 2 más recientes y eliminando antiguas. Excluye plantillas (IDs ≥900), incluye logs y se configura con cron. Ideal para entornos de testing/desarrollo donde se requiere una retención simple y eficiente de copias de seguridad ligeras.

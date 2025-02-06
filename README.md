# Proxmox-Auto-Snapshots-Manager
Script Bash para Proxmox que automatiza snapshots cada 12 horas, manteniendo solo las 2 más recientes y eliminando antiguas. Excluye plantillas (IDs ≥900), incluye logs y se configura con cron. Ideal para entornos de testing/desarrollo donde se requiere una retención simple y eficiente de copias de seguridad ligeras.
# Proxmox Auto Snapshots Manager

Un script en Bash para automatizar la creación y rotación de snapshots en servidores Proxmox VE.  
Mantiene siempre las **2 snapshots más recientes** y elimina automáticamente las antiguas. Ideal para entornos de testing o desarrollo donde se necesita una política de retención sencilla.

---

## Características principales ✨
- ✅ **Creación automática de snapshots** cada 12 horas (personalizable).
- 🗑️ **Eliminación de snapshots antiguos**, manteniendo solo las 2 más recientes.
- 🚫 **Excluye plantillas** (máquinas virtuales con ID >= 900).
- 📝 **Registro de actividad** (logs) para auditoría.
- ⚙️ **Configuración sencilla** mediante variables.

---

## Requisitos 📋
- Servidor Proxmox VE (versión 6.x o superior).
- Acceso SSH al servidor con permisos de administrador.
- Herramientas CLI de Proxmox (`qm` instalado).
- Bash 4.x o superior.

---

## Instalación 🛠️
1. Clona este repositorio en tu servidor Proxmox:
   ```bash
   git clone https://github.com/tu-usuario/proxmox-auto-snapshots.git
   cd proxmox-auto-snapshots

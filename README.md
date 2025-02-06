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

   Haz que el script sea ejecutable:
    chmod +x snapshot_all.sh

    Configura el cron job para ejecución automática:
    echo "0 */12 * * * $(pwd)/snapshot_all.sh >> $(pwd)/snapshot_all.log 2>&1" | crontab -

   Configuración ⚙️

Edita las variables en el script snapshot_all.sh según tus necesidades:
bash
Copy

# Nombre base de los snapshots (¡cámbialo si usas múltiples scripts!)
SNAPSHOT_NAME="auto-snapshot"

# Número máximo de snapshots a mantener
MAX_SNAPSHOTS=2

# Excluir máquinas virtuales con ID >= 900 (plantillas)
EXCLUDE_TEMPLATES=true

Uso 🚀

    Ejecución manual:
    ./snapshot_all.sh

    Ver logs:
    tail -f snapshot_all.log

    Ver snapshots en Proxmox:
    Accede a la interfaz web de Proxmox y revisa la pestaña "Snapshots" de tus máquinas virtuales.

Automatización con Cron ⏰

El script incluye un ejemplo de configuración cron para ejecutarse cada 12 horas.
Puedes ajustar la frecuencia modificando la línea en el archivo crontab:
bash
Copy

0 */12 * * * /ruta/al/script/snapshot_all.sh >> /ruta/al/log/snapshot_all.log 2>&1

Contribución 🤝

¡Las contribuciones son bienvenidas! Si deseas mejorar el proyecto:

    Haz un fork del repositorio.

    Crea una rama con tu feature (git checkout -b feature/nueva-funcionalidad).

    Haz commit de tus cambios (git commit -am 'Añade nueva funcionalidad').

    Haz push a la rama (git push origin feature/nueva-funcionalidad).

    Abre un Pull Request.

Licencia 📄

Este proyecto está bajo la licencia MIT.
Consulta el archivo LICENSE para más detalles.
Descargo de responsabilidad ⚠️

    Este script está diseñado para entornos de testing/desarrollo.

    Verifica siempre el comportamiento del script en un entorno controlado antes de usarlo en producción.

    El autor no se hace responsable de pérdidas de datos o interrupciones derivadas del uso de este script.

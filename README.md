# PoyeriaCare

Herramienta de Windows para mantener el PC limpio, privado y ordenado: limpieza de archivos basura y registro, privacidad, gestión de programas y apps, programas de inicio con su tiempo de arranque, y análisis programado.

## Descargar

Ve a [**Releases**](../../releases/latest) y descarga `PoyeriaCare-Setup.exe`.

- Requiere Windows 10 u 11 de 64 bits y permisos de administrador.
- El instalador no está firmado digitalmente, así que Windows SmartScreen puede avisar al abrirlo.
- Cada release publica el **SHA-256** del instalador en sus notas, para que puedas comprobarlo:

```powershell
Get-FileHash .\PoyeriaCare-Setup.exe -Algorithm SHA256
```

## Actualizaciones automáticas

PoyeriaCare consulta este repositorio (solo la API pública de *Releases*) y, si hay una versión nueva, descarga el instalador, **comprueba su SHA-256** y se actualiza. Se puede desactivar en **Ajustes > Actualizaciones**.

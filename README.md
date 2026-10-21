# Ad Blocker RICKY

Bloquea ads, trackers y malware en Windows a nivel de red. Un solo click, protege todo el equipo, no necesita extensiones ni software extra.

## Beneficios

- **Sin ads en todas las apps**, no solo el navegador. Juegos, apps de Microsoft Store, tiendas, utilidades.
- **Mas velocidad al navegar**, las webs cargan sin descargar banners, popups ni scripts de tracking.
- **Menos consumo de datos**, especialmente util en conexiones medidas o lentas.
- **Mas privacidad**, tu proveedor de internet y las redes publicas no pueden ver que dominios visitas.
- **Proteccion contra malware**, dominios maliciosos conocidos quedan bloqueados antes de que carguen.
- **Funciona con Wi-Fi y Ethernet al mismo tiempo**, sin fugas al cambiar de conexion.
- **Reversible al 100%**, un comando y vuelve todo a como estaba.
- **Gratis para siempre**, sin cuenta, sin suscripcion, sin limites.

## Instalacion rapida

### Opcion 1: Un solo archivo

1. Descarga [Install.bat](https://raw.githubusercontent.com/Ricky-pok/Ad-Blocker-RICKY/main/Install.bat).
2. Click derecho -> Ejecutar como administrador.
3. Listo.

### Opcion 2: Una linea en PowerShell

```powershell
irm https://raw.githubusercontent.com/Ricky-pok/Ad-Blocker-RICKY/main/Set-MullvadDNS.ps1 | iex
```

### Opcion 3: Clonar y ejecutar

```powershell
git clone https://github.com/Ricky-pok/Ad-Blocker-RICKY.git
cd Ad-Blocker-RICKY
.\Set-MullvadDNS.ps1
```

## Niveles de filtro

| Variante | Que bloquea |
|---|---|
| `base` | Nada, solo privacidad |
| `adblock` | Ads + trackers (**default**) |
| `family` | Ads + trackers + malware + contenido adulto |
| `all` | Todo + redes sociales + gambling |

Para cambiar el filtro:

```powershell
.\Set-MullvadDNS.ps1 -List family
```

## Verificar que funciona

- https://mullvad.net/en/check
- https://d3ward.github.io/toolz/adblock.html

## Revertir

```powershell
.\Set-MullvadDNS.ps1 -Rollback
```

## Requisitos

- Windows 10 version 2004 + o Windows 11.
- Permisos de administrador (el script se auto-eleva).

## Licencia

MIT. Ver [LICENSE](./LICENSE).

## Autor

Ricky (Jose E. Felix Vidal) - [@Ricky-pok](https://github.com/Ricky-pok)

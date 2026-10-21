# Ad Blocker RICKY

Block ads, trackers, and malware on Windows at the network level. One click, protects the entire device, no extensions or extra software needed.

## Benefits

- **No ads in any app**, not just the browser. Games, Microsoft Store apps, stores, utilities.
- **Faster browsing**, websites load without banners, popups, or tracking scripts.
- **Less data usage**, especially useful on metered or slow connections.
- **More privacy**, your ISP and public networks cannot see which domains you visit.
- **Malware protection**, known malicious domains are blocked before they load.
- **Works with Wi-Fi and Ethernet at the same time**, no leaks when switching connections.
- **100% reversible**, one command and everything goes back to how it was.
- **Free forever**, no account, no subscription, no limits.

## Quick install

### Option 1: One file (recommended)

1. **[Download Install.bat](https://github.com/Ricky-pok/Ad-Blocker-RICKY/releases/latest/download/Install.bat)**
2. Double-click the downloaded file.
3. Accept the UAC prompt.
4. Done.

### Option 2: One PowerShell line

Open PowerShell as Administrator and paste:

```powershell
irm https://raw.githubusercontent.com/Ricky-pok/Ad-Blocker-RICKY/main/Set-MullvadDNS.ps1 | iex
```

### Option 3: Clone and run

```powershell
git clone https://github.com/Ricky-pok/Ad-Blocker-RICKY.git
cd Ad-Blocker-RICKY
.\Set-MullvadDNS.ps1
```

## Filter variants

| Variant | What it blocks |
|---|---|
| `base` | Nothing, only privacy |
| `adblock` | Ads + trackers (**default**) |
| `family` | Ads + trackers + malware + adult content |
| `all` | Everything above + social media + gambling |

To change the filter:

```powershell
.\Set-MullvadDNS.ps1 -List family
```

## Verify it works

- https://mullvad.net/en/check
- https://d3ward.github.io/toolz/adblock.html

## Revert

```powershell
.\Set-MullvadDNS.ps1 -Rollback
```

## Requirements

- Windows 10 version 2004+ or Windows 11.
- Administrator privileges (the script auto-elevates).

## License

MIT. See [LICENSE](./LICENSE).

## Author

Ricky (Jose E. Felix Vidal) - [@Ricky-pok](https://github.com/Ricky-pok)

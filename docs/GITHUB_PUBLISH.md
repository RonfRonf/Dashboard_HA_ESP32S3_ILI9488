# 🚀 Pubblicare su GitHub — Guida passo-passo

## 1. Crea il repository su GitHub

1. Vai su [github.com/new](https://github.com/new)
2. Nome repository: `esp32s3-dashboard` (o come preferisci)
3. Descrizione: `Dashboard touchscreen per Home Assistant · ESP32-S3 + ILI9488 + LVGL`
4. Visibilità: **Public** (per condividerlo con la community)
5. **Non** spuntare "Add README" (ce l'abbiamo già)
6. Clicca **Create repository**

---

## 2. Inizializza e pubblica da terminale

```bash
# Entra nella cartella del progetto
cd esp32s3-dashboard/

# Inizializza il repository git
git init

# Aggiungi tutti i file (il .gitignore esclude automaticamente secrets.yaml)
git add .

# Primo commit
git commit -m "feat: initial release v1.0.0

- ESPHome YAML con LVGL 3 pagine (Ambiente/Clima/Luci)
- Screensaver automatico e notifiche pop-up
- Scatola 3D parametrica OpenSCAD
- Mockup interattivi HTML
- GitHub Actions CI per validazione YAML"

# Collega al repository remoto (sostituisci TUO_USERNAME)
git remote add origin https://github.com/TUO_USERNAME/esp32s3-dashboard.git

# Rinomina il branch in main
git branch -M main

# Primo push
git push -u origin main
```

---

## 3. Aggiungi i tag per la release

```bash
# Crea il tag v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0 — Dashboard LVGL ESP32-S3"

# Pusha il tag
git push origin v1.0.0
```

---

## 4. Crea una Release su GitHub

1. Vai su **Releases** → **Create a new release**
2. Tag: seleziona `v1.0.0`
3. Titolo: `v1.0.0 — Dashboard LVGL ESP32-S3`
4. Descrizione: incolla le note dal CHANGELOG.md
5. Clicca **Publish release**

---

## 5. Impostazioni repository consigliate

In **Settings → General**:
- ✅ Issues
- ✅ Discussions (utile per domande community)
- ✅ Preserve this repository

In **Settings → Pages** (opzionale):
- Puoi pubblicare il mockup HTML come GitHub Page!
- Branch: `main`, folder: `/display_preview`

In **About** (sidebar destra, click ⚙️):
- Description: `Dashboard touchscreen per Home Assistant · ESP32-S3 + ILI9488 + LVGL`
- Topics: `esphome`, `home-assistant`, `esp32s3`, `lvgl`, `ili9488`, `3d-printing`, `smart-home`
- ✅ Releases

---

## 6. Badge README (già inclusi)

I badge nel README puntano a `shields.io` e si aggiornano automaticamente.
Per aggiungere il badge "stars":

```markdown
![GitHub Stars](https://img.shields.io/github/stars/TUO_USERNAME/esp32s3-dashboard?style=social)
```

---

## 7. Workflow tipico per aggiornamenti futuri

```bash
# Modifica i file...

# Verifica cosa è cambiato
git status
git diff

# Aggiungi le modifiche
git add esphome/wow_dashboard.yaml

# Commit con messaggio descrittivo
git commit -m "feat: aggiungi pagina meteo con OpenWeatherMap"

# Push
git push
```

### Convenzione commit message

```
feat:     nuova funzionalità
fix:      correzione bug
docs:     solo documentazione
refactor: refactoring senza cambi funzionali
chore:    manutenzione, dipendenze
```

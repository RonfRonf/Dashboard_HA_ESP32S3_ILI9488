# 🖥️ ESP32-S3 Smart Home Dashboard

<div align="center">

![ESPHome](https://img.shields.io/badge/ESPHome-latest-blue?logo=esphome&logoColor=white)
![Home Assistant](https://img.shields.io/badge/Home%20Assistant-compatible-41BDF5?logo=homeassistant&logoColor=white)
![LVGL](https://img.shields.io/badge/LVGL-8.x-orange)
![ESP32-S3](https://img.shields.io/badge/ESP32--S3-DevKitC--1-green?logo=espressif)
![License](https://img.shields.io/badge/license-MIT-brightgreen)
![3D Print](https://img.shields.io/badge/3D%20Print-ready-blueviolet)

**Dashboard touchscreen per Home Assistant su ESP32-S3 con display ILI9488 3.5"**
LVGL · Screensaver · Notifiche push · Scatola stampabile in 3D

</div>

---

## 📸 Preview

> 💡 Apri [`display_preview/dashboard_preview.html`](display_preview/dashboard_preview.html) nel browser per la demo interattiva completa.

---

## ✨ Funzionalità

- **3 pagine** con transizioni animate (Ambiente / Clima / Luci)
- **Gauge circolare** temperatura con arco colorato live
- **Controllo condizionatore** — modalità cool/heat/fan, target ±1°C con tap
- **Switch animati** per luci con feedback immediato su Home Assistant
- **Indicatori presenza** per stanza con colore live
- **Screensaver** automatico dopo 2 minuti, wake on touch
- **Notifiche pop-up** inviate da HA (finestra aperta, presenza rilevata…)
- **Auto-dimmer** — luminosità display adattiva al sensore luce
- **Icone Material Design** (MDI) per tutti i widget
- **Backlight PWM** con transizione morbida
- **OTA update** — aggiornamenti firmware via WiFi

---

## 🛒 Hardware

| Componente | Modello consigliato | ~Costo |
|-----------|-------------------|--------|
| Microcontroller | ESP32-S3 DevKitC-1 N16R8 | ~8€ |
| Display | ILI9488 3.5" SPI 480×320 + XPT2046 touch | ~12€ |
| Filamento | PLA o PETG per scatola (~55g) | ~2€ |
| Viti | 4× M3×12mm | <1€ |
| **Totale** | | **~23€** |

> ⚠️ Scegli un ESP32-S3 **con PSRAM octal** (N16R8 o N8R8). Senza PSRAM LVGL non gira su 480×320.

---

## 🔗 Schema Connessioni

```
ESP32-S3 DevKitC-1
│
├─ GPIO12 ──── ILI9488 SCK
├─ GPIO11 ──── ILI9488 MOSI
├─ GPIO13 ──── ILI9488 MISO
├─ GPIO10 ──── ILI9488 CS
├─ GPIO47 ──── ILI9488 DC
├─ GPIO48 ──── ILI9488 RST
├─ GPIO46 ──── ILI9488 BL  (PWM backlight)
├─ GPIO5  ──── XPT2046 CS
└─ GPIO4  ──── XPT2046 IRQ
```

---

## 🚀 Quick Start

### 1. Prerequisiti

- [Home Assistant](https://www.home-assistant.io/) installato e funzionante
- Add-on [ESPHome](https://esphome.io/) installato in HA
- [OpenSCAD](https://openscad.org/) per generare gli STL (opzionale)

### 2. Clona il repository

```bash
git clone https://github.com/TUO_USERNAME/esp32s3-dashboard.git
cd esp32s3-dashboard
```

### 3. Configura le credenziali

```bash
cp esphome/secrets.yaml.example esphome/secrets.yaml
```

Modifica `esphome/secrets.yaml` con le tue credenziali:

```yaml
wifi_ssid: "NomeRetaWiFi"
wifi_password: "passwordWiFi"
api_key: "genera con: openssl rand -base64 32"
ota_password: "una_password_sicura"
```

### 4. Personalizza gli entity_id

Apri `esphome/wow_dashboard.yaml` e sostituisci gli entity ID con i tuoi:

```yaml
sensor.temperatura_salotto     → il tuo sensore temperatura
sensor.umidita_salotto         → il tuo sensore umidità
sensor.luce_lux                → il tuo sensore luminosità
climate.condizionatore         → la tua entità clima
binary_sensor.presenza_salotto → il tuo sensore presenza
light.luce_salotto             → la tua luce
```

### 5. Flash

1. Collega ESP32-S3 via USB al PC con HA
2. In ESPHome: **Install → Plug into this computer**
3. Prima compilazione: ~5 minuti (scarica dipendenze LVGL)
4. Successivi OTA: ~90 secondi

### 6. Autorizza in Home Assistant

```
Impostazioni → Dispositivi e Servizi → ESPHome → Configura
```

---

## 🖨️ Stampa 3D

Il progetto include una scatola parametrica in [OpenSCAD](enclosure/dashboard_enclosure.scad).

### Esportare gli STL

1. Apri `enclosure/dashboard_enclosure.scad` in OpenSCAD
2. Imposta `PART` in cima al file
3. `F6` per renderizzare → **File → Export → Export as STL**

```openscad
PART = "front";   // → front_frame.stl   (~18g, 1h20m)
PART = "back";    // → back_body.stl     (~22g, 1h45m)
PART = "stand";   // → desk_stand.stl    (~14g, 55m)
PART = "all";     // → preview assemblato (non stampare)
```

### Impostazioni stampa

| Parte | Orientazione | Layer | Infill | Supporti |
|-------|-------------|-------|--------|----------|
| `front_frame` | Face-down | 0.2mm | 20% | ❌ |
| `back_body` | Face-up | 0.2mm | 20% | ❌ |
| `desk_stand` | Normale | 0.2mm | 40% | ❌ |

**Totale stimato: ~55g PLA, ~4 ore**

---

## 📁 Struttura repository

```
esp32s3-dashboard/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── CONTRIBUTING.md
│
├── esphome/
│   ├── wow_dashboard.yaml        ← Config ESPHome principale
│   └── secrets.yaml.example      ← Template credenziali
│
├── enclosure/
│   ├── dashboard_enclosure.scad  ← Progetto OpenSCAD parametrico
│   └── enclosure_preview.html    ← Preview tecnica interattiva
│
├── display_preview/
│   └── dashboard_preview.html    ← Mockup display interattivo
│
├── docs/
│   └── screenshots/              ← Screenshot per README
│
└── .github/
    ├── workflows/
    │   └── esphome-validate.yml  ← CI: valida YAML ESPHome
    ├── ISSUE_TEMPLATE/
    │   ├── bug_report.md
    │   └── feature_request.md
    └── pull_request_template.md
```

---

## 🛠️ Troubleshooting

| Problema | Causa probabile | Soluzione |
|---------|----------------|-----------|
| Display tutto bianco | Pin errati o `color_order` sbagliato | Verifica GPIO, prova `color_order: RGB` |
| LVGL crash al boot | PSRAM non abilitata | Usa ESP32-S3 con PSRAM octal, `mode: octal` |
| Touch non risponde | Calibrazione errata | Aggiusta `x_min/max` e `y_min/max` in XPT2046 |
| HA non invia dati | Device non autorizzato | Vai in HA → Dispositivi → ESPHome → Configura |
| Compilazione fallisce | Framework sbagliato | Usa `type: esp-idf`, non `arduino` |
| OTA non funziona | Password errata | Verifica `ota_password` in secrets.yaml |

---

## 🤝 Contribuire

Le contribuzioni sono benvenute! Leggi [CONTRIBUTING.md](CONTRIBUTING.md) per le linee guida.

---

## 📄 Licenza

Distribuito sotto licenza **MIT**. Vedi [LICENSE](LICENSE) per i dettagli.

---

## 🙏 Credits

- [ESPHome](https://esphome.io/) — framework firmware
- [LVGL](https://lvgl.io/) — libreria grafica
- [Material Design Icons](https://pictogrammers.com/library/mdi/) — icone
- [OpenSCAD](https://openscad.org/) — modellazione 3D parametrica

---

<div align="center">
Fatto con ❤️ per la community Home Assistant
</div>

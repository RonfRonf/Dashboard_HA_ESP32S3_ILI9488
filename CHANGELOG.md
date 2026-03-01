# Changelog

Tutte le modifiche rilevanti a questo progetto sono documentate in questo file.

Il formato segue [Keep a Changelog](https://keepachangelog.com/it/1.0.0/)
e il progetto adotta il [Semantic Versioning](https://semver.org/lang/it/).

---

## [1.0.0] - 2026-03-01

### Aggiunto
- Configurazione ESPHome completa per ESP32-S3 + ILI9488 480×320
- LVGL con 3 pagine animate: Ambiente, Clima, Luci
- Pagina Ambiente: gauge circolare temperatura, umidità, luminosità, presenze
- Pagina Clima: controllo condizionatore con modalità cool/heat/fan e target ±1°C
- Pagina Luci: switch animati per luci multiple con feedback HA
- Screensaver automatico dopo 2 minuti con orologio fluttuante
- Wake on touch per riattivare il display
- Notifiche pop-up push da Home Assistant
- Auto-dimmer backlight in base al sensore luce ambiente
- Icone Material Design Icons (MDI) via font
- Mockup interattivo HTML del display
- Scatola parametrica OpenSCAD (3 parti, no supporti)
- Preview tecnica SVG della scatola con quote
- README completo con schema connessioni e guida stampa 3D
- `.gitignore` per ESPHome e OpenSCAD
- Template issues e PR per GitHub
- CI GitHub Actions per validazione YAML ESPHome

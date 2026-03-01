# Contributing Guide

Grazie per voler contribuire a questo progetto! 🎉

---

## Come contribuire

### 🐛 Segnalare un bug

1. Verifica che il bug non sia già stato segnalato nelle [Issues](../../issues)
2. Apri una nuova issue usando il template **Bug Report**
3. Includi quante più informazioni possibili:
   - Versione ESPHome
   - Modello ESP32-S3 e display
   - Log seriale (se disponibile)
   - Comportamento atteso vs effettivo

### 💡 Proporre una funzionalità

1. Apri una issue usando il template **Feature Request**
2. Descrivi il caso d'uso e il valore aggiunto
3. Se hai già un'idea di implementazione, descrivila

### 🔧 Inviare una Pull Request

1. **Fork** del repository
2. Crea un branch descrittivo:
   ```bash
   git checkout -b feature/nuova-pagina-meteo
   # oppure
   git checkout -b fix/calibrazione-touch
   ```
3. Fai le tue modifiche seguendo le linee guida qui sotto
4. Testa le modifiche sul tuo hardware prima di aprire la PR
5. Apri la Pull Request compilando il template

---

## Linee guida per il codice

### YAML ESPHome

- Mantieni i commenti esplicativi per ogni sezione
- Usa nomi `id` descrittivi (es. `lbl_temp_value`, non `label1`)
- Documenta ogni nuovo `entity_id` con un commento
- Testa la validazione con: `esphome config wow_dashboard.yaml`
- Non committare mai `secrets.yaml` con credenziali reali

### OpenSCAD

- Aggiungi i parametri in cima al file come variabili con commento
- Usa moduli separati per le varie parti
- Mantieni la compatibilità con OpenSCAD 2021.01+
- Commenta le formule geometriche non ovvie

### Documentazione

- Aggiorna il `README.md` se aggiungi funzionalità
- Aggiorna il `CHANGELOG.md` seguendo il formato esistente
- Le immagini/screenshot vanno in `docs/screenshots/`

---

## Idee per contribuire

| Area | Idee |
|------|------|
| 📱 **Nuove pagine** | Meteo, media player, sveglie, allarme |
| 🎨 **Temi** | Tema chiaro, tema colorato, tema minimalista |
| 🖨️ **Scatola 3D** | Versione wall-mount, versione senza stand, rack DIN |
| 🌍 **i18n** | Traduzioni in inglese, tedesco, spagnolo |
| 📖 **Docs** | Guide per display alternativi (ST7796, ILI9341…) |
| 🔧 **Hardware** | Test con altri modelli ESP32-S3 |

---

## Codice di condotta

Questo progetto adotta un approccio aperto e inclusivo. Sii rispettoso verso tutti i contributori, indipendentemente dal livello di esperienza.

---

Grazie ancora per il tuo contributo! 🚀

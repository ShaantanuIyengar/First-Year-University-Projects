# Pulse Oximeter Circuits (Single & Dual Wavelength)

This repo includes code and designs for both single and dual wavelength pulse oximeter systems.

## Project Summary

- **Single Wavelength Oximeter:**  
  Uses an LED and LDR with analog filtering and an Arduino to measure heart rate from light fluctuations through a fingertip.

- **Dual Wavelength Oximeter:**  
  Uses a custom circuit with the MAX30100* (or MAX30101) sensor for heart rate and SpO2 (oxygen) measurement, outputting data to an OLED display.  
  (*see datasheet)

## Folder Contents

- `Arduino_code_Oximeter/` — Arduino code for dual wavelength circuit.
- `Circuit-Diagrams/` — Circuit diagrams/images.
- `Datasheet_Oximeter/` — Dual Wavelength Pulse Oximeter Circuit datasheet.
- `Images_Videos/` — Project photos and videos.
- `Project_Management/` — Project management documents.



## Quick Start

1. Assemble the selected circuit.
2. Flash the appropriate Arduino code.
3. View measurements via Serial Monitor (single) or OLED (dual).



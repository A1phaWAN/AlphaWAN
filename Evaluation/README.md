# 📊 Results Reproduction Guide

This directory contains the script and data necessary to reproduce the evaluation of LoRaWAN network capacity as presented in the paper.

## Prerequisites

- MATLAB

### Contents:

- `Maximum_capability.m`: The main MATLAB script to reproduce the evaluation.
- `Collected_data/`: Dataset used for the capacity evaluation, including raw experiment logs and parsed CSV files.

### Instructions:

1. **Environment Requirements**:
    - MATLAB R2021a or later is recommended.
    - No external toolboxes are required beyond base MATLAB functions.
2. Reproduction:
    - Open MATLAB and navigate to this directory.
    - Run the script:
        
        ```matlab
        Maximum_capability.m
        ```
        
    - The script loads experiment traces from the `Collected_data` folder and processes them to generate evaluation plots.



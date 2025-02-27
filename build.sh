#!/usr/bin/env bash

# Script to build all SMON versions at once.

acme -DFMON=1 code/SMON_RSC.asm
acme -DPLUS=1 code/SMON_RSC.asm
acme -DILOC=1 code/SMON_RSC.asm
acme -DFCOM=1 code/SMON_RSC.asm

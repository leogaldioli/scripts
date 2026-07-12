#!/usr/bin/env bash
# logr — reinicia o Logi Options+ no macOS (UI + agent + helpers) em background,
# sem trazer o app para frente / sem roubar o foco da janela atual.
#
# Uso: ./logr.sh   (ou como alias `logr` no ~/.zshrc)

killall logioptionsplus logioptionsplus_agent LogiRightSight LogiPluginService 2>/dev/null
open -g -a logioptionsplus

#!/bin/bash

RESULT_PATH=$HOME/.dotfiles/config/i3/config
BOILERPLATE_PATH=$HOME/.dotfiles/config/i3/config_boilerplate
HOST_AGNOSTIC_PATH=$HOME/.dotfiles/config/i3/config_host_agnostic
HOST_SPECIFIC_PATH=$HOME/.dotfiles/host-$(hostname)/config/i3/config_host_specific

if [[ -f "$HOST_SPECIFIC_PATH" ]]; then
  cat "$BOILERPLATE_PATH" "$HOST_AGNOSTIC_PATH" "$HOST_SPECIFIC_PATH" > "$RESULT_PATH"
else
  cat "$BOILERPLATE_PATH" "$HOST_AGNOSTIC_PATH" > "$RESULT_PATH"
fi

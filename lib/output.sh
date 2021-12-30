#!/usr/bin/env bash

export ESC_RESET="\033[0m"
export ESC_FG_BLACK="\033[30m"
export ESC_FG_RED="\033[31m"
export ESC_FG_GREEN="\033[32m"
export ESC_FG_YELLOW="\033[33m"
export ESC_FG_BLUE="\033[34m"
export ESC_FG_MAGENTA="\033[35m"
export ESC_FG_CYAN="\033[36m"
export ESC_FG_WHITE="\033[37m"
export ESC_FG_DEFAULT="\033[39m"
export ESC_BG_BLACK="\033[40m"
export ESC_BG_RED="\033[41m"
export ESC_BG_GREEN="\033[42m"
export ESC_BG_YELLOW="\033[43m"
export ESC_BG_BLUE="\033[44m"
export ESC_BG_MAGENTA="\033[45m"
export ESC_BG_CYAN="\033[46m"
export ESC_BG_WHITE="\033[47m"
export ESC_BG_DEFAULT="\033[49m"

export LOG_LEVEL_DEBUG=0
export LOG_LEVEL_INFO=1
export LOG_LEVEL_WARN=2
export LOG_LEVEL_ERROR=3
export LOG_LEVEL=${LOG_LEVEL:-${LOG_LEVEL_INFO}}

export LOG_STYLE_DEBUG=$ESC_FG_WHITE
export LOG_STYLE_INFO=$ESC_FG_BLUE
export LOG_STYLE_WARN=$ESC_FG_YELLOW
export LOG_STYLE_ERROR=$ESC_FG_RED

export LOG_NAME_DEBUG="DEBUG"
export LOG_NAME_INFO="INFO "
export LOG_NAME_WARN="WARN "
export LOG_NAME_ERROR="ERROR"

function __write_log() {
  local level="LOG_LEVEL_$1"
  local style="LOG_STYLE_$1"
  local name="LOG_NAME_$1"
  if [[ ${!level} -ge $LOG_LEVEL ]];then
     echo -e "${!style}[${!name}] $2${ESC_RESET}"
  fi
}

function debug() {
  __write_log DEBUG "$*"
}

function info() {
  __write_log INFO "$*"
}

function warn() {
  __write_log WARN "$*"
}

function error() {
  __write_log ERROR "$*"
}

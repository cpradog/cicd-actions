#!/usr/bin/env bash

export LOG_LEVEL_DEBUG=0
export LOG_LEVEL_INFO=1
export LOG_LEVEL_WARN=2
export LOG_LEVEL_ERROR=3

export LOG_TAG_DEBUG="debug"
export LOG_TAG_INFO="notice"
export LOG_TAG_WARN="warning"
export LOG_TAG_ERROR="error"

function __write_log() {
  local level="LOG_LEVEL_$1"
  local tag="LOG_TAG_$1"
  if [[ ${!level} -ge $LOG_LEVEL ]];then
     echo "::${!tag}:: $2" >/dev/tty
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

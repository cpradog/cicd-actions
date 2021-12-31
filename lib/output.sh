#!/usr/bin/env bash

function debug() {
  echo "::debug:: $*" >&2
}

function info() {
  echo "::notice:: $*" >&2
}

function warn() {
  echo "::warning:: $*" >&2
}

function error() {
  echo "::error:: $*" >&2
}

function set_output() {
  echo "::set-output name=$1::$2" >&2
}

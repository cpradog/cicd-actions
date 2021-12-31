#!/usr/bin/env bash

function calculate_bump() {
  local current_version bump message
  read -ra current_version <<< "$(version_parts "$1")"
  shift

  read -ra commits <<<"$*"

  bump=0
  for commit in "${commits[@]}"; do
    message=$(git_commit_message "$commit")
    if [[ "$message" =~ $BUMP_MAJOR_REGEX ]]; then
      bump=3
    elif [[ "$message" =~ $BUMP_MINOR_REGEX ]]; then
      [[ $bump -lt 2 ]] && bump=2
    elif [[ "$message" =~ $BUMP_MINOR_REGEX ]]; then
      [[ $bump -lt 1 ]] && bump=1
    fi
  done

  if [[ $bump -eq 0 ]]; then
    info 'no version bump required'
  else
    if [[ $bump -eq 3 ]]; then
      info 'incrementing major version'
      current_version[1]=$(( current_version[1] + 1 ))
      current_version[2]=0
      current_version[3]=0
    elif [[ $bump -eq 2 ]]; then
      info 'incrementing minor version'
      current_version[2]=$(( current_version[2] + 1 ))
      current_version[3]=0
    else
      info 'incrementing patch version'
      current_version[3]=$(( current_version[3] + 1 ))
    fi

    debug 'composing final version string'
    current_version[0]="${current_version[1]}.${current_version[2]}.${current_version[3]}"
    current_version[4]=''
    current_version[5]=''

    if [[ ${#BUMP_VERSION_TAG} -gt 0 ]]; then
      info "version tag: $BUMP_VERSION_TAG"

      current_version[5]="$BUMP_VERSION_TAG"
      current_version[0]="${current_version[0]}-${current_version[5]}"
    fi

    info "final version: ${current_version[0]}"
  fi
  echo "${current_version[0]}"
}

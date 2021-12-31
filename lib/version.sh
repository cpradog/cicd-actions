#!/usr/bin/env bash

function version_parts() {
  debug "calculating version parts for: $1"

  local parts=( "$1" '0' '0' '0' '' '' )
  [[ "$1" =~ ^([0-9]+)(\.([0-9]+))?(\.([0-9]+))?(([^-]*))(-(.*))?$ ]]

  read -ra matches <<<"${BASH_REMATCH[@]}"
  local matches_len="${#matches[@]}"

  if [[ ${matches_len} -eq 0 ]]; then
    warn 'version string does not match regex. Unable to extract parts'
    echo "${parts[*]}"
  else
    debug "major: ${matches[1]}"
    parts[1]=${matches[1]}

    if [[ ${matches_len} -gt 2 ]]; then
      if [[ "${matches[2]}" =~ ^\. ]]; then
        debug "minor: ${matches[3]}"
        parts[2]=${matches[3]}

        if [[ ${matches_len} -gt 4 ]]; then
          if [[ "${matches[4]}" =~ ^\. ]]; then
            debug "patch: ${matches[5]}"
            parts[3]=${matches[5]}

            if [[ ${matches_len} -gt 6 ]]; then
              if [[ "${matches[6]}" =~ ^[^-] ]]; then
                debug "extras: ${matches[6]}"
                parts[4]=${matches[7]}

                if [[ ${matches_len} -gt 8 ]]; then
                  debug "tag: ${matches[9]}"
                  parts[5]=${matches[9]}
                fi

              else
                debug "tag: ${matches[7]}"
                parts[5]=${matches[7]}
              fi
            fi

          else
            debug "tag: ${matches[5]}"
            parts[5]=${matches[5]}
          fi
        fi

      else
        debug "tag: ${matches[3]}"
        parts[5]=${matches[3]}
      fi
    fi
  fi

  echo "${parts[*]}"
}

function version_major() {
  read -ra parts <<< "$(version_parts "$*")"
  echo "${parts[1]}"
}

function version_minor() {
  read -ra parts <<< "$(version_parts "$*")"
  echo "${parts[2]}"
}

function version_patch() {
  read -ra parts <<< "$(version_parts "$*")"
  echo "${parts[3]}"
}

function version_extras() {
  read -ra parts <<< "$(version_parts "$*")"
  echo "${parts[4]}"
}

function version_tag() {
  read -ra parts <<< "$(version_parts "$*")"
  echo "${parts[5]}"
}

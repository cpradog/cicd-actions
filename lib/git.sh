#!/usr/bin/env bash

function git_commit_by_ref() {
  git rev-parse "$1"
}

function git_current_commit() {
  git_commit_by_ref HEAD
}

function git_first_commit() {
  git rev-list --max-parents=0 HEAD | tail -1
}

function git_last_version_tag() {
  git describe --match "${VERSION_TAG_PREFIX}*" --abbrev=0 --tags 2> /dev/null
}

function git_last_version_from_tags() {
  local tag prefix_length

  tag=$(git_last_version_tag || echo)
  if [[ "x$tag" != "x" ]];then
     debug "last git version tag: ${tag}"
     prefix_length=$(( ${#VERSION_TAG_PREFIX} + 1 ))
     echo "$tag" | cut -c "${prefix_length}-" -
  else
    warn 'no version tag found.'
    echo "0.0.0"
  fi
}

function git_commits_between_refs() {
  git rev-list --reverse "$(git_commit_by_ref "$1")..$(git_commit_by_ref "$2")"
}

function git_commit_message() {
  git show --no-decorate --format=%s%n%n%b --no-patch "$1"
}

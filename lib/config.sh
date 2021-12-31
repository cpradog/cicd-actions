#!/usr/bin/env bash

##!
# The git tag name prefix for version tags.
##
export VERSION_TAG_PREFIX=${VERSION_PREFIX:-v}

##!
# The diagnostics verbosity level.
##
export LOG_LEVEL=${LOG_LEVEL:-1} # INFO

##!
# The regular expression to bump major version part.
##
export BUMP_MAJOR_REGEX="${BUMP_MAJOR_REGEX:-BREAKING CHANGE}"

##!
# The regular expression to bump minor version part.
##
export BUMP_MINOR_REGEX="${BUMP_MINOR_REGEX:-^feat}"

##!
# The regular expression to bump patch version part.
##
export BUMP_PATCH_REGEX="${BUMP_PATCH_REGEX:-^fix}"

##!
# Additional version tag when bumping version.
##
export BUMP_VERSION_TAG="${BUMP_VERSION_TAG:-}"

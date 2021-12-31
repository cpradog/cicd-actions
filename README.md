# CI/CD GitHub actions

## Get current version

This action will output the version information for current branch tags.

``` yaml
  name: demo current version

  on:
    push:
      branches:
        - master

  jobs:
    get-current-version:
      runs-on: ubuntu-latest

      steps:

        - name: checkout repo
          uses: actions/checkout@v2
          with:
            fetch-depth: 0

        - name: current version
          id: version
          uses: cpradog/cicd-actions/current-version@master
          with:
            LOG_LEVEL: 0 # DEBUG
            VERSION_TAG_PREFIX: v # default

        - name: show result
          run: |
            echo current version is: ${{ steps.version.outputs.version }}
            echo major: ${{ steps.version.outputs.major }}
            echo minor: ${{ steps.version.outputs.minor }}
            echo patch: ${{ steps.version.outputs.patch }}
            echo extras: ${{ steps.version.outputs.extras }}
            echo tag: ${{ steps.version.outputs.tag }}
```

## bump version

This action will bump version based on all commits since last branch tag.

``` yaml
  name: demo bump version

  on:
    push:
      branches:
        - master

  jobs:
    bump-version:
      runs-on: ubuntu-latest

      steps:

        - name: checkout repo
          uses: actions/checkout@v2
          with:
            fetch-depth: 0

        - name: calculate version
          id: version
          uses: cpradog/cicd-actions/version-bump@master
          with:
            LOG_LEVEL: 0 # DEBUG
            VERSION_TAG_PREFIX: v # default
            BUMP_MAJOR_REGEX: "BREAKING\ CHANGE"
            BUMP_MINOR_REGEX: "^feat"
            BUMP_PATCH_REGEX: "^fix"
            BUMP_VERSION_TAG: "rc"

        - name: show result
          run: |
            echo next version is: ${{ steps.version.outputs.version }}
            echo major: ${{ steps.version.outputs.major }}
            echo minor: ${{ steps.version.outputs.minor }}
            echo patch: ${{ steps.version.outputs.patch }}
            echo extras: ${{ steps.version.outputs.extras }}
            echo tag: ${{ steps.version.outputs.tag }}
```

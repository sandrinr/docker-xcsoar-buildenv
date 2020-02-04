#!/usr/bin/env bash

# Put the home directory into the current directory such that XCSoar stores its
# files there.
export HOME=$PWD

exec "$@"

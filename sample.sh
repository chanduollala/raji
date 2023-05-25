#!/bin/bash

platform=$(uname)
is_linux=false
is_macos=false
if [[ "$platform" == "Linux" ]]; then
  echo "Linux detected"
  is_linux=true
elif [[ "$platform" == "Darwin" ]]; then
  echo "MacOS detected"
  is_macos=true
fi

echo "Checking if ruby is installed in system"
# Check if Ruby is already installed
if command -v ruby >/dev/null 2>&1; then
	echo "Ruby found in the system"
else
  echo "Ruby not found! Installing..."
    if $is_linux; then
      apt-get install ruby-full
    fi
fi


#!/bin/bash

# Enable reading of single keypresses
read -rsn1 -d ' ' input

# Check if the pressed key is an arrow key
if [[ $key == $'\x1b[A' ]]; then
  echo "Up arrow key pressed"
elif [[ $key == $'\x1b[B' ]]; then
  echo "Down arrow key pressed"
elif [[ $key == $'\x1b[C' ]]; then
  echo "Right arrow key pressed"
elif [[ $key == $'\x1b[D' ]]; then
  echo "Left arrow key pressed"
else
  echo "Key press not recognized"
fi

#!/bin/bash
clear
echo "Formatting code with [flutter format]...."
flutter format lib
git add .
echo "Done"
git status


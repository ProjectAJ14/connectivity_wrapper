#!/bin/bash
clear
echo "Sort imports...."
flutter pub run import_sorter:main
echo "Formatting code with [flutter format]...."
flutter format lib
git add .
echo "Done"
git status


#!/bin/bash

START=$(date +%s)
flutter clean
flutter pub get
flutter test
if [[ $? == 0 ]]; then
  flutter pub publish --dry-run
else
  echo "FLUTTER TEST FAILED"
fi
END=$(date +%s)
DIFF=$(echo "$END - $START" | bc)
echo "It took $DIFF seconds"
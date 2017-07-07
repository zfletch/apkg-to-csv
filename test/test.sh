#!/usr/bin/env bash

./bin/apkg_to_csv.rb test/test.apkg > test/__compare_test.csv

cmp --silent test/test.csv test/__compare_test.csv && echo "Tests passed" && rm test/__compare_test.csv || echo "Tests failed: Files not equal"

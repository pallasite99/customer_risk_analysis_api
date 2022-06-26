#!/bin/bash

SRC_DIR := .

# run all specified targets
all: run

# start HTTP server in listening mode
run: 
cd $SRC_DIR/pkg/api/v1
node index.js

#!/bin/bash

cd lib/crsfml/ && cmake . && make
cd ..
cd ..
export LIBRARY_PATH="`pwd`/lib/crsfml/voidcsfml"  # Used during linking
export LD_LIBRARY_PATH="`pwd`/lib/crsfml/voidcsfml"
crystal src/disconnected.cr --debug --stats        

#!/bin/bash

homedir=$(pwd)

cd methanol
../leap.sh methanol MOH
cd ..

cd ethanol
../leap.sh ethanol EOH
cd ..

cd propanol
../leap.sh propanol POH
cd ..

cd 1-butanol
../leap.sh 1-butanol BOH
cd ..

cd isopropanol
../leap.sh isopropanol iPO
cd ..

cd isobutanol
../leap.sh isobutanol iBO
cd ..

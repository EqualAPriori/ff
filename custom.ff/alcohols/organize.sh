#!/bin/bash

for d in methanol ethanol propanol butanol isopropanol isobutanol
do
    mkdir $d
    mv ${d}* $d
done

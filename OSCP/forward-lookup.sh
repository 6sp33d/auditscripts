#!/bin/bash

for name in $(cat domain_list.txt); do
host $name.megacorpone.com | grep "has address" | cut -d" " -f1,4
done

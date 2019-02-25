#!/bin/bash

echo ${newvara:-a}
echo $newvara

echo ${newvarb:=a}
echo $newvarb

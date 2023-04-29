#!/bin/bash
## Script accepts two floating-point numbers from command line as parameters, and prints out their summation result
## Parameters
##	1st parameter: 1st floating-point number
##	2nd parameter: 2nd floating-point number
## Exit codes
##	0: Success
##	1: Not enough parameters
##	2: NUM1 is not a floating-point number
##	3: NUM2 is not a floating-point number

## Check for parameters

if [ ${#} -ne 2 ]; then
    echo "Not enough parameters"
    exit 1
fi

## Assign values to custom variables
NUM1=${1}
NUM2=${2}

## Check for floating-point values
if ! [[ "${NUM1}" =~ ^-?[0-9]+([.][0-9]+)$ ]]; then
    echo "NUM1 is not a floating-point number"
    exit 2
fi

if ! [[ "${NUM2}" =~ ^-?[0-9]+([.][0-9]+)$ ]]; then
    echo "NUM2 is not a floating-point number"
    exit 3
fi


## Perform summation operation using 'bc'
RES=$( echo "${NUM1} + ${NUM2}" | bc -l)

## Prints out the result
echo "SUM = ${RES}"

exit 0


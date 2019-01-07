#!/bin/bash

# This script expect a tag that github understand to version dealii,
# i.e., any tag name (like v9.0.0) or master and translates it to 
# a spack compatible version string (i.e., 9.0.0 or develop)
case $1 in:
master)
	echo "Installing development version of dealii"
	spack install dealii@develop 
	;;
*)
	VER=${1:1}
	echo "Installing version $VER of dealii"
	spack install dealii@$VER 
	;;
esac
spack clean -a

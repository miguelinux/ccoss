#!/bin/bash
# Purpose: Encrypt the totp secret stored in $dir/$service/.key file
# Author: Vivek Gite {https://www.cyberciti.biz/} under GPL v 2.x or above
# --------------------------------------------------------------------------
# Path to gpg2 binary
_gpg2="/usr/bin/gpg2"
 
## run: gpg --list-secret-keys --keyid-format LONG to get uid and kid ##
# GnuPG user id 
uid="YOUR-EMAIL-ID"
 
# GnuPG key id 
kid="YOUR-KEY"
 
# Directory that stores encrypted key for each service 
dir="$HOME/.2fa"

if [ -e ${HOME}/.config/2fa/config ]
then
  source ${HOME}/.config/2fa/config
fi
 
# Now build CLI args
s="$1"
k="${dir}/${s}/.key"
kg="${k}.gpg"
 
# failsafe stuff
[ "$1" == "" ] && { echo "Usage: $0 service"; exit 1; }
[ ! -f "$k" ] && { echo "$0 - Error: $k file not found."; exit 2; }
[ -f "$kg" ] && { echo "$0 - Error: Encrypted file \"$kg\" exists."; exit 3; }
 
# Encrypt your service .key file 
$_gpg2 -u "${kid}" -r "${uid}" --encrypt "$k" && rm -i "$k"

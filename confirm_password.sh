#!/usr/bin/env bash

while true; do
  read -r -s -p "Password: " password_1; echo
  read -r -s -p "Confirm: " password_2; echo
  
  if [ "$password_1" = "$password_2" ]; then
    unset password_1
    unset password_2
    break
  else
    echo -e "\nThe password and confirmation did not match\n"
  fi
done

echo "Access granted! Loading script..."

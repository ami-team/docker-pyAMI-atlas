#!/bin/sh
set -e

if [ -n "$B64_USER_PROXY" ]
then
  export X509_USER_PROXY="/tmp/x509up_u$(id -u)"
  echo "$B64_USER_PROXY" | base64 -d > "$X509_USER_PROXY"
  chmod 600 "$X509_USER_PROXY"
elif [ -n "$AMI_LOGIN" ] && [ -n "$AMI_PASSWORD" ]
then
  expect <<EOF
    set timeout 1
    spawn ami auth
    expect "Login:"
    send "$AMI_LOGIN\r"
    expect "Password:"
    send "$AMI_PASSWORD\r"
    expect eof
EOF
fi

# Exécute la commande passée ou bloque si rien n'est donné
if [ "$#" -gt 0 ]
then
  exec "$@"
else
  if [ -t 0 ]
  then  
    /bin/bash
  else
    tail -f /dev/null
  fi
fi


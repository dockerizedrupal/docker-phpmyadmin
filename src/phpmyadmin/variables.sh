#!/usr/bin/env bash

if [ -n "${MYSQL_HOST}" ]; then
  export FACTER_MYSQL_HOST="${MYSQL_HOST}"

  if [ -z "${MYSQL_PORT}" ]; then
    MYSQL_PORT="3306"
  fi

  export FACTER_MYSQL_PORT="${MYSQL_PORT}"
else
  MYSQL_PORT="$(echo "${MYSQL_PORT}" | sed 's/tcp:\/\///')"

  export FACTER_MYSQL_HOST="$(echo "${MYSQL_PORT}" | cut -d ":" -f1)"
  export FACTER_MYSQL_PORT="$(echo "${MYSQL_PORT}" | cut -d ":" -f2)"
fi

if [ -z "${MYSQL_USERNAME}" ]; then
  MYSQL_USERNAME="container"
fi

export FACTER_MYSQL_USERNAME="${MYSQL_USERNAME}"

if [ -z "${MYSQL_PASSWORD}" ]; then
  MYSQL_PASSWORD="container"
fi

export FACTER_MYSQL_PASSWORD="${MYSQL_PASSWORD}"

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

if [ -z "${TIMEZONE}" ]; then
  TIMEZONE="Etc/UTC"
fi

export FACTER_TIMEZONE="${TIMEZONE}"

if [ -z "${PHP_INI_MAX_EXECUTION_TIME}" ]; then
  PHP_INI_MAX_EXECUTION_TIME="900"
fi

export FACTER_PHP_INI_MAX_EXECUTION_TIME="${PHP_INI_MAX_EXECUTION_TIME}"
export FACTER_TIMEOUT="${PHP_INI_MAX_EXECUTION_TIME}"

if [ -z "${PROTOCOLS}" ]; then
  PROTOCOLS="https,http"
fi

PROTOCOLS=$(echo "${PROTOCOLS}" | tr "," "\n")

for PROTOCOL in ${PROTOCOLS}; do
  if [ "${PROTOCOL}" == "http" ]; then
    export FACTER_HTTP="1"
  fi

  if [ "${PROTOCOL}" == "https" ]; then
    export FACTER_HTTPS="1"
  fi
done

if [ -z "${HTTP_BASIC_AUTH}" ]; then
  HTTP_BASIC_AUTH="Off"
fi

export FACTER_HTTP_BASIC_AUTH="${HTTP_BASIC_AUTH}"

if [ -z "${HTTP_BASIC_AUTH_USERNAME}" ]; then
  HTTP_BASIC_AUTH_USERNAME="container"
fi

export FACTER_HTTP_BASIC_AUTH_USERNAME="${HTTP_BASIC_AUTH_USERNAME}"

export FACTER_HTTP_BASIC_AUTH_PASSWORD="${HTTP_BASIC_AUTH_PASSWORD}"

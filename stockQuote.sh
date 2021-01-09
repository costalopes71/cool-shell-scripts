#! /usr/bin/env bash

# stockQuote.sh - Displays the value of the closing, opening, minimun and maximum share price
#
# Site:       
# Author:      Joao Lopes
# Maintainer: Joao Lopes
#
# ------------------------------------------------------------------------ #
#  This program quotes the opening, closing, minimum and maximum value of a given stock on a given stock exchange in the world based on the API of marketstack (https://marketstack.com/).
#  For using it, export the variable API_TOKEN, you can get a free token
#  for 1000 (one thousand) requests per month at their website.
#
#  Examples:
#      $ export API_TOKEN_MARKETSTACK=YOUR_API_TOKEN_HERE
#      $ ./stockQuote.sh [TICKER.EXCHANGE] [date]
#      $ ./stockQuote.sh PETR3.BVMF 2021-01-10
#      
#      In this example, the price of the PETR3 stock on the BVMF stock exchange (Brazilian stock exchange) for the date of 1st January 2021 will be displayed.
#
# ------------------------------------------------------------------------ #
# Changelog
#
#   v1.0 08/01/2021, Joao:
#       - Initial program
#       - display the requested stock price
#
# ------------------------------------------------------------------------ #
# Tested with:
#   bash 5.0.17
# ------------------------------------------------------------------------ #

############################################################################
# VARIABLES
############################################################################

MARKETSTACK_API_TOKEN="$MARKETSTACK_API_TOKEN"
MARKETSTACK_ENDPOINT="http://api.marketstack.com/v1/eod?access_key=${MARKETSTACK_API_TOKEN}&symbols=$1&date_from=$2&date_to=$2"

RED="\033[031;1m"

############################################################################
# FUNCTIONS
############################################################################


############################################################################
# TESTS
############################################################################

[ $# -ne 2 ] && echo -e "${RED}[ERROR] Missing required parameters. Usage: stockQuote [TICKER.EXCHANGE] [DATE]" && exit 1

# TODO is curl installed?
# TODO is jq installed?

############################################################################
# EXECUTION
############################################################################

RESPONSE=$( curl -s "$MARKETSTACK_ENDPOINT" )

# TODO parse response with jq
# TODO display open, close, max and min formated and with color

echo "$RESPONSE"

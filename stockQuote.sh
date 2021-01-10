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
BLUE="\033[34;1m"
GREEN="\033[32;1m"
YELLOW="\033[33;1m"

############################################################################
# FUNCTIONS
############################################################################

ExtractData() {
	echo "$( echo "$1" | jq .data[0].$2 )"
}

############################################################################
# TESTS
############################################################################

[ $# -ne 2 ] && echo -e "${RED}[ERROR] Missing required parameters. Usage: stockQuote [TICKER.EXCHANGE] [DATE]" && exit 1

[ ! -x "$( which curl )" ] && echo -e "${RED}[ERROR] Missing required dependencie curl. Install: sudo apt install curl" && exit 2

[ ! -x "$( which jq )" ] && echo -e "${RED}[ERROR] Missing required dependencie jq. Install: sudo apt install jq" && exit 2

############################################################################
# EXECUTION
############################################################################

RESPONSE=$( curl -s "$MARKETSTACK_ENDPOINT" )

ERROR_MESSAGE="$( echo $RESPONSE | jq .error.message )"

[ "$ERROR_MESSAGE" != "null" ] && echo -e "$RED[ERROR] Could not get stock quote at marketstack endpoint. Error message: $ERROR_MESSAGE" && exit 3

OPEN="${YELLOW}open: $( ExtractData $RESPONSE "open" )"
CLOSE="${BLUE}close: $( ExtractData $RESPONSE "close" )"
MAX="${GREEN}max: $( ExtractData $RESPONSE "high" )"
MIN="${RED}min: $( ExtractData $RESPONSE "low" )"

echo "  ${1}"
echo -e "\t$OPEN\n\t$CLOSE\n\t$MAX\n\t$MIN"

#! /usr/bin/env bash

# stockQuote.sh - Displays the value of the closing, opening, minimum 
# and maximum share price
#
# Site:       
# Author:      Joao Lopes
# Maintainer: Joao Lopes
#
# ------------------------------------------------------------------------ #
#  This program quotes the opening, closing, minimum and maximum value of 
#  a given stock on a given stock exchange in the world based on the API of
#  marketstack (https://marketstack.com/).
#  For using it, export the variable API_TOKEN, you can get a free token
#  for 1000 (one thousand) requests per month at their website.
#
#  Examples:
#      $ export API_TOKEN_MARKETSTACK=YOUR_API_TOKEN_HERE
#      $ ./stockQuote.sh [exchange] [ticker]
#      $ ./stockQuote.sh BVMF PETR3
#      
#      In this example, the price of the PETR3 stock on the BVMF stock exchange 
#      (Brazilian stock exchange) will be displayed.
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
MARKETSTACK_ENDPOINT="http://api.marketstack.com/v1/eod?access_token=$MARKETSTACK_API_TOKEN"

RED="\033[031;1m"

############################################################################
# FUNCTIONS
############################################################################


############################################################################
# TESTS
############################################################################


############################################################################
# EXECUTION
############################################################################



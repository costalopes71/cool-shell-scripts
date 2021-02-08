#! /usr/env bash

# convert to pkcs12
sudo openssl pkcs12 -export \ 
  -in /etc/letsencrypt/live/advocaciamolina.com/fullchain.pem \ 
  -inkey /etc/letsencrypt/live/advocaciamolina.com/privkey.pem \ 
  -out ~/keystore.p12 \ 
  -name virtualoffice \ 
  -CAfile /etc/letsencrypt/live/advocaciamolina.com/chain.pem \ 
  -caname root

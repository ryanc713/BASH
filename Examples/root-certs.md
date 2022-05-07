````bash
wget -O - https://www.startssl.com/certs/ca.pem https://www.startssl.com/certs/sub.class1.server.ca.pem | tee -a ca-certs.pem> /dev/null
wget -O - https://www.digicert.com/CACerts/DigiCertHighAssuranceEVRootCA.crt | openssl x509 -inform DER -outform PEM | tee -a ca-certs.pem> /dev/null
wget -O - https://www.digicert.com/CACerts/DigiCertHighAssuranceEVCA-1.crt | openssl x509 -inform DER -outform PEM | tee -a ca-certs.pem> /dev/null
````

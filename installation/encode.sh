pswd=""
salt=""

# Encode password
pswd=`echo $pswd | openssl enc -e -des3 -base64 -k "${salt}" -pass pass:mypasswd -pbkdf2`
echo $pswd > patToken.txt

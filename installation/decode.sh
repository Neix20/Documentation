# Set Salt
salt="Neix19365"

# Read From File
pswd=""

while read -r line; do
    pswd=$line
done < "patToken.txt"

# Decode Password
echo $pswd | openssl enc -d -des3 -base64 -k "${salt}" -pass pass:mypasswd -pbkdf2

# IF Statement and Keep Indentations

````bash
if cond; then
    cat <<- EOF
    hello
    there
    EOF
fi
````

# IF Statement

````bash
if cond; then
 cat << EOF
hello
there
EOF
fi
````

# Create a File

````bash
cat > fruits.txt << EOF
apple
orange
lemon
EOF
````

# Execute Commands on Remote Host with SSH
 
````bash
ssh -p 21 example@example.com <<EOF
 echo 'printing pwd'
 echo "\$(pwd)"
 ls -a
 find '*.txt'
EOF
````

# Run Several Commands with Sudo

````bash
sudo -s <<EOF
 a='var'
 echo 'Running serveral commands with sudo'
 mktemp -d
 echo "\$a"
EOF
````

# Append Mutliple Lines to the End of a File

````bash
cat<<_EOF_ >> /path/to/file
some
text
to
append
_EOF_

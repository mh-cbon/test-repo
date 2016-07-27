BASEURL=$1

cat <<EOT
deb [trusted=yes] ${BASEURL} /binary-\$(ARCH)/
EOT

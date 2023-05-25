#!/bin/bash

# Download Ruby tarball
ruby_version="3.2.2"  # Replace with the desired Ruby version
ruby_tarball="ruby-${ruby_version}.tar.gz"
wget https://cache.ruby-lang.org/pub/ruby/${ruby_version%.*}/${ruby_tarball}

# Extract the archive
tar -xzvf ${ruby_tarball}

# Navigate into the extracted directory
cd ruby-${ruby_version}

# Configure the build
./configure

# Build and install Ruby
make
sudo make install

# Verify the installation
ruby --version

# Clean up downloaded files and extracted directory
cd ..
rm -rf ruby-${ruby_version}
rm ${ruby_tarball}


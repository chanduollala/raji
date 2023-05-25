platform=$(uname)
echo $platform
if [[ "$platform" == "Linux" ]]; then
  echo "Linux platform detected"
else
  echo "Unknown platform: $platform"
fi


echo "Hello chandu"
#!/bin/bash
echo "Hi"

# Check if Ruby is already installed
if command -v ruby >/dev/null 2>&1; then
	echo "Ruby found in the system"
elif snap run ruby --version >/dev/null 2>&1; then
		echo "Ruby not found! Installing..."
    	#sudo apt-get install ruby-full
    	sudo snap install ruby --classic
fi


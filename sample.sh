echo "Hello chandu"
#!/bin/bash
echo "Hi"

# Check if Ruby is already installed
r_mode=0
if command -v ruby >/dev/null 2>&1; then
	r_mode=1
else
	if snap run ruby --version >/dev/null 2>&1; then
		r_mode=2
	fi
fi
echo $r_mode
: '
if [ "$r_mode" -eq 1 ]; then
	echo "Ruby found in the system"
elif [ "$r_mode" -eq 2 ]; then
	echo "Ruby found as a snap"
else
	echo "Ruby not found! Installing..."
	#sudo apt-get install ruby-full
	sudo snap install ruby --classic
fi
'


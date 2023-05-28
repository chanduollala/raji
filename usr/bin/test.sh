# Define a function that modifies the passed array
modify_array() {
  local array_name=$1
  local new_values=("Modified" "Array")

  # Create the command to modify the array using eval
  eval "${array_name}=(\"\${new_values[@]}\")"
}

# Create an array
my_array=("Original" "Values")

echo "Before modification: ${my_array[@]}"

# Call the function and pass the array variable name
modify_array "my_array"

echo "After modification: ${my_array[@]}"

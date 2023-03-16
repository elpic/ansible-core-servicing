declare -a plugin_and_versions=(
	"skaffold,2.2.0"
	"skaffold,1.39.1"
	"gcloud,latest"
	"helm,3.11.2"
)

# This function receive a function that is going to be executed
# with every plugin in the list of plugins if a plugin was already
# in executed is not going to be executed twice
#
# $1 a function that is going to be executed for each plugin
execute_on_each_plugins() {
	declare -a unique_plugins=()

	for item in "${plugin_and_versions[@]}"; do
		plugin=$(echo "$item" | cut -d',' -f1)

		if [[ ! "${unique_plugins[*]}" =~ $plugin ]]; then
			unique_plugins+=("$plugin")
		fi
	done

	for plugin in "${unique_plugins[@]}"; do
		$1 "$plugin"
	done
}

# This function receive a function that is going to be executed
# with every plugin and the version of the software we are trying to
# install
#
# $1 a function that is going to be executed for each plugin
execute_on_each_software() {
	for item in "${plugin_and_versions[@]}"; do
		plugin=$(echo "$item" | cut -d',' -f1)
		version=$(echo "$item" | cut -d',' -f2)

		$1 "$plugin" "$version"
	done
}

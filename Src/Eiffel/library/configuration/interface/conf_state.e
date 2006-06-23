indexing
	description: "Represent a conditioned state."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_STATE

inherit
	CONF_VALIDITY

create
	make

feature {NONE} -- Initialization

	make (a_platform: like platform; a_build: like build; a_multithreaded: like is_multithreaded; a_dotnet: like is_dotnet; a_dynamic_runtime: like is_dynamic_runtime; a_variables: like custom_variables; a_version: like version) is
			-- Create.
		require
			valid_platform: valid_platform (a_platform)
			valid_build: valid_build (a_build)
			a_variables_not_void: a_variables /= Void
			a_version_not_void: a_version /= Void
		do
			platform := a_platform
			build := a_build
			is_multithreaded := a_multithreaded
			is_dotnet := a_dotnet
			is_dynamic_runtime := a_dynamic_runtime
			custom_variables := a_variables
			version := a_version
		ensure
			platform_set: platform = a_platform
			build_set: build = a_build
			multithreaded_set: is_multithreaded = a_multithreaded
			dotnet_set: is_dotnet = a_dotnet
			dynamic_runtime_set: is_dynamic_runtime = a_dynamic_runtime
			variables_set: custom_variables = a_variables
			version_set: version = a_version
		end

feature -- Access

	platform: INTEGER
			-- Current platform.

	build: INTEGER
			-- Current build type.

	is_multithreaded: BOOLEAN
			-- Multithreaded?

	is_dotnet: BOOLEAN
			-- Dotnet?

	is_dynamic_runtime: BOOLEAN
			-- Dynamic runtime?

	version: HASH_TABLE [CONF_VERSION, STRING]
			-- Versions?

	custom_variables: EQUALITY_HASH_TABLE [STRING, STRING]
			-- User defined variables.

invariant
	valid_platform: valid_platform (platform)
	valid_build: valid_build (build)
	version_set: version /= Void
	custom_variables_not_void: custom_variables /= Void

end

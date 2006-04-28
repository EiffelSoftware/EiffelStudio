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

	make (a_platform: like platform; a_build: like build; a_multithreaded: like is_multithreaded; a_dotnet: like is_dotnet; a_variables: like custom_variables) is
			-- Create.
		require
			valid_platform: valid_platform (a_platform)
			valid_build: valid_build (a_build)
			a_variables_not_void: a_variables /= Void
		do
			platform := a_platform
			build := a_build
			is_multithreaded := a_multithreaded
			is_dotnet := a_dotnet
			custom_variables := a_variables
		ensure
			platform_set: platform = a_platform
			build_set: build = a_build
			multithreaded_set: is_multithreaded = a_multithreaded
			dotnet_set: is_dotnet = a_dotnet
			variables_set: custom_variables = a_variables
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

	custom_variables: CONF_HASH_TABLE [STRING, STRING]
			-- User defined variables.

invariant
	valid_platform: valid_platform (platform)
	valid_build: valid_build (build)
	custom_variables_not_void: custom_variables /= Void

end

indexing
	description: ".NET version specific assembly loader"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_LOADER_IMPL

feature {NONE}

	dotnet_load (a_name: SYSTEM_STRING): ASSEMBLY is
			-- Attempts to load from a full assembly name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: a_name.length > 0
		do
			Result := {ASSEMBLY}.load (a_name)
		end

	dotnet_load_from (a_path: SYSTEM_STRING): ASSEMBLY is
			-- Attempts to load from a full path `a_path'
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: a_path.length > 0
		do
			Result := {ASSEMBLY}.load_from (a_path)
		end

end -- class {ASSEMBLY_LOADER_IMPL}

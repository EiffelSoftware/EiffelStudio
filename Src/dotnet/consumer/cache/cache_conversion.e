indexing
	description: "Provide conversions from EAC types to .NET types"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_CONVERSION

inherit
	CACHE_ERRORS

create
	make,
	default_create

feature {NONE} -- Initialization

	make (path: STRING) is
			-- Set `cache_path' with `path'.
		require
			non_void_path: path /= Void
		do
			cache_path := clone (path)
			if cache_path.item (cache_path.count) /= '\' then
				cache_path.append ("\")
			end
		ensure
			path_set: (path.item (path.count) = '\' implies cache_path = path) and
						(path.item (path.count) /= '\' implies (cache_path.substring (1, path.count).is_equal (path) and
																cache_path.item (cache_path.count) = '\'))
		end
		
feature -- Access

	cache_path: STRING
			-- Associated cache path

feature -- Conversion

	assembly (ca: CONSUMED_ASSEMBLY): ASSEMBLY is
			-- .NET assembly corresponding to `ca'.
		require
			non_void_consumed_assembly: ca /= Void
		do
			Result := load_assembly (ca.out)
			if Result = Void and local_assemblies_path /= Void then
				Result := load_assembly_from_path (local_assemblies_path + ca.name + ".exe")
				if Result = Void then
					Result := load_assembly_from_path (local_assemblies_path + ca.name + ".dll")					
				end
			end
			if Result = Void then
				set_error (Assembly_not_found_error, ca.out)
			end
		end

feature {NONE} -- Implementation

	load_assembly (name: STRING): ASSEMBLY is
			-- Load assembly named `name'.
			-- Void if assembly not found.
		require
			non_void_path: name /= Void
			valid_path: not name.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := feature {ASSEMBLY}.load_string (name.to_cil)
			end
		rescue
			retried := True
			retry
		end
	
	load_assembly_from_path (path: STRING): ASSEMBLY is
			-- Load assembly located at `path'.
			-- Void if no assembly at `path'.
		require
			non_void_path: path /= Void
			valid_path: not path.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := feature {ASSEMBLY}.load_from (path.to_cil)
			end
		rescue
			retried := True
			retry
		end
	
	local_assemblies_path: STRING is
			-- Path to assemblies copied in EIFGEN
		do
			if internal_assembly_path = Void and cache_path /= Void then
				internal_assembly_path := cache_path + "..\W_Code\assemblies\"				
			end
			Result := internal_assembly_path
		ensure
			valid_path: Result /= Void implies Result.item (Result.count) = '\'
		end

	internal_assembly_path: STRING
			-- Cache value for `local_assembly_path'

end -- class CACHE_CONVERSION

indexing
	description: "Loads assemblies without raising a FILE_NOT_FOUND_EXCEPTION"
	date: "$Date$"
	revision: "$Revision$"

class
	SAFE_ASSEMBLY_LOADER

feature {NONE} -- Basic Operations

	load_assembly_from_path (a_path: STRING): ASSEMBLY is
			-- loads an assembly from `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := feature {ASSEMBLY}.load_from (a_path)
			end
		rescue
			l_retried := True
			retry
		end
		
	load_assembly_by_name (a_name: ASSEMBLY_NAME): ASSEMBLY is
			-- loads an assembly by `a_name'
		require
			non_void_name: a_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := feature {ASSEMBLY}.load (a_name)
			end
		rescue
			l_retried := True
			retry
		end
		
	load_assembly_from_full_name (a_name: STRING): ASSEMBLY is
			-- loads an assembly from it's full name
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := feature {ASSEMBLY}.load (a_name)
			end
		rescue
			l_retried := True
			retry
		end
		
	load_from_gac_or_path (a_path: STRING): ASSEMBLY is
			-- Attempt to load a version of assembly `a_path' from GAC, failing that
			-- the version loaded from `a_path' will be returned
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_assembly: ASSEMBLY
		do
			l_assembly := load_assembly_from_path (a_path)
			if l_assembly /= Void then
				Result := load_assembly_by_name (l_assembly.get_name)
				if Result = Void or not Result.global_assembly_cache then
					Result := l_assembly
				end
			end
		end

end -- class SAFE_ASSEMBLY_LOADER

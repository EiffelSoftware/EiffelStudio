indexing
	description: "Loads assemblies without raising a FILE_NOT_FOUND_EXCEPTION"
	date: "$Date$"
	revision: "$Revision$"

class
	SAFE_ASSEMBLY_LOADER
	
inherit
	KEY_ENCODER
		export
			{NONE} all
		end

feature -- Basic Operations

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
		
feature -- Query

	is_mscorlib (a_assembly: ASSEMBLY): BOOLEAN is
			-- is `a_assembly' mscorlib?
		require
			a_assembly_not_void: a_assembly /= Void
		local
			l_name: ASSEMBLY_NAME
			l_pkt: NATIVE_ARRAY [INTEGER_8]
		do
			l_name := a_assembly.get_name
			if ("mscorlib").is_equal (l_name.name) then
				l_pkt := l_name.get_public_key_token
				if l_pkt /= Void and then l_pkt.length > 0 then
					Result := encoded_key (l_pkt).as_lower.is_equal ("b77a5c561934e089")
				end				
			end
		end

end -- class SAFE_ASSEMBLY_LOADER

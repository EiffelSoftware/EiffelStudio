indexing
	description: "COM visible class representing an assemblies information"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_ASSEMBLY_INFORMATION
	
inherit
	SAFE_ASSEMBLY_LOADER
		export 
			{NONE} all
		end
	
	I_COM_ASSEMBLY_INFORMATION
		redefine
			name,
			version,
			culture,
			public_key_token,
			is_in_gac,
			is_consumed,
			consumed_folder_name
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (ass: CONSUMED_ASSEMBLY) is
			-- create an instance
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		require
			non_void_assembly: ass /= Void
		do
			impl := ass
		ensure
			impl_set: impl.is_equal (ass)
		end
		
feature -- Access

	name: SYSTEM_STRING is
			-- assembly name
		do
			Result := impl.name.to_cil
		end
		
	version: SYSTEM_STRING is
			-- assembly version
		do
			Result := impl.version.to_cil
		end
		
	culture: SYSTEM_STRING is
			-- assembly culture
		do
			Result := impl.culture.to_cil
		end
		
	public_key_token: SYSTEM_STRING is
			-- assembly public key token
		do
			if impl.key /= Void then
				Result := impl.key.to_cil
			else
				Result := ("").to_cil
			end
		end
		
	is_in_gac: BOOLEAN is
			-- Is assembly currently is GAC
		local
			l_assembly: ASSEMBLY
		do
			l_assembly := load_from_gac_or_path (impl.location)
			if l_assembly /= Void then
				if is_mscorlib (l_assembly) then
					Result := True
				else
					Result := l_assembly.global_assembly_cache
				end
			end
		end
		
	is_consumed: BOOLEAN is
			-- has assembly been consumed?
		do
			Result := impl.is_consumed
		end
		
	consumed_folder_name: SYSTEM_STRING is
			-- name of folder where assembly was consumed to
		do
			Result := impl.folder_name
		end	
		
feature {NONE} -- Implementation

	impl: CONSUMED_ASSEMBLY
			-- Implementation object.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		end
		
invariant
	non_void_impl: impl /= Void

end -- class COM_ASSEMBLY_INFORMATION

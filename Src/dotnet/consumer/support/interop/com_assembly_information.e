indexing
	description: "COM visible class representing an assemblies information"
	date: "$Date$"
	revision: "$Revision$"
	interface_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE100-F122-4DD9-914E-E37ED8FF236C") end

class
	COM_ASSEMBLY_INFORMATION
	
inherit
	SAFE_ASSEMBLY_LOADER
		export 
			{NONE} all
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
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end
		
	version: SYSTEM_STRING is
			-- assembly version
		do
			Result := impl.version.to_cil
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end
		
	culture: SYSTEM_STRING is
			-- assembly culture
		do
			Result := impl.culture.to_cil
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end
		
	public_key_token: SYSTEM_STRING is
			-- assembly public key token
		do
			if impl.key /= Void then
				Result := impl.key.to_cil
			else
				Result := ("").to_cil
			end
		ensure
			non_void_result: Result /= Void
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

indexing
	description: "COM visible class representing an assemblies information"
	date: "$Date$"
	revision: "$Revision$"
	interface_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE1B6-5067-499a-9A25-E6DDA9076E77") end

class
	COM_ASSEMBLY_INFORMATION
	
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

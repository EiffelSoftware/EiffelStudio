indexing
	description: "COM visible class representing an assemblies information"
	date: "$Date$"
	revision: "$Revision$"
	attribute: create {COM_VISIBLE_ATTRIBUTE}.make (True) end, 
		create {CLASS_INTERFACE_ATTRIBUTE}.make_from_class_interface_type (feature {CLASS_INTERFACE_TYPE}.none.to_integer.to_integer_16) end

class
	COM_ASSEMBLY_INFORMATION
	
create
	make
	
feature {NONE} -- Initialization

	make (ass: CONSUMED_ASSEMBLY) is
			-- create an instance
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
			non_empty_result: Result.get_length > 0
		end
		
	version: SYSTEM_STRING is
			-- assembly version
		do
			Result := impl.version.to_cil
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.get_length > 0
		end
		
	culture: SYSTEM_STRING is
			-- assembly culture
		do
			Result := impl.culture.to_cil
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.get_length > 0
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
		
feature {NONE} -- Implementation

	impl: CONSUMED_ASSEMBLY
		
invariant
	non_void_impl: impl /= Void

end -- class COM_ASSEMBLY_INFORMATION

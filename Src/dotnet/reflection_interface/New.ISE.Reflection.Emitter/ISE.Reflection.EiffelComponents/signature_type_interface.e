indexing
	description: "Signature type interface"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

deferred class
	SIGNATURE_TYPE_INTERFACE
	
inherit
	HASHABLE

feature -- Access

	type_eiffel_name: STRING is
		indexing
			description: "Type Eiffel name"
		deferred
		end
	
	type_full_external_name: STRING is
		indexing
			description: "Type external name (full name)"
		deferred
		end
		
	hash_code: INTEGER is
			-- 
		do
			Result := type_full_external_name.hash_code
		end
		
		
feature -- Status Setting

	set_type_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `type_eiffel_name' with `a_name'."
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			type_eiffel_name_set: type_eiffel_name.is_equal (a_name)
		end

	set_type_full_external_name (a_name: STRING) is
		indexing
			description: "Set `type_full_external_name' with `a_name'."
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			type_full_external_name_set: type_full_external_name.is_equal (a_name)
		end
		
end -- class SIGNATURE_TYPE_INTERFACE

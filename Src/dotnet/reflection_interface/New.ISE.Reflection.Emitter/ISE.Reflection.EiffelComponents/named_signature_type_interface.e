indexing
	description: "Named signature type interface"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

deferred class
	NAMED_SIGNATURE_TYPE_INTERFACE

inherit
	SIGNATURE_TYPE_INTERFACE
	
feature -- Access

	eiffel_name: STRING is
		indexing
			description: "Eiffel name"
		deferred
		end
	
	external_name: STRING is
		indexing
			description: "External name"
		deferred
		end
		
feature -- Status Setting

	set_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			eiffel_name_set: eiffel_name.is_equal (a_name)
		end

	set_external_name (a_name: STRING) is
		indexing
			description: "Set `external_name' with `a_name'."
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			external_name_set: external_name.is_equal (a_name)
		end

end -- class NAMED_SIGNATURE_TYPE_INTERFACE

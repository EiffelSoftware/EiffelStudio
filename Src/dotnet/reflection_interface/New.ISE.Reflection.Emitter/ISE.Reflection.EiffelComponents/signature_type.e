indexing
	description: "Signature type"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE_INTERFACE
	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end

feature -- Access

	type_eiffel_name: STRING is
		indexing
			description: "Type Eiffel name"
		do
			Result := internal_type_eiffel_name
		end
	
	type_full_external_name: STRING is
		indexing
			description: "Type external name (full name)"
		do
			Result := internal_type_full_external_name
		end
		
feature -- Status Setting

	set_type_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `type_eiffel_name' with `a_name'."
		do
			internal_type_eiffel_name := a_name
		end

	set_type_full_external_name (a_name: STRING) is
		indexing
			description: "Set `type_full_external_name' with `a_name'."
		do
			internal_type_full_external_name := a_name
		end

feature {NONE} -- Implementation

	internal_type_eiffel_name: STRING 
		indexing
			description: "Value returned by `type_eiffel_name'"
		end

	internal_type_full_external_name: STRING 
		indexing
			description: "Value returned by `type_full_external_name'"
		end
		
end -- class SIGNATURE_TYPE

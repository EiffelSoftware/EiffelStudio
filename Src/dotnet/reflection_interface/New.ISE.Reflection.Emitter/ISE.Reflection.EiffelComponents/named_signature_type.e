indexing
	description: "Named signature type (e.g. a routine argument)"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	NAMED_SIGNATURE_TYPE

inherit
	NAMED_SIGNATURE_TYPE_INTERFACE

	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end
		
feature -- Access

	eiffel_name: STRING is
		indexing
			description: "Eiffel name"
		do
			Result := internal_eiffel_name
		end
	
	external_name: STRING is
		indexing
			description: "External name"
		do
			Result := internal_external_name
		end

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

	set_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
		do
			internal_eiffel_name := a_name
		end

	set_external_name (a_name: STRING) is
		indexing
			description: "Set `external_name' with `a_name'."
		do
			internal_external_name := a_name
		end

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

	internal_eiffel_name: STRING
		indexing
			description: "Value returned by `eiffel_name'"
		end
		
	internal_external_name: STRING
		indexing
			description: "Value returned by `external_name'"
		end

	internal_type_eiffel_name: STRING 
		indexing
			description: "Value returned by `type_eiffel_name'"
		end

	internal_type_full_external_name: STRING 
		indexing
			description: "Value returned by `type_full_external_name'"
		end

end -- class NAMED_SIGNATURE_TYPE

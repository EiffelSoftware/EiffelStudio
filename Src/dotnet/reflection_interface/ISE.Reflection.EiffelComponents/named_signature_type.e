indexing
	description: "Named signature type (e.g. a routine argument)"
	external_name: "ISE.Reflection.NamedSignatureType"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

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
			external_name: "Make"
		do
		end
		
feature -- Access

	eiffel_name: STRING is
		indexing
			description: "Eiffel name"
			external_name: "EiffelName"
		do
			Result := internal_eiffel_name
		end
	
	external_name: STRING is
		indexing
			description: "External name"
			external_name: "ExternalName"
		do
			Result := internal_external_name
		end

	type_eiffel_name: STRING is
		indexing
			description: "Type Eiffel name"
			external_name: "TypeEiffelName"
		do
			Result := internal_type_eiffel_name
		end
	
	type_full_external_name: STRING is
		indexing
			description: "Type external name (full name)"
			external_name: "TypeFullExternalName"
		do
			Result := internal_type_full_external_name
		end
		
feature -- Status Setting

	set_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
			external_name: "SetEiffelName"
		do
			internal_eiffel_name := a_name
		end

	set_external_name (a_name: STRING) is
		indexing
			description: "Set `external_name' with `a_name'."
			external_name: "SetExternalName"
		do
			internal_external_name := a_name
		end

	set_type_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `type_eiffel_name' with `a_name'."
			external_name: "SetTypeEiffelName"
		do
			internal_type_eiffel_name := a_name
		end

	set_type_full_external_name (a_name: STRING) is
		indexing
			description: "Set `type_full_external_name' with `a_name'."
			external_name: "SetTypeFullExternalName"
		do
			internal_type_full_external_name := a_name
		end


feature {NONE} -- Implementation

	internal_eiffel_name: STRING
		indexing
			description: "Value returned by `eiffel_name'"
			external_name: "InternalEiffelName"
		end
		
	internal_external_name: STRING
		indexing
			description: "Value returned by `external_name'"
			external_name: "InternalExternalName"
		end

	internal_type_eiffel_name: STRING 
		indexing
			description: "Value returned by `type_eiffel_name'"
			external_name: "InternalTypeEiffelName"
		end

	internal_type_full_external_name: STRING 
		indexing
			description: "Value returned by `type_full_external_name'"
			external_name: "InternalTypeFullExternalName"
		end

end -- class NAMED_SIGNATURE_TYPE

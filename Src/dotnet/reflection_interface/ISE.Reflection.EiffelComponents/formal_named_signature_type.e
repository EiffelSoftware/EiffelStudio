indexing
	description: "Formal named signature type"
	external_name: "ISE.Reflection.FormalNamedSignatureType"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	FORMAL_NAMED_SIGNATURE_TYPE

inherit
	FORMAL_SIGNATURE_TYPE
	
	NAMED_SIGNATURE_TYPE_INTERFACE

create 
	make
		
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
		
end -- class FORMAL_NAMED_SIGNATURE_TYPE

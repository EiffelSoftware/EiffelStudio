indexing
	description: "Named signature type (e.g. a routine argument)"
	external_name: "ISE.Reflection.NamedSignatureType"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	NAMED_SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE
	
create
	make

feature -- Access

	eiffel_name: STRING
		indexing
			description: "Eiffel name"
			external_name: "EiffelName"
		end
	
	external_name: STRING
		indexing
			description: "External name"
			external_name: "ExternalName"
		end

feature -- Status Setting

	set_eiffel_name (a_name: like eiffel_name) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
			external_name: "SetEiffelName"
		require
			non_void_name: a_name /= Void
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name.equals_string (a_name)
		end

	set_external_name (a_name: like external_name) is
		indexing
			description: "Set `external_name' with `a_name'."
			external_name: "SetExternalName"
		require
			non_void_name: a_name /= Void
		do
			external_name := a_name
		ensure
			external_name_set: external_name.equals_string (a_name)
		end

end -- class NAMED_SIGNATURE_TYPE

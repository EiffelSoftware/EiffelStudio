indexing
	description: "Named signature type (e.g. a routine argument)"
	external_name: "ISE.Reflection.NamedSignatureType"

class
	NAMED_SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE
	
create
	make

feature -- Access

	eiffel_name: STRING
			-- Eiffel name
		indexing
			external_name: "EiffelName"
		end
	
	external_name: STRING
			-- External name
		indexing
			external_name: "ExternalName"
		end

feature -- Status Setting

	set_eiffel_name (a_name: like eiffel_name) is
			-- Set `eiffel_name' with `a_name'.
		indexing
			external_name: "SetEiffelName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name.equals_string (a_name)
		end

	set_external_name (a_name: like external_name) is
			-- Set `external_name' with `a_name'.
		indexing
			external_name: "SetExternalName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			external_name := a_name
		ensure
			external_name_set: external_name.equals_string (a_name)
		end

end -- class NAMED_SIGNATURE_TYPE

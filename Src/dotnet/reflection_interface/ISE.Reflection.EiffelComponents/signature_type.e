indexing
	description: "Signature type"
	external_name: "ISE.Reflection.SignatureType"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	SIGNATURE_TYPE
	
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

	type_eiffel_name: STRING
		indexing
			description: "Type Eiffel name"
			external_name: "TypeEiffelName"
		end
	
	type_full_external_name: STRING
		indexing
			description: "Type external name (full name)"
			external_name: "TypeFullExternalName"
		end
		
feature -- Status Setting

	set_type_eiffel_name (a_name: like type_eiffel_name) is
		indexing
			description: "Set `type_eiffel_name' with `a_name'."
			external_name: "SetTypeEiffelName"
		require
			non_void_name: a_name /= Void
		do
			type_eiffel_name := a_name
		ensure
			type_eiffel_name_set: type_eiffel_name.equals_string (a_name)
		end

	set_type_full_external_name (a_name: like type_full_external_name) is
		indexing
			description: "Set `type_full_external_name' with `a_name'."
			external_name: "SetTypeFullExternalName"
		require
			non_void_name: a_name /= Void
		do
			type_full_external_name := a_name
		ensure
			type_full_external_name_set: type_full_external_name.equals_string (a_name)
		end
		
end -- class SIGNATURE_TYPE

indexing
	description: "Signature type interface"
	external_name: "ISE.Reflection.ISignatureType"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

deferred class
	SIGNATURE_TYPE_INTERFACE

feature -- Access

	type_eiffel_name: STRING is
		indexing
			description: "Type Eiffel name"
			external_name: "TypeEiffelName"
		deferred
		end
	
	type_full_external_name: STRING is
		indexing
			description: "Type external name (full name)"
			external_name: "TypeFullExternalName"
		deferred
		end
		
feature -- Status Setting

	set_type_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `type_eiffel_name' with `a_name'."
			external_name: "SetTypeEiffelName"
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			type_eiffel_name_set: type_eiffel_name.equals_string (a_name)
		end

	set_type_full_external_name (a_name: STRING) is
		indexing
			description: "Set `type_full_external_name' with `a_name'."
			external_name: "SetTypeFullExternalName"
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			type_full_external_name_set: type_full_external_name.equals_string (a_name)
		end
		
end -- class SIGNATURE_TYPE_INTERFACE

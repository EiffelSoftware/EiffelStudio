indexing
	description: "Named signature type interface"
	external_name: "ISE.Reflection.INamedSignatureType"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

deferred class
	NAMED_SIGNATURE_TYPE_INTERFACE

inherit
	SIGNATURE_TYPE_INTERFACE

feature -- Access

	eiffel_name: STRING is
		indexing
			description: "Eiffel name"
			external_name: "EiffelName"
		deferred
		end
	
	external_name: STRING is
		indexing
			description: "External name"
			external_name: "ExternalName"
		deferred
		end

feature -- Status Setting

	set_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
			external_name: "SetEiffelName"
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			eiffel_name_set: eiffel_name.equals_string (a_name)
		end

	set_external_name (a_name: STRING) is
		indexing
			description: "Set `external_name' with `a_name'."
			external_name: "SetExternalName"
		require
			non_void_name: a_name /= Void
		deferred
		ensure
			external_name_set: external_name.equals_string (a_name)
		end

end -- class NAMED_SIGNATURE_TYPE_INTERFACE

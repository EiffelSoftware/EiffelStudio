indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.NamedSignatureType"

external class
	ISE_REFLECTION_NAMEDSIGNATURETYPE

inherit
	ISE_REFLECTION_SIGNATURETYPE

create
	make_namedsignaturetype

feature {NONE} -- Initialization

	frozen make_namedsignaturetype is
		external
			"IL creator use ISE.Reflection.NamedSignatureType"
		end

feature -- Access

	get_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"get_ExternalName"
		end

	frozen a_internal_eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"_internal_EiffelName"
		end

	get_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"get_EiffelName"
		end

	frozen a_internal_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"_internal_ExternalName"
		end

feature -- Basic Operations

	set_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetEiffelName"
		end

	set_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetExternalName"
		end

end -- class ISE_REFLECTION_NAMEDSIGNATURETYPE

indexing
	Generator: "Eiffel Emitter 2.6b2"
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

	frozen external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"ExternalName"
		end

	frozen eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"EiffelName"
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

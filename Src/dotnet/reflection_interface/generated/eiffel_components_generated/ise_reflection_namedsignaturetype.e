indexing
	Generator: "Eiffel Emitter 2.3b"
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

	frozen EiffelName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"EiffelName"
		end

	frozen ExternalName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"ExternalName"
		end

feature -- Basic Operations

	SetExternalName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetExternalName"
		end

	SetEiffelName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetEiffelName"
		end

end -- class ISE_REFLECTION_NAMEDSIGNATURETYPE

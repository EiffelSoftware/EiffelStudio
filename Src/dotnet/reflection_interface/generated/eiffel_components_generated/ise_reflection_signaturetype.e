indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.SignatureType"
external class
	ISE_REFLECTION_SIGNATURETYPE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.SignatureType"
		end

feature -- Access

	frozen type_full_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"TypeFullExternalName"
		end

	frozen type_eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"TypeEiffelName"
		end

feature -- Basic Operations

	set_type_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.SignatureType"
		alias
			"SetTypeEiffelName"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.SignatureType"
		alias
			"Make"
		end

	set_type_full_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.SignatureType"
		alias
			"SetTypeFullExternalName"
		end

end -- class ISE_REFLECTION_SIGNATURETYPE

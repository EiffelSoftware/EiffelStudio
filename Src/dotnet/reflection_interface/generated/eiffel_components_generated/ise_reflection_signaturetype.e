indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	get_type_full_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SignatureType"
		alias
			"get_TypeFullExternalName"
		end

	frozen a_internal_type_full_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"_internal_TypeFullExternalName"
		end

	get_type_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SignatureType"
		alias
			"get_TypeEiffelName"
		end

	frozen a_internal_type_eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"_internal_TypeEiffelName"
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

indexing
	Generator: "Eiffel Emitter 2.4b2"
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

	frozen TypeEiffelName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"TypeEiffelName"
		end

	frozen TypeFullExternalName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"TypeFullExternalName"
		end

	frozen IsEnum: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.SignatureType"
		alias
			"IsEnum"
		end

feature -- Basic Operations

	SetTypeFullExternalName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.SignatureType"
		alias
			"SetTypeFullExternalName"
		end

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.SignatureType"
		alias
			"Make"
		end

	SetEnum (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.SignatureType"
		alias
			"SetEnum"
		end

	SetTypeEiffelName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.SignatureType"
		alias
			"SetTypeEiffelName"
		end

end -- class ISE_REFLECTION_SIGNATURETYPE

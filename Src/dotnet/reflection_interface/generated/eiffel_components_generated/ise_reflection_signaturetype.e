indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.SignatureType"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "e0f9d13739fa815f"

external class
	ISE_REFLECTION_SIGNATURETYPE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	ISE_REFLECTION_ISIGNATURETYPE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.SignatureType"
		end

feature -- Access

	get_internal_type_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SignatureType"
		alias
			"get_InternalTypeEiffelName"
		end

	get_internal_type_full_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SignatureType"
		alias
			"get_InternalTypeFullExternalName"
		end

	frozen a_internal_internal_type_full_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"_internal_InternalTypeFullExternalName"
		end

	frozen a_internal_internal_type_eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.SignatureType"
		alias
			"_internal_InternalTypeEiffelName"
		end

feature -- Basic Operations

	set_type_full_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.SignatureType"
		alias
			"SetTypeFullExternalName"
		end

	type_full_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SignatureType"
		alias
			"TypeFullExternalName"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.SignatureType"
		alias
			"Make"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.SignatureType"
		alias
			"GetHashCode"
		end

	set_type_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.SignatureType"
		alias
			"SetTypeEiffelName"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SignatureType"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use ISE.Reflection.SignatureType"
		alias
			"Equals"
		end

	type_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SignatureType"
		alias
			"TypeEiffelName"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use ISE.Reflection.SignatureType"
		alias
			"Finalize"
		end

end -- class ISE_REFLECTION_SIGNATURETYPE

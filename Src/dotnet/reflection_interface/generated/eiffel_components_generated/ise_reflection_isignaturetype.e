indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.ISignatureType"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "2dffe28036ebcb3"

deferred external class
	ISE_REFLECTION_ISIGNATURETYPE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	set_type_eiffel_name (a_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use ISE.Reflection.ISignatureType"
		alias
			"SetTypeEiffelName"
		end

	type_full_external_name: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.ISignatureType"
		alias
			"TypeFullExternalName"
		end

	type_eiffel_name: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.ISignatureType"
		alias
			"TypeEiffelName"
		end

	set_type_full_external_name (a_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use ISE.Reflection.ISignatureType"
		alias
			"SetTypeFullExternalName"
		end

end -- class ISE_REFLECTION_ISIGNATURETYPE

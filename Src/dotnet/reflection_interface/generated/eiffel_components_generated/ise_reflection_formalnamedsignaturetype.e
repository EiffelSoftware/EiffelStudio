indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.FormalNamedSignatureType"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "e0f9d13739fa815f"

external class
	ISE_REFLECTION_FORMALNAMEDSIGNATURETYPE

inherit
	ISE_REFLECTION_FORMALSIGNATURETYPE
	ISE_REFLECTION_ISIGNATURETYPE
	ISE_REFLECTION_INAMEDSIGNATURETYPE

create
	make_formalnamedsignaturetype

feature {NONE} -- Initialization

	frozen make_formalnamedsignaturetype is
		external
			"IL creator use ISE.Reflection.FormalNamedSignatureType"
		end

feature -- Access

	get_internal_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.FormalNamedSignatureType"
		alias
			"get_InternalExternalName"
		end

	get_internal_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.FormalNamedSignatureType"
		alias
			"get_InternalEiffelName"
		end

	frozen a_internal_internal_eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.FormalNamedSignatureType"
		alias
			"_internal_InternalEiffelName"
		end

	frozen a_internal_internal_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.FormalNamedSignatureType"
		alias
			"_internal_InternalExternalName"
		end

feature -- Basic Operations

	external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.FormalNamedSignatureType"
		alias
			"ExternalName"
		end

	set_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.FormalNamedSignatureType"
		alias
			"SetEiffelName"
		end

	set_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.FormalNamedSignatureType"
		alias
			"SetExternalName"
		end

	eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.FormalNamedSignatureType"
		alias
			"EiffelName"
		end

end -- class ISE_REFLECTION_FORMALNAMEDSIGNATURETYPE

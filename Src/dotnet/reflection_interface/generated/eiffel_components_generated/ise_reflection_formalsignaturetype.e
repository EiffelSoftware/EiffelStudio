indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.FormalSignatureType"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "2dffe28036ebcb3"

external class
	ISE_REFLECTION_FORMALSIGNATURETYPE

inherit
	ISE_REFLECTION_SIGNATURETYPE
	ISE_REFLECTION_ISIGNATURETYPE

create
	make_formalsignaturetype

feature {NONE} -- Initialization

	frozen make_formalsignaturetype is
		external
			"IL creator use ISE.Reflection.FormalSignatureType"
		end

feature -- Access

	frozen a_internal_generic_parameter_index: INTEGER is
		external
			"IL field signature :System.Int32 use ISE.Reflection.FormalSignatureType"
		alias
			"_internal_GenericParameterIndex"
		end

	get_generic_parameter_index: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.FormalSignatureType"
		alias
			"get_GenericParameterIndex"
		end

feature -- Basic Operations

	set_generic_parameter_index (an_index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use ISE.Reflection.FormalSignatureType"
		alias
			"SetGenericParameterIndex"
		end

end -- class ISE_REFLECTION_FORMALSIGNATURETYPE

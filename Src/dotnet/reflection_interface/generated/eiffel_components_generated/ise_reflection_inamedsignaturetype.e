indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.INamedSignatureType"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "2dffe28036ebcb3"

deferred external class
	ISE_REFLECTION_INAMEDSIGNATURETYPE

inherit
	ISE_REFLECTION_ISIGNATURETYPE

feature -- Basic Operations

	external_name: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.INamedSignatureType"
		alias
			"ExternalName"
		end

	set_eiffel_name (a_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use ISE.Reflection.INamedSignatureType"
		alias
			"SetEiffelName"
		end

	set_external_name (a_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use ISE.Reflection.INamedSignatureType"
		alias
			"SetExternalName"
		end

	eiffel_name: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.INamedSignatureType"
		alias
			"EiffelName"
		end

end -- class ISE_REFLECTION_INAMEDSIGNATURETYPE

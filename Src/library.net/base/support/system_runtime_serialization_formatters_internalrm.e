indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.Formatters.InternalRM"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_INTERNALRM

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.InternalRM"
		end

feature -- Basic Operations

	frozen soap_check_enabled: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Runtime.Serialization.Formatters.InternalRM"
		alias
			"SoapCheckEnabled"
		end

	frozen info_soap (messages: ARRAY [ANY]) is
		external
			"IL static signature (System.Object[]): System.Void use System.Runtime.Serialization.Formatters.InternalRM"
		alias
			"InfoSoap"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_INTERNALRM

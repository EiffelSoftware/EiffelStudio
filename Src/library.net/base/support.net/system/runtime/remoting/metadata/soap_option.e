indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.SoapOption"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SOAP_OPTION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen embed_all: SOAP_OPTION is
		external
			"IL enum signature :System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapOption"
		alias
			"4"
		end

	frozen xsd_string: SOAP_OPTION is
		external
			"IL enum signature :System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapOption"
		alias
			"2"
		end

	frozen option1: SOAP_OPTION is
		external
			"IL enum signature :System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapOption"
		alias
			"8"
		end

	frozen always_include_types: SOAP_OPTION is
		external
			"IL enum signature :System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapOption"
		alias
			"1"
		end

	frozen none: SOAP_OPTION is
		external
			"IL enum signature :System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapOption"
		alias
			"0"
		end

	frozen option2: SOAP_OPTION is
		external
			"IL enum signature :System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapOption"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SOAP_OPTION

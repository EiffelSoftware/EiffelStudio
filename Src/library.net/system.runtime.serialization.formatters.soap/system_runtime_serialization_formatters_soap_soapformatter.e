indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.Formatters.Soap.SoapFormatter"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SOAP_SOAPFORMATTER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_IFORMATTER
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IREMOTINGFORMATTER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		end

	frozen make_1 (selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.ISurrogateSelector, System.Runtime.Serialization.StreamingContext) use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		end

feature -- Access

	frozen get_surrogate_selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR is
		external
			"IL signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"get_SurrogateSelector"
		end

	frozen get_top_object: SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_ISOAPMESSAGE is
		external
			"IL signature (): System.Runtime.Serialization.Formatters.ISoapMessage use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"get_TopObject"
		end

	frozen get_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT is
		external
			"IL signature (): System.Runtime.Serialization.StreamingContext use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"get_Context"
		end

	frozen get_binder: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONBINDER is
		external
			"IL signature (): System.Runtime.Serialization.SerializationBinder use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"get_Binder"
		end

	frozen get_assembly_format: SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_FORMATTERASSEMBLYSTYLE is
		external
			"IL signature (): System.Runtime.Serialization.Formatters.FormatterAssemblyStyle use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"get_AssemblyFormat"
		end

	frozen get_type_format: SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_FORMATTERTYPESTYLE is
		external
			"IL signature (): System.Runtime.Serialization.Formatters.FormatterTypeStyle use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"get_TypeFormat"
		end

feature -- Element Change

	frozen set_binder (value: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONBINDER) is
		external
			"IL signature (System.Runtime.Serialization.SerializationBinder): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"set_Binder"
		end

	frozen set_context (value: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"set_Context"
		end

	frozen set_assembly_format (value: SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_FORMATTERASSEMBLYSTYLE) is
		external
			"IL signature (System.Runtime.Serialization.Formatters.FormatterAssemblyStyle): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"set_AssemblyFormat"
		end

	frozen set_top_object (value: SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_ISOAPMESSAGE) is
		external
			"IL signature (System.Runtime.Serialization.Formatters.ISoapMessage): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"set_TopObject"
		end

	frozen set_type_format (value: SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_FORMATTERTYPESTYLE) is
		external
			"IL signature (System.Runtime.Serialization.Formatters.FormatterTypeStyle): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"set_TypeFormat"
		end

	frozen set_surrogate_selector (value: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR) is
		external
			"IL signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"set_SurrogateSelector"
		end

feature -- Basic Operations

	frozen serialize_stream_object_array_header (serialization_stream: SYSTEM_IO_STREAM; graph: ANY; headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]) is
		external
			"IL signature (System.IO.Stream, System.Object, System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"Serialize"
		end

	frozen deserialize (serialization_stream: SYSTEM_IO_STREAM): ANY is
		external
			"IL signature (System.IO.Stream): System.Object use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"Deserialize"
		end

	frozen serialize (serialization_stream: SYSTEM_IO_STREAM; graph: ANY) is
		external
			"IL signature (System.IO.Stream, System.Object): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"Serialize"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"GetHashCode"
		end

	frozen deserialize_stream_header_handler (serialization_stream: SYSTEM_IO_STREAM; handler: SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADERHANDLER): ANY is
		external
			"IL signature (System.IO.Stream, System.Runtime.Remoting.Messaging.HeaderHandler): System.Object use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"Deserialize"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.Formatters.Soap.SoapFormatter"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SOAP_SOAPFORMATTER

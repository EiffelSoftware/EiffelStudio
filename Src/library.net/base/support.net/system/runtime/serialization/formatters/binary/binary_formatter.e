indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	BINARY_FORMATTER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IREMOTING_FORMATTER
	IFORMATTER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		end

	frozen make_1 (selector: ISURROGATE_SELECTOR; context: STREAMING_CONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.ISurrogateSelector, System.Runtime.Serialization.StreamingContext) use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		end

feature -- Access

	frozen get_surrogate_selector: ISURROGATE_SELECTOR is
		external
			"IL signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_SurrogateSelector"
		end

	frozen get_type_format: FORMATTER_TYPE_STYLE is
		external
			"IL signature (): System.Runtime.Serialization.Formatters.FormatterTypeStyle use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_TypeFormat"
		end

	frozen get_context: STREAMING_CONTEXT is
		external
			"IL signature (): System.Runtime.Serialization.StreamingContext use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_Context"
		end

	frozen get_binder: SERIALIZATION_BINDER is
		external
			"IL signature (): System.Runtime.Serialization.SerializationBinder use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_Binder"
		end

	frozen get_assembly_format: FORMATTER_ASSEMBLY_STYLE is
		external
			"IL signature (): System.Runtime.Serialization.Formatters.FormatterAssemblyStyle use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_AssemblyFormat"
		end

feature -- Element Change

	frozen set_binder (value: SERIALIZATION_BINDER) is
		external
			"IL signature (System.Runtime.Serialization.SerializationBinder): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_Binder"
		end

	frozen set_context (value: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_Context"
		end

	frozen set_assembly_format (value: FORMATTER_ASSEMBLY_STYLE) is
		external
			"IL signature (System.Runtime.Serialization.Formatters.FormatterAssemblyStyle): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_AssemblyFormat"
		end

	frozen set_type_format (value: FORMATTER_TYPE_STYLE) is
		external
			"IL signature (System.Runtime.Serialization.Formatters.FormatterTypeStyle): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_TypeFormat"
		end

	frozen set_surrogate_selector (value: ISURROGATE_SELECTOR) is
		external
			"IL signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_SurrogateSelector"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"ToString"
		end

	frozen serialize_stream_object_array_header (serialization_stream: SYSTEM_STREAM; graph: SYSTEM_OBJECT; headers: NATIVE_ARRAY [HEADER]) is
		external
			"IL signature (System.IO.Stream, System.Object, System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Serialize"
		end

	frozen serialize (serialization_stream: SYSTEM_STREAM; graph: SYSTEM_OBJECT) is
		external
			"IL signature (System.IO.Stream, System.Object): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Serialize"
		end

	frozen deserialize_method_response (serialization_stream: SYSTEM_STREAM; handler: HEADER_HANDLER; method_call_message: IMETHOD_CALL_MESSAGE): SYSTEM_OBJECT is
		external
			"IL signature (System.IO.Stream, System.Runtime.Remoting.Messaging.HeaderHandler, System.Runtime.Remoting.Messaging.IMethodCallMessage): System.Object use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"DeserializeMethodResponse"
		end

	frozen deserialize_stream_header_handler (serialization_stream: SYSTEM_STREAM; handler: HEADER_HANDLER): SYSTEM_OBJECT is
		external
			"IL signature (System.IO.Stream, System.Runtime.Remoting.Messaging.HeaderHandler): System.Object use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Deserialize"
		end

	frozen deserialize (serialization_stream: SYSTEM_STREAM): SYSTEM_OBJECT is
		external
			"IL signature (System.IO.Stream): System.Object use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Deserialize"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Finalize"
		end

end -- class BINARY_FORMATTER

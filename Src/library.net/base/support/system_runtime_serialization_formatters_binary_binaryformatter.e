indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_BINARY_BINARYFORMATTER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IREMOTINGFORMATTER
	SYSTEM_RUNTIME_SERIALIZATION_IFORMATTER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		end

	frozen make_1 (selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR; context2: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.ISurrogateSelector, System.Runtime.Serialization.StreamingContext) use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		end

feature -- Access

	frozen get_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT is
		external
			"IL signature (): System.Runtime.Serialization.StreamingContext use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_Context"
		end

	frozen get_surrogate_selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR is
		external
			"IL signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_SurrogateSelector"
		end

	frozen get_type_format: INTEGER is
		external
			"IL signature (): enum System.Runtime.Serialization.Formatters.FormatterTypeStyle use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_TypeFormat"
		ensure
			valid_formatter_type_style: Result = 0 or Result = 1 or Result = 2
		end

	frozen get_assembly_format: INTEGER is
		external
			"IL signature (): enum System.Runtime.Serialization.Formatters.FormatterAssemblyStyle use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_AssemblyFormat"
		ensure
			valid_formatter_assembly_style: Result = 0 or Result = 1
		end

	frozen get_binder: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONBINDER is
		external
			"IL signature (): System.Runtime.Serialization.SerializationBinder use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"get_Binder"
		end

feature -- Element Change

	frozen set_surrogate_selector (value: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR) is
		external
			"IL signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_SurrogateSelector"
		end

	frozen set_binder (value: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONBINDER) is
		external
			"IL signature (System.Runtime.Serialization.SerializationBinder): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_Binder"
		end

	frozen set_assembly_format (value: INTEGER) is
			-- Valid values for `value' are:
			-- Simple = 0
			-- Full = 1
		require
			valid_formatter_assembly_style: value = 0 or value = 1
		external
			"IL signature (enum System.Runtime.Serialization.Formatters.FormatterAssemblyStyle): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_AssemblyFormat"
		end

	frozen set_context (value: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_Context"
		end

	frozen set_type_format (value: INTEGER) is
			-- Valid values for `value' are:
			-- TypesWhenNeeded = 0
			-- TypesAlways = 1
			-- XsdString = 2
		require
			valid_formatter_type_style: value = 0 or value = 1 or value = 2
		external
			"IL signature (enum System.Runtime.Serialization.Formatters.FormatterTypeStyle): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"set_TypeFormat"
		end

feature -- Basic Operations

	frozen deserialize_method_response (serializationStream: SYSTEM_IO_STREAM; handler: SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADERHANDLER; methodCallMessage: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE): ANY is
		external
			"IL signature (System.IO.Stream, System.Runtime.Remoting.Messaging.HeaderHandler, System.Runtime.Remoting.Messaging.IMethodCallMessage): System.Object use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"DeserializeMethodResponse"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Equals"
		end

	frozen deserialize (serializationStream: SYSTEM_IO_STREAM): ANY is
		external
			"IL signature (System.IO.Stream): System.Object use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Deserialize"
		end

	frozen deserialize_stream_header_handler (serializationStream: SYSTEM_IO_STREAM; handler: SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADERHANDLER): ANY is
		external
			"IL signature (System.IO.Stream, System.Runtime.Remoting.Messaging.HeaderHandler): System.Object use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Deserialize"
		end

	frozen serialize_stream_object_array_header (serializationStream: SYSTEM_IO_STREAM; graph: ANY; headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]) is
		external
			"IL signature (System.IO.Stream, System.Object, System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Serialize"
		end

	frozen serialize (serializationStream: SYSTEM_IO_STREAM; graph: ANY) is
		external
			"IL signature (System.IO.Stream, System.Object): System.Void use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"Serialize"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.Binary.BinaryFormatter"
		alias
			"ToString"
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

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_BINARY_BINARYFORMATTER

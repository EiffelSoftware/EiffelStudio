indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.IFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IFORMATTER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_surrogate_selector: ISURROGATE_SELECTOR is
		external
			"IL deferred signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.IFormatter"
		alias
			"get_SurrogateSelector"
		end

	get_context: STREAMING_CONTEXT is
		external
			"IL deferred signature (): System.Runtime.Serialization.StreamingContext use System.Runtime.Serialization.IFormatter"
		alias
			"get_Context"
		end

	get_binder: SERIALIZATION_BINDER is
		external
			"IL deferred signature (): System.Runtime.Serialization.SerializationBinder use System.Runtime.Serialization.IFormatter"
		alias
			"get_Binder"
		end

feature -- Element Change

	set_binder (value: SERIALIZATION_BINDER) is
		external
			"IL deferred signature (System.Runtime.Serialization.SerializationBinder): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"set_Binder"
		end

	set_context (value: STREAMING_CONTEXT) is
		external
			"IL deferred signature (System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"set_Context"
		end

	set_surrogate_selector (value: ISURROGATE_SELECTOR) is
		external
			"IL deferred signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"set_SurrogateSelector"
		end

feature -- Basic Operations

	deserialize (serialization_stream: SYSTEM_STREAM): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.IO.Stream): System.Object use System.Runtime.Serialization.IFormatter"
		alias
			"Deserialize"
		end

	serialize (serialization_stream: SYSTEM_STREAM; graph: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.IO.Stream, System.Object): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"Serialize"
		end

end -- class IFORMATTER

indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.IFormatter"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_IFORMATTER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT is
		external
			"IL deferred signature (): System.Runtime.Serialization.StreamingContext use System.Runtime.Serialization.IFormatter"
		alias
			"get_Context"
		end

	get_surrogate_selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR is
		external
			"IL deferred signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.IFormatter"
		alias
			"get_SurrogateSelector"
		end

	get_binder: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONBINDER is
		external
			"IL deferred signature (): System.Runtime.Serialization.SerializationBinder use System.Runtime.Serialization.IFormatter"
		alias
			"get_Binder"
		end

feature -- Element Change

	set_surrogate_selector (value: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR) is
		external
			"IL deferred signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"set_SurrogateSelector"
		end

	set_binder (value: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONBINDER) is
		external
			"IL deferred signature (System.Runtime.Serialization.SerializationBinder): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"set_Binder"
		end

	set_context (value: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL deferred signature (System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"set_Context"
		end

feature -- Basic Operations

	deserialize (serializationStream: SYSTEM_IO_STREAM): ANY is
		external
			"IL deferred signature (System.IO.Stream): System.Object use System.Runtime.Serialization.IFormatter"
		alias
			"Deserialize"
		end

	serialize (serializationStream: SYSTEM_IO_STREAM; graph: ANY) is
		external
			"IL deferred signature (System.IO.Stream, System.Object): System.Void use System.Runtime.Serialization.IFormatter"
		alias
			"Serialize"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_IFORMATTER

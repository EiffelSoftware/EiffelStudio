indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.ISurrogateSelector"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	chain_selector (selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR) is
		external
			"IL deferred signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.ISurrogateSelector"
		alias
			"ChainSelector"
		end

	get_surrogate (type: SYSTEM_TYPE; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT; selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR): SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZATIONSURROGATE is
		external
			"IL deferred signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector&): System.Runtime.Serialization.ISerializationSurrogate use System.Runtime.Serialization.ISurrogateSelector"
		alias
			"GetSurrogate"
		end

	get_next_selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR is
		external
			"IL deferred signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.ISurrogateSelector"
		alias
			"GetNextSelector"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR

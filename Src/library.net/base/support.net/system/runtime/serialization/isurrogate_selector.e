indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.ISurrogateSelector"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISURROGATE_SELECTOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_next_selector: ISURROGATE_SELECTOR is
		external
			"IL deferred signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.ISurrogateSelector"
		alias
			"GetNextSelector"
		end

	get_surrogate (type: TYPE; context: STREAMING_CONTEXT; selector: ISURROGATE_SELECTOR): ISERIALIZATION_SURROGATE is
		external
			"IL deferred signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector&): System.Runtime.Serialization.ISerializationSurrogate use System.Runtime.Serialization.ISurrogateSelector"
		alias
			"GetSurrogate"
		end

	chain_selector (selector: ISURROGATE_SELECTOR) is
		external
			"IL deferred signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.ISurrogateSelector"
		alias
			"ChainSelector"
		end

end -- class ISURROGATE_SELECTOR

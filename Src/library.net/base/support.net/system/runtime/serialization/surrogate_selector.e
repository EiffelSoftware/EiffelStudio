indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.SurrogateSelector"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SURROGATE_SELECTOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISURROGATE_SELECTOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.SurrogateSelector"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SurrogateSelector"
		alias
			"ToString"
		end

	get_surrogate (type: TYPE; context: STREAMING_CONTEXT; selector: ISURROGATE_SELECTOR): ISERIALIZATION_SURROGATE is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector&): System.Runtime.Serialization.ISerializationSurrogate use System.Runtime.Serialization.SurrogateSelector"
		alias
			"GetSurrogate"
		end

	get_next_selector: ISURROGATE_SELECTOR is
		external
			"IL signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.SurrogateSelector"
		alias
			"GetNextSelector"
		end

	chain_selector (selector: ISURROGATE_SELECTOR) is
		external
			"IL signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.SurrogateSelector"
		alias
			"ChainSelector"
		end

	remove_surrogate (type: TYPE; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.SurrogateSelector"
		alias
			"RemoveSurrogate"
		end

	add_surrogate (type: TYPE; context: STREAMING_CONTEXT; surrogate: ISERIALIZATION_SURROGATE) is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISerializationSurrogate): System.Void use System.Runtime.Serialization.SurrogateSelector"
		alias
			"AddSurrogate"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.SurrogateSelector"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.SurrogateSelector"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.SurrogateSelector"
		alias
			"Finalize"
		end

end -- class SURROGATE_SELECTOR

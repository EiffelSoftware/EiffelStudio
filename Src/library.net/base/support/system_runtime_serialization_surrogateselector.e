indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.SurrogateSelector"

external class
	SYSTEM_RUNTIME_SERIALIZATION_SURROGATESELECTOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.SurrogateSelector"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SurrogateSelector"
		alias
			"ToString"
		end

	get_surrogate (type: SYSTEM_TYPE; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT; selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR): SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZATIONSURROGATE is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector&): System.Runtime.Serialization.ISerializationSurrogate use System.Runtime.Serialization.SurrogateSelector"
		alias
			"GetSurrogate"
		end

	get_next_selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR is
		external
			"IL signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Serialization.SurrogateSelector"
		alias
			"GetNextSelector"
		end

	chain_selector (selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR) is
		external
			"IL signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Serialization.SurrogateSelector"
		alias
			"ChainSelector"
		end

	remove_surrogate (type: SYSTEM_TYPE; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.SurrogateSelector"
		alias
			"RemoveSurrogate"
		end

	add_surrogate (type: SYSTEM_TYPE; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT; surrogate: SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZATIONSURROGATE) is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISerializationSurrogate): System.Void use System.Runtime.Serialization.SurrogateSelector"
		alias
			"AddSurrogate"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_SERIALIZATION_SURROGATESELECTOR

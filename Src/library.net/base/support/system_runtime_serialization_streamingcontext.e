indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.StreamingContext"

frozen expanded external class
	SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal
		end

feature -- Initialization

	frozen make_streamingcontext (state: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES) is
		external
			"IL creator signature (System.Runtime.Serialization.StreamingContextStates) use System.Runtime.Serialization.StreamingContext"
		end

	frozen make_streamingcontext_1 (state: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES; additional: ANY) is
		external
			"IL creator signature (System.Runtime.Serialization.StreamingContextStates, System.Object) use System.Runtime.Serialization.StreamingContext"
		end

feature -- Access

	frozen get_context: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.StreamingContext"
		alias
			"get_Context"
		end

	frozen get_state: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL signature (): System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContext"
		alias
			"get_State"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.StreamingContext"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.StreamingContext"
		alias
			"Equals"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT

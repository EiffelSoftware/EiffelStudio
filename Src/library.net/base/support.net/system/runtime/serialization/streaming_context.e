indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.StreamingContext"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	STREAMING_CONTEXT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Initialization

	frozen make_streaming_context_1 (state: STREAMING_CONTEXT_STATES; additional: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Runtime.Serialization.StreamingContextStates, System.Object) use System.Runtime.Serialization.StreamingContext"
		end

	frozen make_streaming_context (state: STREAMING_CONTEXT_STATES) is
		external
			"IL creator signature (System.Runtime.Serialization.StreamingContextStates) use System.Runtime.Serialization.StreamingContext"
		end

feature -- Access

	frozen get_context: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.StreamingContext"
		alias
			"get_Context"
		end

	frozen get_state: STREAMING_CONTEXT_STATES is
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

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.StreamingContext"
		alias
			"Equals"
		end

end -- class STREAMING_CONTEXT

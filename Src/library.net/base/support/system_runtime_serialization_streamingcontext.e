indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.StreamingContext"

frozen expanded external class
	SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal
		end



feature {NONE} -- Initialization

	frozen make_streaming_context (state2: INTEGER) is
			-- Valid values for `state2' are a combination of the following values:
			-- CrossProcess = 1
			-- CrossMachine = 2
			-- File = 4
			-- Persistence = 8
			-- Remoting = 16
			-- Other = 32
			-- Clone = 64
			-- CrossAppDomain = 128
			-- All = 255
		require
			valid_streaming_context_states: (1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 255) & state2 = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 255
		external
			"IL creator signature (enum System.Runtime.Serialization.StreamingContextStates) use System.Runtime.Serialization.StreamingContext"
		end

	frozen make_streaming_context_1 (state2: INTEGER; additional: ANY) is
			-- Valid values for `state2' are a combination of the following values:
			-- CrossProcess = 1
			-- CrossMachine = 2
			-- File = 4
			-- Persistence = 8
			-- Remoting = 16
			-- Other = 32
			-- Clone = 64
			-- CrossAppDomain = 128
			-- All = 255
		require
			valid_streaming_context_states: (1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 255) & state2 = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 255
		external
			"IL creator signature (enum System.Runtime.Serialization.StreamingContextStates, System.Object) use System.Runtime.Serialization.StreamingContext"
		end

feature -- Access

	frozen get_context: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.StreamingContext"
		alias
			"get_Context"
		end

	frozen get_state: INTEGER is
		external
			"IL signature (): enum System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContext"
		alias
			"get_State"
		ensure
			valid_streaming_context_states: Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 255
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.StreamingContext"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.StreamingContext"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT

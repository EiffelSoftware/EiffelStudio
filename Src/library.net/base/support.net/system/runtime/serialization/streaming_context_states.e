indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.StreamingContextStates"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	STREAMING_CONTEXT_STATES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen cross_process: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"1"
		end

	frozen cross_app_domain: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"128"
		end

	frozen file: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"4"
		end

	frozen remoting: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"16"
		end

	frozen other: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"32"
		end

	frozen clone_: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"64"
		end

	frozen all_: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"255"
		end

	frozen cross_machine: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"2"
		end

	frozen persistence: STREAMING_CONTEXT_STATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class STREAMING_CONTEXT_STATES

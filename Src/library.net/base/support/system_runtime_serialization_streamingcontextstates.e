indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.StreamingContextStates"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen cross_process: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"1"
		end

	frozen cross_app_domain: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"128"
		end

	frozen file: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"4"
		end

	frozen remoting: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"16"
		end

	frozen other: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"32"
		end

	frozen clone: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"64"
		end

	frozen persistence: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"8"
		end

	frozen cross_machine: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"2"
		end

	frozen All_: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES is
		external
			"IL enum signature :System.Runtime.Serialization.StreamingContextStates use System.Runtime.Serialization.StreamingContextStates"
		alias
			"255"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXTSTATES

indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.FlowControl"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FLOW_CONTROL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen phi: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"6"
		end

	frozen meta: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"4"
		end

	frozen break: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"1"
		end

	frozen next: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"5"
		end

	frozen branch: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"0"
		end

	frozen return: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"7"
		end

	frozen cond_branch: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"3"
		end

	frozen throw: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"8"
		end

	frozen call: FLOW_CONTROL is
		external
			"IL enum signature :System.Reflection.Emit.FlowControl use System.Reflection.Emit.FlowControl"
		alias
			"2"
		end

end -- class FLOW_CONTROL

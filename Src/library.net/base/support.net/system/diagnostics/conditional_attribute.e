indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.ConditionalAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CONDITIONAL_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_conditional_attribute

feature {NONE} -- Initialization

	frozen make_conditional_attribute (condition_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.ConditionalAttribute"
		end

feature -- Access

	frozen get_condition_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ConditionalAttribute"
		alias
			"get_ConditionString"
		end

end -- class CONDITIONAL_ATTRIBUTE

indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.DateTimeConstantAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATE_TIME_CONSTANT_ATTRIBUTE

inherit
	CUSTOM_CONSTANT_ATTRIBUTE

create
	make_date_time_constant_attribute

feature {NONE} -- Initialization

	frozen make_date_time_constant_attribute (ticks: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Runtime.CompilerServices.DateTimeConstantAttribute"
		end

feature -- Access

	get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.CompilerServices.DateTimeConstantAttribute"
		alias
			"get_Value"
		end

end -- class DATE_TIME_CONSTANT_ATTRIBUTE

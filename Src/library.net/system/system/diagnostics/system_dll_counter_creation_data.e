indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.CounterCreationData"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COUNTER_CREATION_DATA

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.CounterCreationData"
		end

	frozen make_1 (counter_name: SYSTEM_STRING; counter_help: SYSTEM_STRING; counter_type: SYSTEM_DLL_PERFORMANCE_COUNTER_TYPE) is
		external
			"IL creator signature (System.String, System.String, System.Diagnostics.PerformanceCounterType) use System.Diagnostics.CounterCreationData"
		end

feature -- Access

	frozen get_counter_help: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.CounterCreationData"
		alias
			"get_CounterHelp"
		end

	frozen get_counter_type: SYSTEM_DLL_PERFORMANCE_COUNTER_TYPE is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterType use System.Diagnostics.CounterCreationData"
		alias
			"get_CounterType"
		end

	frozen get_counter_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.CounterCreationData"
		alias
			"get_CounterName"
		end

feature -- Element Change

	frozen set_counter_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.CounterCreationData"
		alias
			"set_CounterName"
		end

	frozen set_counter_type (value: SYSTEM_DLL_PERFORMANCE_COUNTER_TYPE) is
		external
			"IL signature (System.Diagnostics.PerformanceCounterType): System.Void use System.Diagnostics.CounterCreationData"
		alias
			"set_CounterType"
		end

	frozen set_counter_help (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.CounterCreationData"
		alias
			"set_CounterHelp"
		end

end -- class SYSTEM_DLL_COUNTER_CREATION_DATA

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.CounterCreationData"

external class
	SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.CounterCreationData"
		end

	frozen make_1 (counter_name: STRING; counter_help: STRING; counter_type: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERTYPE) is
		external
			"IL creator signature (System.String, System.String, System.Diagnostics.PerformanceCounterType) use System.Diagnostics.CounterCreationData"
		end

feature -- Access

	frozen get_counter_help: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.CounterCreationData"
		alias
			"get_CounterHelp"
		end

	frozen get_counter_type: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERTYPE is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterType use System.Diagnostics.CounterCreationData"
		alias
			"get_CounterType"
		end

	frozen get_counter_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.CounterCreationData"
		alias
			"get_CounterName"
		end

feature -- Element Change

	frozen set_counter_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.CounterCreationData"
		alias
			"set_CounterName"
		end

	frozen set_counter_type (value: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERTYPE) is
		external
			"IL signature (System.Diagnostics.PerformanceCounterType): System.Void use System.Diagnostics.CounterCreationData"
		alias
			"set_CounterType"
		end

	frozen set_counter_help (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.CounterCreationData"
		alias
			"set_CounterHelp"
		end

end -- class SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA

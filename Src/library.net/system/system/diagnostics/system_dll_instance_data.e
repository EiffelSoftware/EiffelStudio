indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.InstanceData"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_INSTANCE_DATA

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (instance_name: SYSTEM_STRING; sample: SYSTEM_DLL_COUNTER_SAMPLE) is
		external
			"IL creator signature (System.String, System.Diagnostics.CounterSample) use System.Diagnostics.InstanceData"
		end

feature -- Access

	frozen get_raw_value: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.InstanceData"
		alias
			"get_RawValue"
		end

	frozen get_sample: SYSTEM_DLL_COUNTER_SAMPLE is
		external
			"IL signature (): System.Diagnostics.CounterSample use System.Diagnostics.InstanceData"
		alias
			"get_Sample"
		end

	frozen get_instance_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.InstanceData"
		alias
			"get_InstanceName"
		end

end -- class SYSTEM_DLL_INSTANCE_DATA

indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.PerformanceCounter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PERFORMANCE_COUNTER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISUPPORT_INITIALIZE

create
	make_system_dll_performance_counter,
	make_system_dll_performance_counter_4,
	make_system_dll_performance_counter_2,
	make_system_dll_performance_counter_3,
	make_system_dll_performance_counter_5,
	make_system_dll_performance_counter_1

feature {NONE} -- Initialization

	frozen make_system_dll_performance_counter is
		external
			"IL creator use System.Diagnostics.PerformanceCounter"
		end

	frozen make_system_dll_performance_counter_4 (category_name: SYSTEM_STRING; counter_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.PerformanceCounter"
		end

	frozen make_system_dll_performance_counter_2 (category_name: SYSTEM_STRING; counter_name: SYSTEM_STRING; instance_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Diagnostics.PerformanceCounter"
		end

	frozen make_system_dll_performance_counter_3 (category_name: SYSTEM_STRING; counter_name: SYSTEM_STRING; instance_name: SYSTEM_STRING; read_only: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.String, System.Boolean) use System.Diagnostics.PerformanceCounter"
		end

	frozen make_system_dll_performance_counter_5 (category_name: SYSTEM_STRING; counter_name: SYSTEM_STRING; read_only: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.Boolean) use System.Diagnostics.PerformanceCounter"
		end

	frozen make_system_dll_performance_counter_1 (category_name: SYSTEM_STRING; counter_name: SYSTEM_STRING; instance_name: SYSTEM_STRING; machine_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String, System.String) use System.Diagnostics.PerformanceCounter"
		end

feature -- Access

	frozen default_file_mapping_size: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Diagnostics.PerformanceCounter"
		alias
			"DefaultFileMappingSize"
		end

	frozen get_category_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounter"
		alias
			"get_CategoryName"
		end

	frozen get_counter_type: SYSTEM_DLL_PERFORMANCE_COUNTER_TYPE is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterType use System.Diagnostics.PerformanceCounter"
		alias
			"get_CounterType"
		end

	frozen get_counter_help: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounter"
		alias
			"get_CounterHelp"
		end

	frozen get_instance_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounter"
		alias
			"get_InstanceName"
		end

	frozen get_raw_value: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.PerformanceCounter"
		alias
			"get_RawValue"
		end

	frozen get_counter_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounter"
		alias
			"get_CounterName"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounter"
		alias
			"get_MachineName"
		end

	frozen get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.PerformanceCounter"
		alias
			"get_ReadOnly"
		end

feature -- Element Change

	frozen set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"set_ReadOnly"
		end

	frozen set_counter_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"set_CounterName"
		end

	frozen set_instance_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"set_InstanceName"
		end

	frozen set_raw_value (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"set_RawValue"
		end

	frozen set_machine_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"set_MachineName"
		end

	frozen set_category_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"set_CategoryName"
		end

feature -- Basic Operations

	frozen remove_instance is
		external
			"IL signature (): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"RemoveInstance"
		end

	frozen decrement: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.PerformanceCounter"
		alias
			"Decrement"
		end

	frozen increment_by (value: INTEGER_64): INTEGER_64 is
		external
			"IL signature (System.Int64): System.Int64 use System.Diagnostics.PerformanceCounter"
		alias
			"IncrementBy"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"Close"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"BeginInit"
		end

	frozen next_sample: SYSTEM_DLL_COUNTER_SAMPLE is
		external
			"IL signature (): System.Diagnostics.CounterSample use System.Diagnostics.PerformanceCounter"
		alias
			"NextSample"
		end

	frozen end_init is
		external
			"IL signature (): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"EndInit"
		end

	frozen increment: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.PerformanceCounter"
		alias
			"Increment"
		end

	frozen next_value: REAL is
		external
			"IL signature (): System.Single use System.Diagnostics.PerformanceCounter"
		alias
			"NextValue"
		end

	frozen close_shared_resources is
		external
			"IL static signature (): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"CloseSharedResources"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.PerformanceCounter"
		alias
			"Dispose"
		end

end -- class SYSTEM_DLL_PERFORMANCE_COUNTER

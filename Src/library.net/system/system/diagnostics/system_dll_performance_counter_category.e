indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.PerformanceCounterCategory"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (category_name: SYSTEM_STRING; machine_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.PerformanceCounterCategory"
		end

	frozen make is
		external
			"IL creator use System.Diagnostics.PerformanceCounterCategory"
		end

	frozen make_1 (category_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.PerformanceCounterCategory"
		end

feature -- Access

	frozen get_category_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterCategory"
		alias
			"get_CategoryName"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterCategory"
		alias
			"get_MachineName"
		end

	frozen get_category_help: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterCategory"
		alias
			"get_CategoryHelp"
		end

feature -- Element Change

	frozen set_machine_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterCategory"
		alias
			"set_MachineName"
		end

	frozen set_category_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterCategory"
		alias
			"set_CategoryName"
		end

feature -- Basic Operations

	frozen instance_exists_string_string (instance_name: SYSTEM_STRING; category_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"InstanceExists"
		end

	frozen instance_exists_string_string_string (instance_name: SYSTEM_STRING; category_name: SYSTEM_STRING; machine_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"InstanceExists"
		end

	frozen create__string_string_string (category_name: SYSTEM_STRING; category_help: SYSTEM_STRING; counter_name: SYSTEM_STRING; counter_help: SYSTEM_STRING): SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY is
		external
			"IL static signature (System.String, System.String, System.String, System.String): System.Diagnostics.PerformanceCounterCategory use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Create"
		end

	frozen get_categories_string (machine_name: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY] is
		external
			"IL static signature (System.String): System.Diagnostics.PerformanceCounterCategory[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCategories"
		end

	frozen read_category: SYSTEM_DLL_INSTANCE_DATA_COLLECTION_COLLECTION is
		external
			"IL signature (): System.Diagnostics.InstanceDataCollectionCollection use System.Diagnostics.PerformanceCounterCategory"
		alias
			"ReadCategory"
		end

	frozen get_instance_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetInstanceNames"
		end

	frozen delete (category_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Delete"
		end

	frozen get_counters_string (instance_name: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_DLL_PERFORMANCE_COUNTER] is
		external
			"IL signature (System.String): System.Diagnostics.PerformanceCounter[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCounters"
		end

	frozen counter_exists (counter_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"CounterExists"
		end

	frozen exists (category_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Exists"
		end

	frozen exists_string_string (category_name: SYSTEM_STRING; machine_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Exists"
		end

	frozen get_counters: NATIVE_ARRAY [SYSTEM_DLL_PERFORMANCE_COUNTER] is
		external
			"IL signature (): System.Diagnostics.PerformanceCounter[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCounters"
		end

	frozen counter_exists_string_string (counter_name: SYSTEM_STRING; category_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"CounterExists"
		end

	frozen get_categories: NATIVE_ARRAY [SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY] is
		external
			"IL static signature (): System.Diagnostics.PerformanceCounterCategory[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCategories"
		end

	frozen create_ (category_name: SYSTEM_STRING; category_help: SYSTEM_STRING; counter_data: SYSTEM_DLL_COUNTER_CREATION_DATA_COLLECTION): SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.CounterCreationDataCollection): System.Diagnostics.PerformanceCounterCategory use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Create"
		end

	frozen counter_exists_string_string_string (counter_name: SYSTEM_STRING; category_name: SYSTEM_STRING; machine_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"CounterExists"
		end

	frozen instance_exists (instance_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"InstanceExists"
		end

end -- class SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.PerformanceCounterCategory"

external class
	SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (category_name: STRING; machine_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.PerformanceCounterCategory"
		end

	frozen make is
		external
			"IL creator use System.Diagnostics.PerformanceCounterCategory"
		end

	frozen make_1 (category_name: STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.PerformanceCounterCategory"
		end

feature -- Access

	frozen get_category_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterCategory"
		alias
			"get_CategoryName"
		end

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterCategory"
		alias
			"get_MachineName"
		end

	frozen get_category_help: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterCategory"
		alias
			"get_CategoryHelp"
		end

feature -- Element Change

	frozen set_machine_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterCategory"
		alias
			"set_MachineName"
		end

	frozen set_category_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterCategory"
		alias
			"set_CategoryName"
		end

feature -- Basic Operations

	frozen create__string_string_string_string (category_name: STRING; category_help: STRING; counter_name: STRING; counter_help: STRING): SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY is
		external
			"IL static signature (System.String, System.String, System.String, System.String): System.Diagnostics.PerformanceCounterCategory use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Create"
		end

	frozen exists (category_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Exists"
		end

	frozen create__string_string_counter_creation_data_collection_string (category_name: STRING; category_help: STRING; counter_data: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATACOLLECTION; machine_name: STRING): SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.CounterCreationDataCollection, System.String): System.Diagnostics.PerformanceCounterCategory use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Create"
		end

	frozen instance_exists_string_string_string (instance_name: STRING; category_name: STRING; machine_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"InstanceExists"
		end

	frozen delete_string_string (category_name: STRING; machine_name: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Delete"
		end

	frozen get_categories_string (machine_name: STRING): ARRAY [SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY] is
		external
			"IL static signature (System.String): System.Diagnostics.PerformanceCounterCategory[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCategories"
		end

	frozen read_category: SYSTEM_DIAGNOSTICS_INSTANCEDATACOLLECTIONCOLLECTION is
		external
			"IL signature (): System.Diagnostics.InstanceDataCollectionCollection use System.Diagnostics.PerformanceCounterCategory"
		alias
			"ReadCategory"
		end

	frozen get_instance_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetInstanceNames"
		end

	frozen delete (category_name: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Delete"
		end

	frozen Create_ (category_name: STRING; category_help: STRING; counter_data: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATACOLLECTION): SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.CounterCreationDataCollection): System.Diagnostics.PerformanceCounterCategory use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Create"
		end

	frozen get_counters_string (instance_name: STRING): ARRAY [SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTER] is
		external
			"IL signature (System.String): System.Diagnostics.PerformanceCounter[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCounters"
		end

	frozen counter_exists (counter_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"CounterExists"
		end

	frozen create__string_string_string_string_string (category_name: STRING; category_help: STRING; counter_name: STRING; counter_help: STRING; machine_name: STRING): SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY is
		external
			"IL static signature (System.String, System.String, System.String, System.String, System.String): System.Diagnostics.PerformanceCounterCategory use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Create"
		end

	frozen exists_string_string (category_name: STRING; machine_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"Exists"
		end

	frozen get_counters: ARRAY [SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTER] is
		external
			"IL signature (): System.Diagnostics.PerformanceCounter[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCounters"
		end

	frozen instance_exists_string_string (instance_name: STRING; category_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"InstanceExists"
		end

	frozen counter_exists_string_string (counter_name: STRING; category_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"CounterExists"
		end

	frozen get_categories: ARRAY [SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY] is
		external
			"IL static signature (): System.Diagnostics.PerformanceCounterCategory[] use System.Diagnostics.PerformanceCounterCategory"
		alias
			"GetCategories"
		end

	frozen counter_exists_string_string_string (counter_name: STRING; category_name: STRING; machine_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"CounterExists"
		end

	frozen instance_exists (instance_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Diagnostics.PerformanceCounterCategory"
		alias
			"InstanceExists"
		end

end -- class SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERCATEGORY

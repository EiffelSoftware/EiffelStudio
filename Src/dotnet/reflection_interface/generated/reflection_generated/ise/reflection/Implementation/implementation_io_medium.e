indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.IO_MEDIUM"

deferred external class
	IMPLEMENTATION_IO_MEDIUM

inherit
	MEM_CONST
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	STRING_HANDLER
	IO_MEDIUM
	MEMORY

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_last_double: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.IO_MEDIUM"
		alias
			"$$last_double"
		end

	frozen ec_illegal_36_ec_illegal_36_last_real: REAL is
		external
			"IL field signature :System.Single use Implementation.IO_MEDIUM"
		alias
			"$$last_real"
		end

	frozen ec_illegal_36_ec_illegal_36_last_integer: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.IO_MEDIUM"
		alias
			"$$last_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_last_string: STRING is
		external
			"IL field signature :STRING use Implementation.IO_MEDIUM"
		alias
			"$$last_string"
		end

	frozen ec_illegal_36_ec_illegal_36_last_character: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.IO_MEDIUM"
		alias
			"$$last_character"
		end

feature -- Basic Operations

	is_in_final_collect: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"is_in_final_collect"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.IO_MEDIUM"
		alias
			"____class_name"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.IO_MEDIUM"
		alias
			"tagged_out"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"default_create"
		end

	full_coalesce is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"full_coalesce"
		end

	set_collection_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.IO_MEDIUM"
		alias
			"set_collection_period"
		end

	collect is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"collect"
		end

	a_set_last_character (last_character2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.IO_MEDIUM"
		alias
			"_set_last_character"
		end

	generation_object_limit: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"generation_object_limit"
		end

	is_plain_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"is_plain_text"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.IO_MEDIUM"
		alias
			"operating_environment"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.IO_MEDIUM"
		alias
			"copy"
		end

	lastchar: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.IO_MEDIUM"
		alias
			"lastchar"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"incremental_collector"
		end

	memory_statistics (memory_type: INTEGER): MEM_INFO is
		external
			"IL signature (System.Int32): MEM_INFO use Implementation.IO_MEDIUM"
		alias
			"memory_statistics"
		end

	last_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"last_integer"
		end

	a_set_last_string (last_string2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.IO_MEDIUM"
		alias
			"_set_last_string"
		end

	last_real: REAL is
		external
			"IL signature (): System.Single use Implementation.IO_MEDIUM"
		alias
			"last_real"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.IO_MEDIUM"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_lastdouble (current_: IO_MEDIUM): DOUBLE is
		external
			"IL static signature (IO_MEDIUM): System.Double use Implementation.IO_MEDIUM"
		alias
			"$$lastdouble"
		end

	enable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"enable_time_accounting"
		end

	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.IO_MEDIUM"
		alias
			"find_referers"
		end

	a_set_last_double (last_double2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.IO_MEDIUM"
		alias
			"_set_last_double"
		end

	frozen ec_illegal_36_ec_illegal_36_lastchar (current_: IO_MEDIUM): CHARACTER is
		external
			"IL static signature (IO_MEDIUM): System.Char use Implementation.IO_MEDIUM"
		alias
			"$$lastchar"
		end

	full_collect is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"full_collect"
		end

	frozen ec_illegal_36_ec_illegal_36_lastreal (current_: IO_MEDIUM): REAL is
		external
			"IL static signature (IO_MEDIUM): System.Single use Implementation.IO_MEDIUM"
		alias
			"$$lastreal"
		end

	last_string: STRING is
		external
			"IL signature (): STRING use Implementation.IO_MEDIUM"
		alias
			"last_string"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"eiffel_memory"
		end

	lastreal: REAL is
		external
			"IL signature (): System.Single use Implementation.IO_MEDIUM"
		alias
			"lastreal"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.IO_MEDIUM"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"GetHashCode"
		end

	laststring: STRING is
		external
			"IL signature (): STRING use Implementation.IO_MEDIUM"
		alias
			"laststring"
		end

	chunk_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"chunk_size"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.IO_MEDIUM"
		alias
			"default"
		end

	collection_off is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"collection_off"
		end

	a_set_last_real (last_real2: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.IO_MEDIUM"
		alias
			"_set_last_real"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"same_type"
		end

	last_character: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.IO_MEDIUM"
		alias
			"last_character"
		end

	frozen ec_illegal_36_ec_illegal_36_laststring (current_: IO_MEDIUM): STRING is
		external
			"IL static signature (IO_MEDIUM): STRING use Implementation.IO_MEDIUM"
		alias
			"$$laststring"
		end

	gc_monitoring (flag: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.IO_MEDIUM"
		alias
			"gc_monitoring"
		end

	frozen ec_illegal_36_ec_illegal_36_lastint (current_: IO_MEDIUM): INTEGER is
		external
			"IL static signature (IO_MEDIUM): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"$$lastint"
		end

	set_max_mem (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.IO_MEDIUM"
		alias
			"set_max_mem"
		end

	largest_coalesced_block: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"largest_coalesced_block"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"full_collector"
		end

	allocate_compact is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"allocate_compact"
		end

	tenure: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"tenure"
		end

	disable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"disable_time_accounting"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"do_nothing"
		end

	collection_on is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"collection_on"
		end

	max_mem: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"max_mem"
		end

	scavenge_zone_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"scavenge_zone_size"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"standard_is_equal"
		end

	gc_statistics (collector_type: INTEGER): GC_INFO is
		external
			"IL signature (System.Int32): GC_INFO use Implementation.IO_MEDIUM"
		alias
			"gc_statistics"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"conforms_to"
		end

	memory_threshold: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"memory_threshold"
		end

	allocate_fast is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"allocate_fast"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.IO_MEDIUM"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_dispose (current_: IO_MEDIUM) is
		external
			"IL static signature (IO_MEDIUM): System.Void use Implementation.IO_MEDIUM"
		alias
			"$$dispose"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"is_equal"
		end

	coalesce_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"coalesce_period"
		end

	referers (an_object: ANY): ARRAY_ANY is
		external
			"IL signature (ANY): ARRAY_ANY use Implementation.IO_MEDIUM"
		alias
			"referers"
		end

	collection_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"collection_period"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.IO_MEDIUM"
		alias
			"print"
		end

	set_memory_threshold (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.IO_MEDIUM"
		alias
			"set_memory_threshold"
		end

	frozen ec_illegal_36_ec_illegal_36_is_plain_text (current_: IO_MEDIUM): BOOLEAN is
		external
			"IL static signature (IO_MEDIUM): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"$$is_plain_text"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"equal"
		end

	lastint: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"lastint"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.IO_MEDIUM"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"standard_equal"
		end

	mem_free (addr: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.IO_MEDIUM"
		alias
			"mem_free"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.IO_MEDIUM"
		alias
			"standard_copy"
		end

	collecting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"collecting"
		end

	last_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.IO_MEDIUM"
		alias
			"last_double"
		end

	allocate_tiny is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"allocate_tiny"
		end

	free (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.IO_MEDIUM"
		alias
			"free"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"Equals"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"total_memory"
		end

	a_set_last_integer (last_integer2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.IO_MEDIUM"
		alias
			"_set_last_integer"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.IO_MEDIUM"
		alias
			"deep_equal"
		end

	set_coalesce_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.IO_MEDIUM"
		alias
			"set_coalesce_period"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.IO_MEDIUM"
		alias
			"c_memory"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.IO_MEDIUM"
		alias
			"standard_clone"
		end

	dispose is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"dispose"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.IO_MEDIUM"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.IO_MEDIUM"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.IO_MEDIUM"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.IO_MEDIUM"
		alias
			"internal_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.IO_MEDIUM"
		alias
			"ToString"
		end

	lastdouble: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.IO_MEDIUM"
		alias
			"lastdouble"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.IO_MEDIUM"
		alias
			"deep_copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.IO_MEDIUM"
		alias
			"generating_type"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.IO_MEDIUM"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_IO_MEDIUM

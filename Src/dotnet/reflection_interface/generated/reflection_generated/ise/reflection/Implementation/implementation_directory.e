indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DIRECTORY"

external class
	IMPLEMENTATION_DIRECTORY

inherit
	MEM_CONST
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	DIRECTORY
	MEMORY

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.DIRECTORY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_search_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.DIRECTORY"
		alias
			"$$search_index"
		end

	frozen ec_illegal_36_ec_illegal_36_name: STRING is
		external
			"IL field signature :STRING use Implementation.DIRECTORY"
		alias
			"$$name"
		end

	frozen ec_illegal_36_ec_illegal_36_mode: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.DIRECTORY"
		alias
			"$$mode"
		end

	frozen ec_illegal_36_ec_illegal_36_lastentry: STRING is
		external
			"IL field signature :STRING use Implementation.DIRECTORY"
		alias
			"$$lastentry"
		end

feature -- Basic Operations

	is_in_final_collect: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"is_in_final_collect"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DIRECTORY"
		alias
			"____class_name"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DIRECTORY"
		alias
			"tagged_out"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"default_create"
		end

	full_coalesce is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"full_coalesce"
		end

	set_collection_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"set_collection_period"
		end

	create_dir is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"create_dir"
		end

	collect is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"collect"
		end

	change_name (new_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.DIRECTORY"
		alias
			"change_name"
		end

	generation_object_limit: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"generation_object_limit"
		end

	has_entry (entry_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.DIRECTORY"
		alias
			"has_entry"
		end

	recursive_delete_with_action (action: PROCEDURE_ANY_ANY; is_cancel_requested: FUNCTION_ANY_ANY_BOOLEAN; file_number: INTEGER) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN, System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"recursive_delete_with_action"
		end

	lastentry: STRING is
		external
			"IL signature (): STRING use Implementation.DIRECTORY"
		alias
			"lastentry"
		end

	allocate_tiny is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"allocate_tiny"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: DIRECTORY): ARRAYED_LIST_ANY is
		external
			"IL static signature (DIRECTORY): ARRAYED_LIST_ANY use Implementation.DIRECTORY"
		alias
			"$$linear_representation"
		end

	frozen ec_illegal_36_ec_illegal_36_change_name (current_: DIRECTORY; new_name: STRING) is
		external
			"IL static signature (DIRECTORY, STRING): System.Void use Implementation.DIRECTORY"
		alias
			"$$change_name"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DIRECTORY"
		alias
			"operating_environment"
		end

	name: STRING is
		external
			"IL signature (): STRING use Implementation.DIRECTORY"
		alias
			"name"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DIRECTORY"
		alias
			"copy"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"incremental_collector"
		end

	readentry is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"readentry"
		end

	memory_statistics (memory_type: INTEGER): MEM_INFO is
		external
			"IL signature (System.Int32): MEM_INFO use Implementation.DIRECTORY"
		alias
			"memory_statistics"
		end

	frozen ec_illegal_36_ec_illegal_36_is_writable (current_: DIRECTORY): BOOLEAN is
		external
			"IL static signature (DIRECTORY): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$is_writable"
		end

	make (dn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.DIRECTORY"
		alias
			"make"
		end

	is_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"is_writable"
		end

	frozen ec_illegal_36_ec_illegal_36_exists (current_: DIRECTORY): BOOLEAN is
		external
			"IL static signature (DIRECTORY): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$exists"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DIRECTORY"
		alias
			"out"
		end

	enable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"enable_time_accounting"
		end

	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"find_referers"
		end

	frozen ec_illegal_36_ec_illegal_36_delete_content_with_action (current_: DIRECTORY; action: PROCEDURE_ANY_ANY; is_cancel_requested: FUNCTION_ANY_ANY_BOOLEAN; file_number: INTEGER) is
		external
			"IL static signature (DIRECTORY, PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN, System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"$$delete_content_with_action"
		end

	delete_content_with_action (action: PROCEDURE_ANY_ANY; is_cancel_requested: FUNCTION_ANY_ANY_BOOLEAN; file_number: INTEGER) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN, System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"delete_content_with_action"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DIRECTORY"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: DIRECTORY; dn: STRING) is
		external
			"IL static signature (DIRECTORY, STRING): System.Void use Implementation.DIRECTORY"
		alias
			"$$make"
		end

	full_collect is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"full_collect"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"eiffel_memory"
		end

	is_closed: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"is_closed"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DIRECTORY"
		alias
			"conforms_to"
		end

	close is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"close"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DIRECTORY"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_close (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$close"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"empty"
		end

	a_set_name (name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.DIRECTORY"
		alias
			"_set_name"
		end

	chunk_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"chunk_size"
		end

	search_index: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"search_index"
		end

	frozen ec_illegal_36_ec_illegal_36_create_dir (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$create_dir"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DIRECTORY"
		alias
			"default"
		end

	collection_off is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"collection_off"
		end

	is_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"is_readable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DIRECTORY"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"do_nothing"
		end

	delete is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"delete"
		end

	frozen ec_illegal_36_ec_illegal_36_is_executable (current_: DIRECTORY): BOOLEAN is
		external
			"IL static signature (DIRECTORY): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$is_executable"
		end

	gc_monitoring (flag: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.DIRECTORY"
		alias
			"gc_monitoring"
		end

	frozen ec_illegal_36_ec_illegal_36_is_readable (current_: DIRECTORY): BOOLEAN is
		external
			"IL static signature (DIRECTORY): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$is_readable"
		end

	set_max_mem (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"set_max_mem"
		end

	open_read is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"open_read"
		end

	largest_coalesced_block: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"largest_coalesced_block"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: DIRECTORY): INTEGER is
		external
			"IL static signature (DIRECTORY): System.Int32 use Implementation.DIRECTORY"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_recursive_delete_with_action (current_: DIRECTORY; action: PROCEDURE_ANY_ANY; is_cancel_requested: FUNCTION_ANY_ANY_BOOLEAN; file_number: INTEGER) is
		external
			"IL static signature (DIRECTORY, PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN, System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"$$recursive_delete_with_action"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"full_collector"
		end

	allocate_compact is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"allocate_compact"
		end

	tenure: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"tenure"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_read (current_: DIRECTORY; dn: STRING) is
		external
			"IL static signature (DIRECTORY, STRING): System.Void use Implementation.DIRECTORY"
		alias
			"$$make_open_read"
		end

	disable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"disable_time_accounting"
		end

	close_directory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"close_directory"
		end

	a_set_search_index (search_index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"_set_search_index"
		end

	frozen ec_illegal_36_ec_illegal_36_is_closed (current_: DIRECTORY): BOOLEAN is
		external
			"IL static signature (DIRECTORY): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$is_closed"
		end

	collection_on is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"collection_on"
		end

	max_mem: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"max_mem"
		end

	scavenge_zone_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"scavenge_zone_size"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DIRECTORY"
		alias
			"standard_is_equal"
		end

	gc_statistics (collector_type: INTEGER): GC_INFO is
		external
			"IL signature (System.Int32): GC_INFO use Implementation.DIRECTORY"
		alias
			"gc_statistics"
		end

	frozen ec_illegal_36_ec_illegal_36_delete (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$delete"
		end

	frozen ec_illegal_36_ec_illegal_36_readentry (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$readentry"
		end

	memory_threshold: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"memory_threshold"
		end

	allocate_fast is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"allocate_fast"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DIRECTORY"
		alias
			"default_pointer"
		end

	recursive_delete is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"recursive_delete"
		end

	frozen ec_illegal_36_ec_illegal_36_dispose (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$dispose"
		end

	frozen ec_illegal_36_ec_illegal_36_read_directory (current_: DIRECTORY): INTEGER is
		external
			"IL static signature (DIRECTORY): System.Int32 use Implementation.DIRECTORY"
		alias
			"$$read_directory"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DIRECTORY"
		alias
			"is_equal"
		end

	coalesce_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"coalesce_period"
		end

	referers (an_object: ANY): ARRAY_ANY is
		external
			"IL signature (ANY): ARRAY_ANY use Implementation.DIRECTORY"
		alias
			"referers"
		end

	collection_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"collection_period"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DIRECTORY"
		alias
			"print"
		end

	set_memory_threshold (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"set_memory_threshold"
		end

	make_open_read (dn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.DIRECTORY"
		alias
			"make_open_read"
		end

	delete_content is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"delete_content"
		end

	a_set_lastentry (lastentry2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.DIRECTORY"
		alias
			"_set_lastentry"
		end

	frozen ec_illegal_36_ec_illegal_36_open_read (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$open_read"
		end

	frozen ec_illegal_36_ec_illegal_36_is_empty (current_: DIRECTORY): BOOLEAN is
		external
			"IL static signature (DIRECTORY): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$is_empty"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DIRECTORY"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DIRECTORY"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DIRECTORY"
		alias
			"standard_equal"
		end

	mem_free (addr: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.DIRECTORY"
		alias
			"mem_free"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DIRECTORY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_close_directory (current_: DIRECTORY): INTEGER is
		external
			"IL static signature (DIRECTORY): System.Int32 use Implementation.DIRECTORY"
		alias
			"$$close_directory"
		end

	collecting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"collecting"
		end

	frozen ec_illegal_36_ec_illegal_36_delete_content (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$delete_content"
		end

	dispose is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"dispose"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$start"
		end

	free (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DIRECTORY"
		alias
			"free"
		end

	is_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"is_executable"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DIRECTORY"
		alias
			"Equals"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"total_memory"
		end

	exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DIRECTORY"
		alias
			"exists"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DIRECTORY"
		alias
			"deep_equal"
		end

	set_coalesce_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"set_coalesce_period"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"c_memory"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DIRECTORY"
		alias
			"standard_clone"
		end

	read_directory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"read_directory"
		end

	frozen ec_illegal_36_ec_illegal_36_empty (current_: DIRECTORY): BOOLEAN is
		external
			"IL static signature (DIRECTORY): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$empty"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DIRECTORY"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DIRECTORY"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DIRECTORY"
		alias
			"deep_clone"
		end

	a_set_mode (mode2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DIRECTORY"
		alias
			"_set_mode"
		end

	mode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"mode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DIRECTORY"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_has_entry (current_: DIRECTORY; entry_name: STRING): BOOLEAN is
		external
			"IL static signature (DIRECTORY, STRING): System.Boolean use Implementation.DIRECTORY"
		alias
			"$$has_entry"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DIRECTORY"
		alias
			"count"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DIRECTORY"
		alias
			"deep_copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DIRECTORY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_recursive_delete (current_: DIRECTORY) is
		external
			"IL static signature (DIRECTORY): System.Void use Implementation.DIRECTORY"
		alias
			"$$recursive_delete"
		end

	linear_representation: ARRAYED_LIST_ANY is
		external
			"IL signature (): ARRAYED_LIST_ANY use Implementation.DIRECTORY"
		alias
			"linear_representation"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"start"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DIRECTORY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DIRECTORY

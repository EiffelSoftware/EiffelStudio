indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.MEMORY"

external class
	IMPLEMENTATION_MEMORY

inherit
	MEM_CONST
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	MEMORY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.MEMORY"
		end

feature -- Basic Operations

	is_in_final_collect: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.MEMORY"
		alias
			"is_in_final_collect"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.MEMORY"
		alias
			"____class_name"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.MEMORY"
		alias
			"tagged_out"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"default_create"
		end

	full_coalesce is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"full_coalesce"
		end

	set_collection_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEMORY"
		alias
			"set_collection_period"
		end

	collect is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"collect"
		end

	generation_object_limit: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"generation_object_limit"
		end

	frozen ec_illegal_36_ec_illegal_36_chunk_size (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$chunk_size"
		end

	allocate_tiny is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"allocate_tiny"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.MEMORY"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_scavenge_zone_size (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$scavenge_zone_size"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEMORY"
		alias
			"copy"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"incremental_collector"
		end

	memory_statistics (memory_type: INTEGER): MEM_INFO is
		external
			"IL signature (System.Int32): MEM_INFO use Implementation.MEMORY"
		alias
			"memory_statistics"
		end

	frozen ec_illegal_36_ec_illegal_36_gc_monitoring (current_: MEMORY; flag: BOOLEAN) is
		external
			"IL static signature (MEMORY, System.Boolean): System.Void use Implementation.MEMORY"
		alias
			"$$gc_monitoring"
		end

	frozen ec_illegal_36_ec_illegal_36_allocate_compact (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$allocate_compact"
		end

	frozen ec_illegal_36_ec_illegal_36_collection_on (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$collection_on"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.MEMORY"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_collection_period (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$collection_period"
		end

	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.MEMORY"
		alias
			"find_referers"
		end

	frozen ec_illegal_36_ec_illegal_36_max_mem (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$max_mem"
		end

	frozen ec_illegal_36_ec_illegal_36_allocate_fast (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$allocate_fast"
		end

	frozen ec_illegal_36_ec_illegal_36_mem_free (current_: MEMORY; addr: POINTER) is
		external
			"IL static signature (MEMORY, System.IntPtr): System.Void use Implementation.MEMORY"
		alias
			"$$mem_free"
		end

	full_collect is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"full_collect"
		end

	frozen ec_illegal_36_ec_illegal_36_set_coalesce_period (current_: MEMORY; value: INTEGER) is
		external
			"IL static signature (MEMORY, System.Int32): System.Void use Implementation.MEMORY"
		alias
			"$$set_coalesce_period"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"eiffel_memory"
		end

	frozen ec_illegal_36_ec_illegal_36_set_collection_period (current_: MEMORY; value: INTEGER) is
		external
			"IL static signature (MEMORY, System.Int32): System.Void use Implementation.MEMORY"
		alias
			"$$set_collection_period"
		end

	frozen ec_illegal_36_ec_illegal_36_collection_off (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$collection_off"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEMORY"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_is_in_final_collect (current_: MEMORY): BOOLEAN is
		external
			"IL static signature (MEMORY): System.Boolean use Implementation.MEMORY"
		alias
			"$$is_in_final_collect"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.MEMORY"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"GetHashCode"
		end

	chunk_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"chunk_size"
		end

	frozen ec_illegal_36_ec_illegal_36_disable_time_accounting (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$disable_time_accounting"
		end

	frozen ec_illegal_36_ec_illegal_36_largest_coalesced_block (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$largest_coalesced_block"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.MEMORY"
		alias
			"default"
		end

	collection_off is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"collection_off"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEMORY"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_enable_time_accounting (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$enable_time_accounting"
		end

	frozen ec_illegal_36_ec_illegal_36_free (current_: MEMORY; object: ANY) is
		external
			"IL static signature (MEMORY, ANY): System.Void use Implementation.MEMORY"
		alias
			"$$free"
		end

	gc_monitoring (flag: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.MEMORY"
		alias
			"gc_monitoring"
		end

	set_max_mem (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEMORY"
		alias
			"set_max_mem"
		end

	largest_coalesced_block: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"largest_coalesced_block"
		end

	frozen ec_illegal_36_ec_illegal_36_collecting (current_: MEMORY): BOOLEAN is
		external
			"IL static signature (MEMORY): System.Boolean use Implementation.MEMORY"
		alias
			"$$collecting"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"full_collector"
		end

	allocate_compact is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"allocate_compact"
		end

	tenure: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"tenure"
		end

	disable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"disable_time_accounting"
		end

	frozen ec_illegal_36_ec_illegal_36_set_max_mem (current_: MEMORY; value: INTEGER) is
		external
			"IL static signature (MEMORY, System.Int32): System.Void use Implementation.MEMORY"
		alias
			"$$set_max_mem"
		end

	frozen ec_illegal_36_ec_illegal_36_memory_statistics (current_: MEMORY; memory_type: INTEGER): MEM_INFO is
		external
			"IL static signature (MEMORY, System.Int32): MEM_INFO use Implementation.MEMORY"
		alias
			"$$memory_statistics"
		end

	collection_on is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"collection_on"
		end

	max_mem: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"max_mem"
		end

	scavenge_zone_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"scavenge_zone_size"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEMORY"
		alias
			"standard_is_equal"
		end

	gc_statistics (collector_type: INTEGER): GC_INFO is
		external
			"IL signature (System.Int32): GC_INFO use Implementation.MEMORY"
		alias
			"gc_statistics"
		end

	memory_threshold: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"memory_threshold"
		end

	allocate_fast is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"allocate_fast"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.MEMORY"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_dispose (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$dispose"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEMORY"
		alias
			"is_equal"
		end

	coalesce_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"coalesce_period"
		end

	referers (an_object: ANY): ARRAY_ANY is
		external
			"IL signature (ANY): ARRAY_ANY use Implementation.MEMORY"
		alias
			"referers"
		end

	frozen ec_illegal_36_ec_illegal_36_tenure (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$tenure"
		end

	collection_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"collection_period"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEMORY"
		alias
			"print"
		end

	set_memory_threshold (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEMORY"
		alias
			"set_memory_threshold"
		end

	frozen ec_illegal_36_ec_illegal_36_full_coalesce (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$full_coalesce"
		end

	frozen ec_illegal_36_ec_illegal_36_allocate_tiny (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$allocate_tiny"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEMORY"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_generation_object_limit (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$generation_object_limit"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEMORY"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEMORY"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_find_referers (current_: MEMORY; target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"IL static signature (MEMORY, System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.MEMORY"
		alias
			"$$find_referers"
		end

	mem_free (addr: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.MEMORY"
		alias
			"mem_free"
		end

	frozen ec_illegal_36_ec_illegal_36_gc_statistics (current_: MEMORY; collector_type: INTEGER): GC_INFO is
		external
			"IL static signature (MEMORY, System.Int32): GC_INFO use Implementation.MEMORY"
		alias
			"$$gc_statistics"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEMORY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_collect (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$collect"
		end

	collecting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.MEMORY"
		alias
			"collecting"
		end

	dispose is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"dispose"
		end

	free (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEMORY"
		alias
			"free"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.MEMORY"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_set_memory_threshold (current_: MEMORY; value: INTEGER) is
		external
			"IL static signature (MEMORY, System.Int32): System.Void use Implementation.MEMORY"
		alias
			"$$set_memory_threshold"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"total_memory"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEMORY"
		alias
			"deep_equal"
		end

	set_coalesce_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEMORY"
		alias
			"set_coalesce_period"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEMORY"
		alias
			"c_memory"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEMORY"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_coalesce_period (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$coalesce_period"
		end

	frozen ec_illegal_36_ec_illegal_36_full_collect (current_: MEMORY) is
		external
			"IL static signature (MEMORY): System.Void use Implementation.MEMORY"
		alias
			"$$full_collect"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.MEMORY"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.MEMORY"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEMORY"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_referers (current_: MEMORY; an_object: ANY): ARRAY_ANY is
		external
			"IL static signature (MEMORY, ANY): ARRAY_ANY use Implementation.MEMORY"
		alias
			"$$referers"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEMORY"
		alias
			"internal_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.MEMORY"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_memory_threshold (current_: MEMORY): INTEGER is
		external
			"IL static signature (MEMORY): System.Int32 use Implementation.MEMORY"
		alias
			"$$memory_threshold"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEMORY"
		alias
			"deep_copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.MEMORY"
		alias
			"generating_type"
		end

	enable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"enable_time_accounting"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.MEMORY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_MEMORY

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.GC_INFO"

external class
	IMPLEMENTATION_GC_INFO

inherit
	GC_INFO
	MEM_CONST
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.GC_INFO"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_real_interval_time_average: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$real_interval_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_sys_interval_time: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$sys_interval_time"
		end

	frozen ec_illegal_36_ec_illegal_36_type: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$type"
		end

	frozen ec_illegal_36_ec_illegal_36_collected_average: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$collected_average"
		end

	frozen ec_illegal_36_ec_illegal_36_cpu_time: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$cpu_time"
		end

	frozen ec_illegal_36_ec_illegal_36_sys_time_average: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$sys_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_sys_time: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$sys_time"
		end

	frozen ec_illegal_36_ec_illegal_36_sys_interval_time_average: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$sys_interval_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_memory_used: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$memory_used"
		end

	frozen ec_illegal_36_ec_illegal_36_cpu_interval_time_average: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$cpu_interval_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_cpu_time_average: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$cpu_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_real_interval_time: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$real_interval_time"
		end

	frozen ec_illegal_36_ec_illegal_36_real_time: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$real_time"
		end

	frozen ec_illegal_36_ec_illegal_36_cycle_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$cycle_count"
		end

	frozen ec_illegal_36_ec_illegal_36_real_time_average: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$real_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_cpu_interval_time: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.GC_INFO"
		alias
			"$$cpu_interval_time"
		end

	frozen ec_illegal_36_ec_illegal_36_collected: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.GC_INFO"
		alias
			"$$collected"
		end

feature -- Basic Operations

	a_set_sys_interval_time_average (sys_interval_time_average2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_sys_interval_time_average"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.GC_INFO"
		alias
			"operating_environment"
		end

	collected_average: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"collected_average"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GC_INFO"
		alias
			"____class_name"
		end

	cpu_time: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"cpu_time"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: GC_INFO; memory: INTEGER) is
		external
			"IL static signature (GC_INFO, System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"$$make"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.GC_INFO"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_gc_stat (current_: GC_INFO; mem: INTEGER) is
		external
			"IL static signature (GC_INFO, System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"$$gc_stat"
		end

	a_set_real_interval_time (real_interval_time2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_real_interval_time"
		end

	a_set_cpu_time (cpu_time2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_cpu_time"
		end

	a_set_collected (collected2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_collected"
		end

	a_set_sys_time_average (sys_time_average2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_sys_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_gc_infod (current_: GC_INFO; field: INTEGER): DOUBLE is
		external
			"IL static signature (GC_INFO, System.Int32): System.Double use Implementation.GC_INFO"
		alias
			"$$gc_infod"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GC_INFO"
		alias
			"copy"
		end

	update (memory: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"update"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"incremental_collector"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.GC_INFO"
		alias
			"generating_type"
		end

	make (memory: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"make"
		end

	a_set_real_time (real_time2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_real_time"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.GC_INFO"
		alias
			"out"
		end

	cpu_time_average: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"cpu_time_average"
		end

	cpu_interval_time_average: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"cpu_interval_time_average"
		end

	type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"type"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GC_INFO"
		alias
			"internal_copy"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.GC_INFO"
		alias
			"default_rescue"
		end

	a_set_cpu_time_average (cpu_time_average2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_cpu_time_average"
		end

	sys_time: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"sys_time"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"eiffel_memory"
		end

	frozen ec_illegal_36_ec_illegal_36_update (current_: GC_INFO; memory: INTEGER) is
		external
			"IL static signature (GC_INFO, System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"$$update"
		end

	real_time: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"real_time"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GC_INFO"
		alias
			"conforms_to"
		end

	a_set_real_time_average (real_time_average2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_real_time_average"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.GC_INFO"
		alias
			"io"
		end

	a_set_memory_used (memory_used2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_memory_used"
		end

	sys_time_average: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"sys_time_average"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.GC_INFO"
		alias
			"tagged_out"
		end

	a_set_real_interval_time_average (real_interval_time_average2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_real_interval_time_average"
		end

	memory_used: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"memory_used"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.GC_INFO"
		alias
			"default"
		end

	a_set_sys_interval_time (sys_interval_time2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_sys_interval_time"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GC_INFO"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.GC_INFO"
		alias
			"do_nothing"
		end

	cycle_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"cycle_count"
		end

	cpu_interval_time: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"cpu_interval_time"
		end

	a_set_cpu_interval_time_average (cpu_interval_time_average2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_cpu_interval_time_average"
		end

	sys_interval_time_average: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"sys_interval_time_average"
		end

	frozen ec_illegal_36_ec_illegal_36_gc_info (current_: GC_INFO; field: INTEGER): INTEGER is
		external
			"IL static signature (GC_INFO, System.Int32): System.Int32 use Implementation.GC_INFO"
		alias
			"$$gc_info"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"full_collector"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GC_INFO"
		alias
			"standard_is_equal"
		end

	a_set_cpu_interval_time (cpu_interval_time2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_cpu_interval_time"
		end

	gc_infod (field: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.GC_INFO"
		alias
			"gc_infod"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.GC_INFO"
		alias
			"default_pointer"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GC_INFO"
		alias
			"is_equal"
		end

	gc_stat (mem: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"gc_stat"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GC_INFO"
		alias
			"print"
		end

	real_interval_time: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"real_interval_time"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GC_INFO"
		alias
			"equal"
		end

	a_set_type (type2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_type"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GC_INFO"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GC_INFO"
		alias
			"standard_equal"
		end

	a_set_cycle_count (cycle_count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_cycle_count"
		end

	a_set_collected_average (collected_average2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GC_INFO"
		alias
			"_set_collected_average"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GC_INFO"
		alias
			"standard_copy"
		end

	collected: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"collected"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"GetHashCode"
		end

	gc_info (field: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.GC_INFO"
		alias
			"gc_info"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.GC_INFO"
		alias
			"Equals"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"total_memory"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GC_INFO"
		alias
			"deep_equal"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"c_memory"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GC_INFO"
		alias
			"standard_clone"
		end

	sys_interval_time: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.GC_INFO"
		alias
			"sys_interval_time"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.GC_INFO"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.GC_INFO"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GC_INFO"
		alias
			"deep_clone"
		end

	real_time_average: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"real_time_average"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GC_INFO"
		alias
			"ToString"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GC_INFO"
		alias
			"deep_copy"
		end

	a_set_sys_time (sys_time2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.GC_INFO"
		alias
			"_set_sys_time"
		end

	real_interval_time_average: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GC_INFO"
		alias
			"real_interval_time_average"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.GC_INFO"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_GC_INFO

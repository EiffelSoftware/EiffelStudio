indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.MEM_INFO"

external class
	IMPLEMENTATION_MEM_INFO

inherit
	MEM_INFO
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
			"IL creator use Implementation.MEM_INFO"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_type: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.MEM_INFO"
		alias
			"$$type"
		end

	frozen ec_illegal_36_ec_illegal_36_used: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.MEM_INFO"
		alias
			"$$used"
		end

	frozen ec_illegal_36_ec_illegal_36_overhead: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.MEM_INFO"
		alias
			"$$overhead"
		end

	frozen ec_illegal_36_ec_illegal_36_total: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.MEM_INFO"
		alias
			"$$total"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEM_INFO"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_INFO"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.MEM_INFO"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.MEM_INFO"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_INFO"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_INFO"
		alias
			"is_equal"
		end

	a_set_overhead (overhead2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"_set_overhead"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEM_INFO"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_INFO"
		alias
			"same_type"
		end

	a_set_type (type2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"_set_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_INFO"
		alias
			"generator"
		end

	total: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"total"
		end

	type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"type"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_INFO"
		alias
			"internal_copy"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"full_collector"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEM_INFO"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEM_INFO"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_update (current_: MEM_INFO; memory: INTEGER) is
		external
			"IL static signature (MEM_INFO, System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"$$update"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.MEM_INFO"
		alias
			"____class_name"
		end

	mem_info (field: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.MEM_INFO"
		alias
			"mem_info"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.MEM_INFO"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_INFO"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.MEM_INFO"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.MEM_INFO"
		alias
			"default_pointer"
		end

	a_set_used (used2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"_set_used"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_INFO"
		alias
			"standard_copy"
		end

	free: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"free"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.MEM_INFO"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.MEM_INFO"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEM_INFO"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.MEM_INFO"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_INFO"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_mem_stat (current_: MEM_INFO; mem: INTEGER) is
		external
			"IL static signature (MEM_INFO, System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"$$mem_stat"
		end

	frozen ec_illegal_36_ec_illegal_36_free (current_: MEM_INFO): INTEGER is
		external
			"IL static signature (MEM_INFO): System.Int32 use Implementation.MEM_INFO"
		alias
			"$$free"
		end

	overhead: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"overhead"
		end

	a_set_total (total2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"_set_total"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"c_memory"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: MEM_INFO; memory: INTEGER) is
		external
			"IL static signature (MEM_INFO, System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"$$make"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"total_memory"
		end

	update (memory: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"update"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.MEM_INFO"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.MEM_INFO"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEM_INFO"
		alias
			"clone"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"incremental_collector"
		end

	used: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"used"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_INFO"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_INFO"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_INFO"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_mem_info (current_: MEM_INFO; field: INTEGER): INTEGER is
		external
			"IL static signature (MEM_INFO, System.Int32): System.Int32 use Implementation.MEM_INFO"
		alias
			"$$mem_info"
		end

	mem_stat (mem: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"mem_stat"
		end

	make (memory: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.MEM_INFO"
		alias
			"make"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_INFO"
		alias
			"eiffel_memory"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_INFO"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.MEM_INFO"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_MEM_INFO

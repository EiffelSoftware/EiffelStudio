indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.MEM_CONST"

external class
	IMPLEMENTATION_MEM_CONST

inherit
	MEM_CONST
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.MEM_CONST"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_CONST"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEM_CONST"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_memory (current_: MEM_CONST): INTEGER is
		external
			"IL static signature (MEM_CONST): System.Int32 use Implementation.MEM_CONST"
		alias
			"$$eiffel_memory"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_CONST"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.MEM_CONST"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.MEM_CONST"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_CONST"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_CONST"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEM_CONST"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_CONST"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_CONST"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_CONST"
		alias
			"internal_copy"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_CONST"
		alias
			"full_collector"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEM_CONST"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_full_collector (current_: MEM_CONST): INTEGER is
		external
			"IL static signature (MEM_CONST): System.Int32 use Implementation.MEM_CONST"
		alias
			"$$full_collector"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEM_CONST"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.MEM_CONST"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.MEM_CONST"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_CONST"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.MEM_CONST"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.MEM_CONST"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_CONST"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.MEM_CONST"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.MEM_CONST"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.MEM_CONST"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.MEM_CONST"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_total_memory (current_: MEM_CONST): INTEGER is
		external
			"IL static signature (MEM_CONST): System.Int32 use Implementation.MEM_CONST"
		alias
			"$$total_memory"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.MEM_CONST"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_c_memory (current_: MEM_CONST): INTEGER is
		external
			"IL static signature (MEM_CONST): System.Int32 use Implementation.MEM_CONST"
		alias
			"$$c_memory"
		end

	frozen ec_illegal_36_ec_illegal_36_incremental_collector (current_: MEM_CONST): INTEGER is
		external
			"IL static signature (MEM_CONST): System.Int32 use Implementation.MEM_CONST"
		alias
			"$$incremental_collector"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_CONST"
		alias
			"c_memory"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_CONST"
		alias
			"total_memory"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.MEM_CONST"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.MEM_CONST"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.MEM_CONST"
		alias
			"clone"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_CONST"
		alias
			"incremental_collector"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_CONST"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_CONST"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.MEM_CONST"
		alias
			"conforms_to"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.MEM_CONST"
		alias
			"eiffel_memory"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.MEM_CONST"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.MEM_CONST"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_MEM_CONST

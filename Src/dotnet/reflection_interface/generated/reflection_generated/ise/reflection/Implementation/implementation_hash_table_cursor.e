indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.HASH_TABLE_CURSOR"

external class
	IMPLEMENTATION_HASH_TABLE_CURSOR

inherit
	HASH_TABLE_CURSOR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CURSOR

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.HASH_TABLE_CURSOR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_position: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_CURSOR"
		alias
			"$$position"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_CURSOR"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_CURSOR"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_CURSOR"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_CURSOR"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.HASH_TABLE_CURSOR"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"is_equal"
		end

	position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_CURSOR"
		alias
			"position"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_CURSOR"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"internal_copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"Equals"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_CURSOR"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HASH_TABLE_CURSOR"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_CURSOR"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.HASH_TABLE_CURSOR"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HASH_TABLE_CURSOR"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_CURSOR"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"deep_equal"
		end

	a_set_position (position2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"_set_position"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_CURSOR"
		alias
			"generating_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.HASH_TABLE_CURSOR"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_CURSOR"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_CURSOR"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: HASH_TABLE_CURSOR; pos: INTEGER) is
		external
			"IL static signature (HASH_TABLE_CURSOR, System.Int32): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"$$make"
		end

	make (pos: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_CURSOR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_HASH_TABLE_CURSOR

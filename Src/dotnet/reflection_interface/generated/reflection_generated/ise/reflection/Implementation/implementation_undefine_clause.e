indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.UNDEFINE_CLAUSE"

external class
	IMPLEMENTATION_UNDEFINE_CLAUSE

inherit
	UNDEFINE_CLAUSE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	INHERITANCE_CLAUSE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.UNDEFINE_CLAUSE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_source_name: STRING is
		external
			"IL field signature :STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"$$source_name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNDEFINE_CLAUSE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNDEFINE_CLAUSE"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_keyword (current_: UNDEFINE_CLAUSE): STRING is
		external
			"IL static signature (UNDEFINE_CLAUSE): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"$$eiffel_keyword"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.UNDEFINE_CLAUSE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.UNDEFINE_CLAUSE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNDEFINE_CLAUSE"
		alias
			"standard_clone"
		end

	source_name: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"source_name"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"equal"
		end

	set_source_name (a_source_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"set_source_name"
		end

	a_set_source_name (source_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"_set_source_name"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.UNDEFINE_CLAUSE"
		alias
			"____class_name"
		end

	string_representation: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"string_representation"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.UNDEFINE_CLAUSE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.UNDEFINE_CLAUSE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.UNDEFINE_CLAUSE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_string_representation (current_: UNDEFINE_CLAUSE): STRING is
		external
			"IL static signature (UNDEFINE_CLAUSE): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"$$string_representation"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"Equals"
		end

	undefine_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"undefine_keyword"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_undefine_keyword (current_: UNDEFINE_CLAUSE): STRING is
		external
			"IL static signature (UNDEFINE_CLAUSE): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"$$undefine_keyword"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.UNDEFINE_CLAUSE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNDEFINE_CLAUSE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNDEFINE_CLAUSE"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"print"
		end

	eiffel_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.UNDEFINE_CLAUSE"
		alias
			"eiffel_keyword"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.UNDEFINE_CLAUSE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_UNDEFINE_CLAUSE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.RENAME_CLAUSE"

external class
	IMPLEMENTATION_RENAME_CLAUSE

inherit
	RENAME_CLAUSE
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
			"IL creator use Implementation.RENAME_CLAUSE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_source_name: STRING is
		external
			"IL field signature :STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$source_name"
		end

	frozen ec_illegal_36_ec_illegal_36_target_name: STRING is
		external
			"IL field signature :STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$target_name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RENAME_CLAUSE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RENAME_CLAUSE"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_space (current_: RENAME_CLAUSE): STRING is
		external
			"IL static signature (RENAME_CLAUSE): STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$space"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.RENAME_CLAUSE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.RENAME_CLAUSE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"internal_copy"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"space"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RENAME_CLAUSE"
		alias
			"standard_clone"
		end

	source_name: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"source_name"
		end

	frozen ec_illegal_36_ec_illegal_36_rename_keyword (current_: RENAME_CLAUSE): STRING is
		external
			"IL static signature (RENAME_CLAUSE): STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$rename_keyword"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"equal"
		end

	set_source_name (a_source_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"set_source_name"
		end

	frozen ec_illegal_36_ec_illegal_36_set_target_name (current_: RENAME_CLAUSE; a_target_name: STRING) is
		external
			"IL static signature (RENAME_CLAUSE, STRING): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"$$set_target_name"
		end

	set_target_name (a_target_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"set_target_name"
		end

	a_set_source_name (source_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"_set_source_name"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.RENAME_CLAUSE"
		alias
			"____class_name"
		end

	string_representation: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"string_representation"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.RENAME_CLAUSE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.RENAME_CLAUSE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.RENAME_CLAUSE"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_empty_string (current_: RENAME_CLAUSE): STRING is
		external
			"IL static signature (RENAME_CLAUSE): STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$empty_string"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_string_representation (current_: RENAME_CLAUSE): STRING is
		external
			"IL static signature (RENAME_CLAUSE): STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$string_representation"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"Equals"
		end

	as_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"as_keyword"
		end

	target_name: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"target_name"
		end

	rename_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"rename_keyword"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: RENAME_CLAUSE; obj: RENAME_CLAUSE): BOOLEAN is
		external
			"IL static signature (RENAME_CLAUSE, RENAME_CLAUSE): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"$$is_equal"
		end

	a_set_target_name (target_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"_set_target_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.RENAME_CLAUSE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RENAME_CLAUSE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RENAME_CLAUSE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_as_keyword (current_: RENAME_CLAUSE): STRING is
		external
			"IL static signature (RENAME_CLAUSE): STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$as_keyword"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_keyword (current_: RENAME_CLAUSE): STRING is
		external
			"IL static signature (RENAME_CLAUSE): STRING use Implementation.RENAME_CLAUSE"
		alias
			"$$eiffel_keyword"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"empty_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"print"
		end

	eiffel_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.RENAME_CLAUSE"
		alias
			"eiffel_keyword"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.RENAME_CLAUSE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_RENAME_CLAUSE

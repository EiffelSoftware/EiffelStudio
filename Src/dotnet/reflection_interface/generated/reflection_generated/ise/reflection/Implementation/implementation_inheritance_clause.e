indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.INHERITANCE_CLAUSE"

deferred external class
	IMPLEMENTATION_INHERITANCE_CLAUSE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	INHERITANCE_CLAUSE

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_source_name: STRING is
		external
			"IL field signature :STRING use Implementation.INHERITANCE_CLAUSE"
		alias
			"$$source_name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INHERITANCE_CLAUSE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INHERITANCE_CLAUSE"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.INHERITANCE_CLAUSE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.INHERITANCE_CLAUSE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.INHERITANCE_CLAUSE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.INHERITANCE_CLAUSE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INHERITANCE_CLAUSE"
		alias
			"standard_clone"
		end

	source_name: STRING is
		external
			"IL signature (): STRING use Implementation.INHERITANCE_CLAUSE"
		alias
			"source_name"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"equal"
		end

	set_source_name (a_source_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"set_source_name"
		end

	a_set_source_name (source_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"_set_source_name"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INHERITANCE_CLAUSE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.INHERITANCE_CLAUSE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.INHERITANCE_CLAUSE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INHERITANCE_CLAUSE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.INHERITANCE_CLAUSE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.INHERITANCE_CLAUSE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: INHERITANCE_CLAUSE; other: INHERITANCE_CLAUSE): BOOLEAN is
		external
			"IL static signature (INHERITANCE_CLAUSE, INHERITANCE_CLAUSE): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_set_source_name (current_: INHERITANCE_CLAUSE; a_source_name: STRING) is
		external
			"IL static signature (INHERITANCE_CLAUSE, STRING): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"$$set_source_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.INHERITANCE_CLAUSE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INHERITANCE_CLAUSE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INHERITANCE_CLAUSE"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.INHERITANCE_CLAUSE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_INHERITANCE_CLAUSE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DICTIONARY"

external class
	IMPLEMENTATION_DICTIONARY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	DICTIONARY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.DICTIONARY"
		end

feature -- Basic Operations

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"comma"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DICTIONARY"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DICTIONARY"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_space (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$space"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DICTIONARY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DICTIONARY"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DICTIONARY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DICTIONARY"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_dtd_type_filename (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$dtd_type_filename"
		end

	xml_extension: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"xml_extension"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DICTIONARY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DICTIONARY"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DICTIONARY"
		alias
			"internal_copy"
		end

	dash: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"dash"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"space"
		end

	frozen ec_illegal_36_ec_illegal_36_dot_string (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$dot_string"
		end

	dtd_assembly_filename: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"dtd_assembly_filename"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DICTIONARY"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_empty_string (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$empty_string"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DICTIONARY"
		alias
			"equal"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"false_string"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DICTIONARY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DICTIONARY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DICTIONARY"
		alias
			"default_rescue"
		end

	frozen ec_illegal_36_ec_illegal_36_dtd_assembly_filename (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$dtd_assembly_filename"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DICTIONARY"
		alias
			"default_pointer"
		end

	dtd_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"dtd_type_filename"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DICTIONARY"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DICTIONARY"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_index_filename (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$index_filename"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_extension (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$xml_extension"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DICTIONARY"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DICTIONARY"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_true_string (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$true_string"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DICTIONARY"
		alias
			"Equals"
		end

	dtd_extension: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"dtd_extension"
		end

	dot_string: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"dot_string"
		end

	frozen ec_illegal_36_ec_illegal_36_false_string (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$false_string"
		end

	frozen ec_illegal_36_ec_illegal_36_dash (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$dash"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_dtd_extension (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$dtd_extension"
		end

	frozen ec_illegal_36_ec_illegal_36_comma (current_: DICTIONARY): STRING is
		external
			"IL static signature (DICTIONARY): STRING use Implementation.DICTIONARY"
		alias
			"$$comma"
		end

	index_filename: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"index_filename"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DICTIONARY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DICTIONARY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DICTIONARY"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DICTIONARY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DICTIONARY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DICTIONARY"
		alias
			"conforms_to"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"true_string"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.DICTIONARY"
		alias
			"empty_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DICTIONARY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DICTIONARY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DICTIONARY

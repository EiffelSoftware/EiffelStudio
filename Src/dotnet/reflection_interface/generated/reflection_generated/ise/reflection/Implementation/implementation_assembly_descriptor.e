indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ASSEMBLY_DESCRIPTOR"

external class
	IMPLEMENTATION_ASSEMBLY_DESCRIPTOR

inherit
	HASHABLE
		rename
			hash_code as get_hash_code_int32
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ASSEMBLY_DESCRIPTOR
		rename
			hash_code as get_hash_code_int32
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.ASSEMBLY_DESCRIPTOR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_culture: STRING is
		external
			"IL field signature :STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$culture"
		end

	frozen ec_illegal_36_ec_illegal_36_name: STRING is
		external
			"IL field signature :STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$name"
		end

	frozen ec_illegal_36_ec_illegal_36_version: STRING is
		external
			"IL field signature :STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$version"
		end

	frozen ec_illegal_36_ec_illegal_36_public_key: STRING is
		external
			"IL field signature :STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$public_key"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_get_hash_code (current_: ASSEMBLY_DESCRIPTOR): INTEGER is
		external
			"IL static signature (ASSEMBLY_DESCRIPTOR): System.Int32 use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$get_hash_code"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"tagged_out"
		end

	make_from_assembly (a_dot_net_assembly: ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"make_from_assembly"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"is_equal"
		end

	name: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"name"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"internal_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"copy"
		end

	a_set_public_key (public_key2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"_set_public_key"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"is_hashable"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_assembly (current_: ASSEMBLY_DESCRIPTOR; a_dot_net_assembly: ASSEMBLY) is
		external
			"IL static signature (ASSEMBLY_DESCRIPTOR, System.Reflection.Assembly): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$make_from_assembly"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"equal"
		end

	culture: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"culture"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"ToString"
		end

	version: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"version"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"Equals"
		end

	make_empty is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"make_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_make_empty (current_: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$make_empty"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ASSEMBLY_DESCRIPTOR; a_name: STRING; a_version: STRING; a_culture: STRING; a_public_key: STRING) is
		external
			"IL static signature (ASSEMBLY_DESCRIPTOR, STRING, STRING, STRING, STRING): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"$$make"
		end

	a_set_name (name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"_set_name"
		end

	a_set_version (version2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"_set_version"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"io"
		end

	a_set_culture (culture2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"_set_culture"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"deep_copy"
		end

	public_key: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"public_key"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"conforms_to"
		end

	get_hash_code_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"get_hash_code"
		end

	make (a_name: STRING; a_version: STRING; a_culture: STRING; a_public_key: STRING) is
		external
			"IL signature (STRING, STRING, STRING, STRING): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_DESCRIPTOR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ASSEMBLY_DESCRIPTOR

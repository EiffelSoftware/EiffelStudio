indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ASSEMBLY_NAME_DECODER"

external class
	IMPLEMENTATION_ASSEMBLY_NAME_DECODER

inherit
	ASSEMBLY_NAME_DECODER
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
			"IL creator use Implementation.ASSEMBLY_NAME_DECODER"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_neutral_culture (current_: ASSEMBLY_NAME_DECODER): STRING is
		external
			"IL static signature (ASSEMBLY_NAME_DECODER): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"$$neutral_culture"
		end

	frozen ec_illegal_36_ec_illegal_36_empty_string (current_: ASSEMBLY_NAME_DECODER): STRING is
		external
			"IL static signature (ASSEMBLY_NAME_DECODER): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"$$empty_string"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"standard_clone"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"default_create"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"default_pointer"
		end

	assembly_info_from_name (an_assembly_name: ASSEMBLY_NAME): ARRAY_ANY is
		external
			"IL signature (System.Reflection.AssemblyName): ARRAY_ANY use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"assembly_info_from_name"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"Equals"
		end

	neutral_culture: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"neutral_culture"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"generating_type"
		end

	decode_key (a_key: NATIVE_ARRAY [INTEGER_8]): STRING is
		external
			"IL signature (System.Byte[]): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"decode_key"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_decode_key (current_: ASSEMBLY_NAME_DECODER; a_key: NATIVE_ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (ASSEMBLY_NAME_DECODER, System.Byte[]): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"$$decode_key"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_info_from_name (current_: ASSEMBLY_NAME_DECODER; an_assembly_name: ASSEMBLY_NAME): ARRAY_ANY is
		external
			"IL static signature (ASSEMBLY_NAME_DECODER, System.Reflection.AssemblyName): ARRAY_ANY use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"$$assembly_info_from_name"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"conforms_to"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"empty_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ASSEMBLY_NAME_DECODER"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ASSEMBLY_NAME_DECODER

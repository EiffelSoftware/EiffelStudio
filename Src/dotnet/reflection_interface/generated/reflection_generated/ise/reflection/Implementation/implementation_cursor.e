indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CURSOR"

external class
	IMPLEMENTATION_CURSOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CURSOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.CURSOR"
		end

feature -- Basic Operations

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR"
		alias
			"generating_type"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR"
		alias
			"print"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CURSOR"
		alias
			"default_pointer"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR"
		alias
			"conforms_to"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CURSOR"
		alias
			"standard_equal"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CURSOR"
		alias
			"ToString"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CURSOR"
		alias
			"default_rescue"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CURSOR"
		alias
			"GetHashCode"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR"
		alias
			"tagged_out"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CURSOR"
		alias
			"Equals"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CURSOR"
		alias
			"default_create"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR"
		alias
			"internal_copy"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR"
		alias
			"standard_copy"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CURSOR"
		alias
			"clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CURSOR"
		alias
			"operating_environment"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR"
		alias
			"generator"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR"
		alias
			"deep_copy"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CURSOR"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CURSOR"
		alias
			"do_nothing"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CURSOR"
		alias
			"standard_clone"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR"
		alias
			"same_type"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CURSOR"
		alias
			"equal"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR"
		alias
			"out"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CURSOR"
		alias
			"deep_equal"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CURSOR"
		alias
			"default"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR"
		alias
			"standard_is_equal"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CURSOR"
		alias
			"deep_clone"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CURSOR"
		alias
			"____class_name"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CURSOR"
		alias
			"io"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CURSOR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CURSOR

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DEBUG_OUTPUT"

deferred external class
	IMPLEMENTATION_DEBUG_OUTPUT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	DEBUG_OUTPUT

feature -- Basic Operations

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DEBUG_OUTPUT"
		alias
			"generating_type"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"print"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DEBUG_OUTPUT"
		alias
			"default_pointer"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"conforms_to"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"standard_equal"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DEBUG_OUTPUT"
		alias
			"ToString"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"default_rescue"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DEBUG_OUTPUT"
		alias
			"GetHashCode"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DEBUG_OUTPUT"
		alias
			"tagged_out"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"Equals"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"default_create"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"internal_copy"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"standard_copy"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DEBUG_OUTPUT"
		alias
			"clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DEBUG_OUTPUT"
		alias
			"operating_environment"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DEBUG_OUTPUT"
		alias
			"generator"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"deep_copy"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DEBUG_OUTPUT"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"do_nothing"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DEBUG_OUTPUT"
		alias
			"standard_clone"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"same_type"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"equal"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DEBUG_OUTPUT"
		alias
			"out"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"deep_equal"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DEBUG_OUTPUT"
		alias
			"default"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DEBUG_OUTPUT"
		alias
			"standard_is_equal"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DEBUG_OUTPUT"
		alias
			"deep_clone"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DEBUG_OUTPUT"
		alias
			"____class_name"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DEBUG_OUTPUT"
		alias
			"io"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DEBUG_OUTPUT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DEBUG_OUTPUT

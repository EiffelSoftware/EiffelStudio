indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SIGNATURE_TYPE_INTERFACE"

deferred external class
	IMPLEMENTATION_SIGNATURE_TYPE_INTERFACE

inherit
	SIGNATURE_TYPE_INTERFACE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"generating_type"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"print"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"default_pointer"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"conforms_to"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"standard_equal"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"ToString"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"default_rescue"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"GetHashCode"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"tagged_out"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"Equals"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"default_create"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"internal_copy"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"standard_copy"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"operating_environment"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"generator"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"deep_copy"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"do_nothing"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"standard_clone"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"same_type"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"equal"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"out"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"deep_equal"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"default"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"standard_is_equal"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"deep_clone"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"____class_name"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"io"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SIGNATURE_TYPE_INTERFACE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SIGNATURE_TYPE_INTERFACE

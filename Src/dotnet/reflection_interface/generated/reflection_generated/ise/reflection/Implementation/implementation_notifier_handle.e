indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.NOTIFIER_HANDLE"

external class
	IMPLEMENTATION_NOTIFIER_HANDLE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	NOTIFIER_HANDLE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.NOTIFIER_HANDLE"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.NOTIFIER_HANDLE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.NOTIFIER_HANDLE"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER_HANDLE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.NOTIFIER_HANDLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.NOTIFIER_HANDLE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER_HANDLE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.NOTIFIER_HANDLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"equal"
		end

	current_notifier: NOTIFIER is
		external
			"IL signature (): NOTIFIER use Implementation.NOTIFIER_HANDLE"
		alias
			"current_notifier"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.NOTIFIER_HANDLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER_HANDLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.NOTIFIER_HANDLE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.NOTIFIER_HANDLE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.NOTIFIER_HANDLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER_HANDLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_current_notifier (current_: NOTIFIER_HANDLE): NOTIFIER is
		external
			"IL static signature (NOTIFIER_HANDLE): NOTIFIER use Implementation.NOTIFIER_HANDLE"
		alias
			"$$current_notifier"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.NOTIFIER_HANDLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.NOTIFIER_HANDLE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER_HANDLE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: NOTIFIER_HANDLE) is
		external
			"IL static signature (NOTIFIER_HANDLE): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"$$make"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER_HANDLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_NOTIFIER_HANDLE

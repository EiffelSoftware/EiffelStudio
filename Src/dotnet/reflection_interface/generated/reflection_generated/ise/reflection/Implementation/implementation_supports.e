indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SUPPORTS"

external class
	IMPLEMENTATION_SUPPORTS

inherit
	SUPPORT_SUPPORT
	SUPPORTS
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.SUPPORTS"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_code_generation_support: CODE_GENERATION_SUPPORT is
		external
			"IL field signature :CODE_GENERATION_SUPPORT use Implementation.SUPPORTS"
		alias
			"$$code_generation_support"
		end

	frozen ec_illegal_36_ec_illegal_36_reflection_support: REFLECTION_SUPPORT is
		external
			"IL field signature :REFLECTION_SUPPORT use Implementation.SUPPORTS"
		alias
			"$$reflection_support"
		end

	frozen ec_illegal_36_ec_illegal_36_conversion_support: CONVERSION_SUPPORT is
		external
			"IL field signature :CONVERSION_SUPPORT use Implementation.SUPPORTS"
		alias
			"$$conversion_support"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SUPPORTS"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORTS"
		alias
			"deep_clone"
		end

	reflection_support: REFLECTION_SUPPORT is
		external
			"IL signature (): REFLECTION_SUPPORT use Implementation.SUPPORTS"
		alias
			"reflection_support"
		end

	conversion_support: CONVERSION_SUPPORT is
		external
			"IL signature (): CONVERSION_SUPPORT use Implementation.SUPPORTS"
		alias
			"conversion_support"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SUPPORTS"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORTS"
		alias
			"tagged_out"
		end

	a_set_reflection_support (reflection_support2: REFLECTION_SUPPORT) is
		external
			"IL signature (REFLECTION_SUPPORT): System.Void use Implementation.SUPPORTS"
		alias
			"_set_reflection_support"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SUPPORTS"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SUPPORTS"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORTS"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORTS"
		alias
			"is_equal"
		end

	a_set_code_generation_support (code_generation_support2: CODE_GENERATION_SUPPORT) is
		external
			"IL signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.SUPPORTS"
		alias
			"_set_code_generation_support"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORTS"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORTS"
		alias
			"same_type"
		end

	a_set_conversion_support (conversion_support2: CONVERSION_SUPPORT) is
		external
			"IL signature (CONVERSION_SUPPORT): System.Void use Implementation.SUPPORTS"
		alias
			"_set_conversion_support"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORTS"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORTS"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORTS"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORTS"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SUPPORTS"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SUPPORTS"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORTS"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SUPPORTS"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SUPPORTS"
		alias
			"default_pointer"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.SUPPORTS"
		alias
			"to_component_string"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORTS"
		alias
			"standard_copy"
		end

	code_generation_support: CODE_GENERATION_SUPPORT is
		external
			"IL signature (): CODE_GENERATION_SUPPORT use Implementation.SUPPORTS"
		alias
			"code_generation_support"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.SUPPORTS"
		alias
			"from_system_string"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SUPPORTS"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORTS"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SUPPORTS"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORTS"
		alias
			"generating_type"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.SUPPORTS"
		alias
			"to_notifier_string"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.SUPPORTS"
		alias
			"from_notifier_string"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SUPPORTS"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SUPPORTS"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORTS"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORTS"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORTS"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORTS"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: SUPPORTS) is
		external
			"IL static signature (SUPPORTS): System.Void use Implementation.SUPPORTS"
		alias
			"$$make"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.SUPPORTS"
		alias
			"make"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.SUPPORTS"
		alias
			"from_component_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORTS"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SUPPORTS"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SUPPORTS

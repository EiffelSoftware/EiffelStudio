indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"

external class
	IMPLEMENTATION_EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT

inherit
	EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT
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
			"IL creator use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_from_component_string (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT; string: STRING): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT, STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"$$from_component_string"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_to_component_string (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT; string: STRING): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT, STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"$$to_component_string"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"from_support_string"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_from_notifier_string (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT; string: STRING): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT, STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"$$from_notifier_string"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"default_pointer"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"to_component_string"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_to_support_string (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT; string: STRING): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT, STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"$$to_support_string"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"from_system_string"
		end

	frozen ec_illegal_36_ec_illegal_36_to_notifier_string (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT; string: STRING): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT, STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"$$to_notifier_string"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_from_support_string (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT; string: STRING): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT, STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"$$from_support_string"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"to_notifier_string"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"from_notifier_string"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_from_system_string (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT; string: SYSTEM_STRING): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT, System.String): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"$$from_system_string"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"clone"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"to_support_string"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"conforms_to"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"from_component_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT

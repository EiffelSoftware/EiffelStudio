indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"

external class
	IMPLEMENTATION_REFLECTION_SUPPORT_ERROR_MESSAGES

inherit
	SUPPORT_ERROR_MESSAGES
	REFLECTION_SUPPORT_ERROR_MESSAGES
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
			"IL creator use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"deep_clone"
		end

	hash_value_computation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"hash_value_computation_failed"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"operating_environment"
		end

	no_assembly_description: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"no_assembly_description"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"is_equal"
		end

	no_type_description_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"no_type_description_message"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_no_type_description_message (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$no_type_description_message"
		end

	frozen ec_illegal_36_ec_illegal_36_hash_value_computation_failed (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$hash_value_computation_failed"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_no_assembly_description_message (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$no_assembly_description_message"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"Equals"
		end

	registry_key_not_registered: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"registry_key_not_registered"
		end

	hash_value_computation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"hash_value_computation_failed_message"
		end

	registry_key_not_registered_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"registry_key_not_registered_message"
		end

	frozen ec_illegal_36_ec_illegal_36_no_assembly_description (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$no_assembly_description"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_registry_key_not_registered_message (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$registry_key_not_registered_message"
		end

	no_type_description: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"no_type_description"
		end

	frozen ec_illegal_36_ec_illegal_36_registry_key_not_registered (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$registry_key_not_registered"
		end

	frozen ec_illegal_36_ec_illegal_36_no_type_description (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$no_type_description"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"io"
		end

	no_assembly_description_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"no_assembly_description_message"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_hash_value_computation_failed_message (current_: REFLECTION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$hash_value_computation_failed_message"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT_ERROR_MESSAGES"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_REFLECTION_SUPPORT_ERROR_MESSAGES

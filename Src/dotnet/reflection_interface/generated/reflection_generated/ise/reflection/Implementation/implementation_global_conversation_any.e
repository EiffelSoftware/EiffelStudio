indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.GLOBAL_CONVERSATION_ANY"

external class
	IMPLEMENTATION_GLOBAL_CONVERSATION_ANY

inherit
	GLOBAL_CONVERSATION_ANY
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
			"IL creator use Implementation.GLOBAL_CONVERSATION_ANY"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_to_eiffel_linked_list (current_: GLOBAL_CONVERSATION_ANY; a_list: ARRAY_LIST): LINKED_LIST_ANY is
		external
			"IL static signature (GLOBAL_CONVERSATION_ANY, System.Collections.ArrayList): LINKED_LIST_ANY use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"$$to_eiffel_linked_list"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"is_equal"
		end

	to_eiffel_linked_list (a_list: ARRAY_LIST): LINKED_LIST_ANY is
		external
			"IL signature (System.Collections.ArrayList): LINKED_LIST_ANY use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"to_eiffel_linked_list"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"equal"
		end

	from_eiffel_linked_list (a_list: LINKED_LIST_ANY): ARRAY_LIST is
		external
			"IL signature (LINKED_LIST_ANY): System.Collections.ArrayList use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"from_eiffel_linked_list"
		end

	frozen ec_illegal_36_ec_illegal_36_to_eiffel_string (current_: GLOBAL_CONVERSATION_ANY; string: SYSTEM_STRING): STRING is
		external
			"IL static signature (GLOBAL_CONVERSATION_ANY, System.String): STRING use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"$$to_eiffel_string"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_from_eiffel_linked_list (current_: GLOBAL_CONVERSATION_ANY; a_list: LINKED_LIST_ANY): ARRAY_LIST is
		external
			"IL static signature (GLOBAL_CONVERSATION_ANY, LINKED_LIST_ANY): System.Collections.ArrayList use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"$$from_eiffel_linked_list"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_from_eiffel_string (current_: GLOBAL_CONVERSATION_ANY; string: STRING): SYSTEM_STRING is
		external
			"IL static signature (GLOBAL_CONVERSATION_ANY, STRING): System.String use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"$$from_eiffel_string"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"generating_type"
		end

	from_eiffel_string (string: STRING): SYSTEM_STRING is
		external
			"IL signature (STRING): System.String use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"from_eiffel_string"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"conforms_to"
		end

	to_eiffel_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"to_eiffel_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.GLOBAL_CONVERSATION_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_GLOBAL_CONVERSATION_ANY

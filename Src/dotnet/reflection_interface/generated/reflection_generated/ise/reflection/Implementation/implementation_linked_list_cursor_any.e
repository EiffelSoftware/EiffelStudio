indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.LINKED_LIST_CURSOR_ANY"

external class
	IMPLEMENTATION_LINKED_LIST_CURSOR_ANY

inherit
	LINKED_LIST_CURSOR_ANY
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CURSOR

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.LINKED_LIST_CURSOR_ANY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_before: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"$$before"
		end

	frozen ec_illegal_36_ec_illegal_36_after: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"$$after"
		end

	frozen ec_illegal_36_ec_illegal_36_active: LINKABLE_ANY is
		external
			"IL field signature :LINKABLE_ANY use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"$$active"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"deep_clone"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"after"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"internal_copy"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"before"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"equal"
		end

	active: LINKABLE_ANY is
		external
			"IL signature (): LINKABLE_ANY use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"active"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"default_pointer"
		end

	a_set_after (after2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"_set_after"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"deep_equal"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"standard_clone"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"Equals"
		end

	a_set_before (before2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"_set_before"
		end

	a_set_active (active2: LINKABLE_ANY) is
		external
			"IL signature (LINKABLE_ANY): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"_set_active"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"generating_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: LINKED_LIST_CURSOR_ANY; active_element: LINKABLE_ANY; aft: BOOLEAN; bef: BOOLEAN) is
		external
			"IL static signature (LINKED_LIST_CURSOR_ANY, LINKABLE_ANY, System.Boolean, System.Boolean): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"$$make"
		end

	make (active_element: LINKABLE_ANY; aft: BOOLEAN; bef: BOOLEAN) is
		external
			"IL signature (LINKABLE_ANY, System.Boolean, System.Boolean): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_CURSOR_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_LINKED_LIST_CURSOR_ANY

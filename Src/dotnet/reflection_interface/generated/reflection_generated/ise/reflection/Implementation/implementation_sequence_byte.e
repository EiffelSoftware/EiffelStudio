indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SEQUENCE_BYTE"

deferred external class
	IMPLEMENTATION_SEQUENCE_BYTE

inherit
	LINEAR_BYTE
		rename
			occurrences as occurrences_byte
		end
	SEQUENCE_BYTE
		rename
			occurrences as occurrences_byte
		end
	BILINEAR_BYTE
		rename
			occurrences as occurrences_byte
		end
	BAG_BYTE
		rename
			occurrences as occurrences_byte
		end
	COLLECTION_BYTE
	TRAVERSABLE_BYTE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ACTIVE_BYTE
		rename
			occurrences as occurrences_byte
		end
	FINITE_BYTE
	CONTAINER_BYTE
	BOX_BYTE

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SEQUENCE_BYTE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_BYTE"
		alias
			"deep_clone"
		end

	search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"search"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_append (current_: SEQUENCE_BYTE; s: SEQUENCE_BYTE) is
		external
			"IL static signature (SEQUENCE_BYTE, SEQUENCE_BYTE): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"$$append"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_BYTE"
		alias
			"tagged_out"
		end

	has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"has"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SEQUENCE_BYTE"
		alias
			"internal_clone"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"empty"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SEQUENCE_BYTE"
		alias
			"operating_environment"
		end

	occurrences_byte (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.SEQUENCE_BYTE"
		alias
			"occurrences"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"internal_copy"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_BYTE"
		alias
			"generator"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"compare_objects"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"there_exists"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_BYTE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"equal"
		end

	is_inserted (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"is_inserted"
		end

	linear_representation: LINEAR_BYTE is
		external
			"IL signature (): LINEAR_BYTE use Implementation.SEQUENCE_BYTE"
		alias
			"linear_representation"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"is_empty"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SEQUENCE_BYTE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_BYTE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"default_rescue"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"off"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SEQUENCE_BYTE"
		alias
			"default_pointer"
		end

	prune (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"prune"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"standard_copy"
		end

	force (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"force"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SEQUENCE_BYTE"
		alias
			"ToString"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"readable"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SEQUENCE_BYTE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"Equals"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"writable"
		end

	fill (other: CONTAINER_BYTE) is
		external
			"IL signature (CONTAINER_BYTE): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: SEQUENCE_BYTE; v: INTEGER_8) is
		external
			"IL static signature (SEQUENCE_BYTE, System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"$$prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: SEQUENCE_BYTE; v: INTEGER_8) is
		external
			"IL static signature (SEQUENCE_BYTE, System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"$$put"
		end

	append (s: SEQUENCE_BYTE) is
		external
			"IL signature (SEQUENCE_BYTE): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"append"
		end

	sequential_search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_readable (current_: SEQUENCE_BYTE): BOOLEAN is
		external
			"IL static signature (SEQUENCE_BYTE): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"$$readable"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"do_all"
		end

	prune_all (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"prune_all"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_BYTE"
		alias
			"generating_type"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"do_if"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"object_comparison"
		end

	put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"put"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"for_all"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SEQUENCE_BYTE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_BYTE"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_writable (current_: SEQUENCE_BYTE): BOOLEAN is
		external
			"IL static signature (SEQUENCE_BYTE): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"$$writable"
		end

	index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.SEQUENCE_BYTE"
		alias
			"index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: SEQUENCE_BYTE; v: INTEGER_8) is
		external
			"IL static signature (SEQUENCE_BYTE, System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"$$force"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: SEQUENCE_BYTE; v: INTEGER_8) is
		external
			"IL static signature (SEQUENCE_BYTE, System.Byte): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"$$prune"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_BYTE"
		alias
			"exhausted"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_BYTE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SEQUENCE_BYTE

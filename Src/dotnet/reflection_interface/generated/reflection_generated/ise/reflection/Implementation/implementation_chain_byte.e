indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHAIN_BYTE"

deferred external class
	IMPLEMENTATION_CHAIN_BYTE

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
	CURSOR_STRUCTURE_BYTE
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
	INDEXABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			valid_key as valid_index,
			item as item_int32
		end
	CHAIN_BYTE
		rename
			occurrences as occurrences_byte,
			valid_key as valid_index
		end
	TABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			valid_key as valid_index,
			item as item_int32
		end
	BOX_BYTE

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHAIN_BYTE"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_BYTE"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_index_of (current_: CHAIN_BYTE; v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_BYTE, System.Byte, System.Int32): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"$$sequential_index_of"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor_index (current_: CHAIN_BYTE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_BYTE, System.Int32): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$valid_cursor_index"
		end

	frozen ec_illegal_36_ec_illegal_36_put_i_th (current_: CHAIN_BYTE; v: INTEGER_8; i: INTEGER) is
		external
			"IL static signature (CHAIN_BYTE, System.Byte, System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$put_i_th"
		end

	last: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"last"
		end

	item_int32 (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CHAIN_BYTE"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BYTE"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: CHAIN_BYTE; v: INTEGER_8): INTEGER is
		external
			"IL static signature (CHAIN_BYTE, System.Byte): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"$$occurrences"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BYTE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: CHAIN_BYTE): INTEGER_8 is
		external
			"IL static signature (CHAIN_BYTE): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"$$last"
		end

	put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BYTE"
		alias
			"out"
		end

	is_inserted (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: CHAIN_BYTE) is
		external
			"IL static signature (CHAIN_BYTE): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$finish"
		end

	prune (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"changeable_comparison_criterion"
		end

	sequential_occurrences (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"sequential_occurrences"
		end

	append (s: SEQUENCE_BYTE) is
		external
			"IL signature (SEQUENCE_BYTE): System.Void use Implementation.CHAIN_BYTE"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"there_exists"
		end

	sequential_index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHAIN_BYTE"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"empty"
		end

	force (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BYTE"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: CHAIN_BYTE) is
		external
			"IL static signature (CHAIN_BYTE): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"readable"
		end

	put_byte_int32 (v: INTEGER_8; i: INTEGER) is
		external
			"IL signature (System.Byte, System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"put_i_th"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CHAIN_BYTE"
		alias
			"do_all"
		end

	index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"index_of"
		end

	fill (other: CONTAINER_BYTE) is
		external
			"IL signature (CONTAINER_BYTE): System.Void use Implementation.CHAIN_BYTE"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.CHAIN_BYTE"
		alias
			"index_set"
		end

	has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"has"
		end

	first: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"first"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"move"
		end

	prune_all (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: CHAIN_BYTE): BOOLEAN is
		external
			"IL static signature (CHAIN_BYTE): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$islast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_sequence_put (current_: CHAIN_BYTE; v: INTEGER_8) is
		external
			"IL static signature (CHAIN_BYTE, System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$sequence_put"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: CHAIN_BYTE; i: INTEGER) is
		external
			"IL static signature (CHAIN_BYTE, System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$move"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: CHAIN_BYTE; i: INTEGER) is
		external
			"IL static signature (CHAIN_BYTE, System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: CHAIN_BYTE): INTEGER_INTERVAL is
		external
			"IL static signature (CHAIN_BYTE): INTEGER_INTERVAL use Implementation.CHAIN_BYTE"
		alias
			"$$index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: CHAIN_BYTE) is
		external
			"IL static signature (CHAIN_BYTE): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: CHAIN_BYTE; v: INTEGER_8): BOOLEAN is
		external
			"IL static signature (CHAIN_BYTE, System.Byte): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: CHAIN_BYTE; i: INTEGER) is
		external
			"IL static signature (CHAIN_BYTE, System.Int32): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: CHAIN_BYTE): BOOLEAN is
		external
			"IL static signature (CHAIN_BYTE): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$isfirst"
		end

	linear_representation: LINEAR_BYTE is
		external
			"IL signature (): LINEAR_BYTE use Implementation.CHAIN_BYTE"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_BYTE"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_BYTE"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"compare_references"
		end

	bag_put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: CHAIN_BYTE; i: INTEGER): INTEGER_8 is
		external
			"IL static signature (CHAIN_BYTE, System.Int32): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"$$i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_bag_put (current_: CHAIN_BYTE; v: INTEGER_8) is
		external
			"IL static signature (CHAIN_BYTE, System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BYTE"
		alias
			"print"
		end

	occurrences_byte (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"occurrences"
		end

	sequential_search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_occurrences (current_: CHAIN_BYTE; v: INTEGER_8): INTEGER is
		external
			"IL static signature (CHAIN_BYTE, System.Byte): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"$$sequential_occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: CHAIN_BYTE): INTEGER_8 is
		external
			"IL static signature (CHAIN_BYTE): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"$$first"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_BYTE"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: CHAIN_BYTE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_BYTE, System.Int32): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$valid_index"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_has (current_: CHAIN_BYTE; v: INTEGER_8): BOOLEAN is
		external
			"IL static signature (CHAIN_BYTE, System.Byte): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$sequential_has"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BYTE"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: CHAIN_BYTE): BOOLEAN is
		external
			"IL static signature (CHAIN_BYTE): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"$$off"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: CHAIN_BYTE; i: INTEGER): INTEGER_8 is
		external
			"IL static signature (CHAIN_BYTE, System.Int32): System.Byte use Implementation.CHAIN_BYTE"
		alias
			"$$infix "@""
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"deep_equal"
		end

	sequential_has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.CHAIN_BYTE"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_BYTE"
		alias
			"standard_clone"
		end

	sequence_put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: CHAIN_BYTE; v: INTEGER_8) is
		external
			"IL static signature (CHAIN_BYTE, System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_BYTE"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BYTE"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_BYTE"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BYTE"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BYTE"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_BYTE"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: CHAIN_BYTE; v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_BYTE, System.Byte, System.Int32): System.Int32 use Implementation.CHAIN_BYTE"
		alias
			"$$index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BYTE"
		alias
			"deep_copy"
		end

	search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CHAIN_BYTE"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BYTE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHAIN_BYTE

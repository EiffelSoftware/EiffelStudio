indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DYNAMIC_LIST_BYTE"

deferred external class
	IMPLEMENTATION_DYNAMIC_LIST_BYTE

inherit
	LINEAR_BYTE
		rename
			occurrences as occurrences_byte
		end
	TRAVERSABLE_BYTE
	BOX_BYTE
	SEQUENCE_BYTE
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
	BILINEAR_BYTE
		rename
			occurrences as occurrences_byte
		end
	DYNAMIC_CHAIN_BYTE
		rename
			occurrences as occurrences_byte,
			valid_key as valid_index
		end
	LIST_BYTE
		rename
			occurrences as occurrences_byte,
			valid_key as valid_index
		end
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
	COLLECTION_BYTE
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
	UNBOUNDED_BYTE
	CONTAINER_BYTE
	DYNAMIC_LIST_BYTE
		rename
			occurrences as occurrences_byte,
			valid_key as valid_index
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"default_create"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"start"
		end

	last: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"last"
		end

	item_int32 (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"finish"
		end

	put_byte_int32 (v: INTEGER_8; i: INTEGER) is
		external
			"IL signature (System.Byte, System.Int32): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"put_i_th"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"generating_type"
		end

	put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"put"
		end

	bag_put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"bag_put"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: DYNAMIC_LIST_BYTE; other: DYNAMIC_LIST_BYTE) is
		external
			"IL static signature (DYNAMIC_LIST_BYTE, DYNAMIC_LIST_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"$$merge_left"
		end

	is_inserted (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"is_inserted"
		end

	prune (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"changeable_comparison_criterion"
		end

	append (s: SEQUENCE_BYTE) is
		external
			"IL signature (SEQUENCE_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"append"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"valid_cursor_index"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"there_exists"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"GetHashCode"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"empty"
		end

	force (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"force"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"after"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"tagged_out"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"readable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"before"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"do_all"
		end

	index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"index_of"
		end

	fill (other: CONTAINER_BYTE) is
		external
			"IL signature (CONTAINER_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: DYNAMIC_LIST_BYTE) is
		external
			"IL static signature (DYNAMIC_LIST_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"$$wipe_out"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"index_set"
		end

	has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"has"
		end

	first: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"first"
		end

	sequential_occurrences (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"sequential_occurrences"
		end

	prune_all (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_chain_wipe_out (current_: DYNAMIC_LIST_BYTE) is
		external
			"IL static signature (DYNAMIC_LIST_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"$$chain_wipe_out"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"writable"
		end

	merge_left (other: DYNAMIC_CHAIN_BYTE) is
		external
			"IL signature (DYNAMIC_CHAIN_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"merge_left"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: DYNAMIC_LIST_BYTE; other: DYNAMIC_LIST_BYTE) is
		external
			"IL static signature (DYNAMIC_LIST_BYTE, DYNAMIC_LIST_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"$$merge_right"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"chain_wipe_out"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"go_i_th"
		end

	infix "@" (k: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"infix "@""
		end

	linear_representation: LINEAR_BYTE is
		external
			"IL signature (): LINEAR_BYTE use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"compare_references"
		end

	duplicate (n: INTEGER): CHAIN_BYTE is
		external
			"IL signature (System.Int32): CHAIN_BYTE use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"duplicate"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"print"
		end

	occurrences_byte (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"occurrences"
		end

	sequential_index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"sequential_index_of"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"valid_index"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"standard_equal"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"same_type"
		end

	sequential_search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"sequential_search"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"standard_copy"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"islast"
		end

	merge_right (other: DYNAMIC_CHAIN_BYTE) is
		external
			"IL signature (DYNAMIC_CHAIN_BYTE): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"merge_right"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"deep_equal"
		end

	put_left (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"put_left"
		end

	sequential_has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"standard_clone"
		end

	sequence_put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"sequence_put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: DYNAMIC_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (DYNAMIC_LIST_BYTE, System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"wipe_out"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"deep_copy"
		end

	search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_BYTE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DYNAMIC_LIST_BYTE

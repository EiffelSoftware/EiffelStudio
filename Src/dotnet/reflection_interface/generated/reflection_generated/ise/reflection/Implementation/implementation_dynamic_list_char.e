indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DYNAMIC_LIST_CHAR"

deferred external class
	IMPLEMENTATION_DYNAMIC_LIST_CHAR

inherit
	CHAIN_CHAR
		rename
			occurrences as occurrences_char,
			valid_key as valid_index
		end
	BOX_CHAR
	CONTAINER_CHAR
	SEQUENCE_CHAR
		rename
			occurrences as occurrences_char
		end
	TABLE_CHAR_INT32
		rename
			occurrences as occurrences_char,
			valid_key as valid_index,
			item as item_int32
		end
	UNBOUNDED_CHAR
	DYNAMIC_CHAIN_CHAR
		rename
			occurrences as occurrences_char,
			valid_key as valid_index
		end
	CURSOR_STRUCTURE_CHAR
		rename
			occurrences as occurrences_char
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	LINEAR_CHAR
		rename
			occurrences as occurrences_char
		end
	BAG_CHAR
		rename
			occurrences as occurrences_char
		end
	LIST_CHAR
		rename
			occurrences as occurrences_char,
			valid_key as valid_index
		end
	INDEXABLE_CHAR_INT32
		rename
			occurrences as occurrences_char,
			valid_key as valid_index,
			item as item_int32
		end
	FINITE_CHAR
	ACTIVE_CHAR
		rename
			occurrences as occurrences_char
		end
	BILINEAR_CHAR
		rename
			occurrences as occurrences_char
		end
	TRAVERSABLE_CHAR
	COLLECTION_CHAR
	DYNAMIC_LIST_CHAR
		rename
			occurrences as occurrences_char,
			valid_key as valid_index
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"default_create"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"start"
		end

	last: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"last"
		end

	item_int32 (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"generating_type"
		end

	occurrences_char (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"occurrences"
		end

	put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"put"
		end

	bag_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"bag_put"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: DYNAMIC_LIST_CHAR; other: DYNAMIC_LIST_CHAR) is
		external
			"IL static signature (DYNAMIC_LIST_CHAR, DYNAMIC_LIST_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"$$merge_left"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"is_inserted"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"changeable_comparison_criterion"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL signature (SEQUENCE_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"append"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"valid_cursor_index"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"there_exists"
		end

	sequential_index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"GetHashCode"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"empty"
		end

	force (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"force"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"after"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"tagged_out"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"readable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"before"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"do_all"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"index_of"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: DYNAMIC_LIST_CHAR) is
		external
			"IL static signature (DYNAMIC_LIST_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"$$wipe_out"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"index_set"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"has"
		end

	first: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"first"
		end

	sequential_occurrences (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"sequential_occurrences"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_chain_wipe_out (current_: DYNAMIC_LIST_CHAR) is
		external
			"IL static signature (DYNAMIC_LIST_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"$$chain_wipe_out"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"writable"
		end

	merge_left (other: DYNAMIC_CHAIN_CHAR) is
		external
			"IL signature (DYNAMIC_CHAIN_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"merge_left"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: DYNAMIC_LIST_CHAR; other: DYNAMIC_LIST_CHAR) is
		external
			"IL static signature (DYNAMIC_LIST_CHAR, DYNAMIC_LIST_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"$$merge_right"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"chain_wipe_out"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"go_i_th"
		end

	infix "@" (k: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"infix "@""
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"compare_references"
		end

	duplicate (n: INTEGER): CHAIN_CHAR is
		external
			"IL signature (System.Int32): CHAIN_CHAR use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"duplicate"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"print"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"valid_index"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"standard_equal"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"standard_copy"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"islast"
		end

	merge_right (other: DYNAMIC_CHAIN_CHAR) is
		external
			"IL signature (DYNAMIC_CHAIN_CHAR): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"merge_right"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"deep_equal"
		end

	put_left (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"put_left"
		end

	sequential_has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"standard_clone"
		end

	sequence_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"sequence_put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: DYNAMIC_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (DYNAMIC_LIST_CHAR, System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"wipe_out"
		end

	put_char_int32 (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"put_i_th"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"deep_copy"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_CHAR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DYNAMIC_LIST_CHAR

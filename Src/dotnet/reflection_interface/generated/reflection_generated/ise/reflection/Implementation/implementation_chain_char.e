indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHAIN_CHAR"

deferred external class
	IMPLEMENTATION_CHAIN_CHAR

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

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHAIN_CHAR"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_CHAR"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_index_of (current_: CHAIN_CHAR; v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_CHAR, System.Char, System.Int32): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"$$sequential_index_of"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor_index (current_: CHAIN_CHAR; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_CHAR, System.Int32): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$valid_cursor_index"
		end

	frozen ec_illegal_36_ec_illegal_36_put_i_th (current_: CHAIN_CHAR; v: CHARACTER; i: INTEGER) is
		external
			"IL static signature (CHAIN_CHAR, System.Char, System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$put_i_th"
		end

	last: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CHAIN_CHAR"
		alias
			"last"
		end

	item_int32 (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.CHAIN_CHAR"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CHAIN_CHAR"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_CHAR"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: CHAIN_CHAR; v: CHARACTER): INTEGER is
		external
			"IL static signature (CHAIN_CHAR, System.Char): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"$$occurrences"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_CHAR"
		alias
			"generating_type"
		end

	occurrences_char (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"occurrences"
		end

	put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_CHAR"
		alias
			"out"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: CHAIN_CHAR) is
		external
			"IL static signature (CHAIN_CHAR): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$finish"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"changeable_comparison_criterion"
		end

	sequential_occurrences (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"sequential_occurrences"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL signature (SEQUENCE_CHAR): System.Void use Implementation.CHAIN_CHAR"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"there_exists"
		end

	sequential_index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHAIN_CHAR"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"empty"
		end

	force (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"force"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: CHAIN_CHAR; v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_CHAR, System.Char, System.Int32): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"$$index_of"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_CHAR"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: CHAIN_CHAR) is
		external
			"IL static signature (CHAIN_CHAR): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"readable"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: CHAIN_CHAR; i: INTEGER): CHARACTER is
		external
			"IL static signature (CHAIN_CHAR, System.Int32): System.Char use Implementation.CHAIN_CHAR"
		alias
			"$$infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CHAIN_CHAR"
		alias
			"do_all"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"index_of"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.CHAIN_CHAR"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.CHAIN_CHAR"
		alias
			"index_set"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"has"
		end

	first: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CHAIN_CHAR"
		alias
			"first"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"move"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: CHAIN_CHAR): BOOLEAN is
		external
			"IL static signature (CHAIN_CHAR): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$islast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_sequence_put (current_: CHAIN_CHAR; v: CHARACTER) is
		external
			"IL static signature (CHAIN_CHAR, System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$sequence_put"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: CHAIN_CHAR; i: INTEGER) is
		external
			"IL static signature (CHAIN_CHAR, System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$move"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: CHAIN_CHAR; i: INTEGER) is
		external
			"IL static signature (CHAIN_CHAR, System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: CHAIN_CHAR): INTEGER_INTERVAL is
		external
			"IL static signature (CHAIN_CHAR): INTEGER_INTERVAL use Implementation.CHAIN_CHAR"
		alias
			"$$index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: CHAIN_CHAR) is
		external
			"IL static signature (CHAIN_CHAR): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: CHAIN_CHAR; v: CHARACTER): BOOLEAN is
		external
			"IL static signature (CHAIN_CHAR, System.Char): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: CHAIN_CHAR; i: INTEGER) is
		external
			"IL static signature (CHAIN_CHAR, System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.CHAIN_CHAR"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: CHAIN_CHAR): BOOLEAN is
		external
			"IL static signature (CHAIN_CHAR): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$isfirst"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.CHAIN_CHAR"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_CHAR"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_CHAR"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"compare_references"
		end

	bag_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: CHAIN_CHAR; i: INTEGER): CHARACTER is
		external
			"IL static signature (CHAIN_CHAR, System.Int32): System.Char use Implementation.CHAIN_CHAR"
		alias
			"$$i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_bag_put (current_: CHAIN_CHAR; v: CHARACTER) is
		external
			"IL static signature (CHAIN_CHAR, System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_CHAR"
		alias
			"print"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_occurrences (current_: CHAIN_CHAR; v: CHARACTER): INTEGER is
		external
			"IL static signature (CHAIN_CHAR, System.Char): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"$$sequential_occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: CHAIN_CHAR): CHARACTER is
		external
			"IL static signature (CHAIN_CHAR): System.Char use Implementation.CHAIN_CHAR"
		alias
			"$$first"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_CHAR"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: CHAIN_CHAR; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_CHAR, System.Int32): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$valid_index"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_has (current_: CHAIN_CHAR; v: CHARACTER): BOOLEAN is
		external
			"IL static signature (CHAIN_CHAR, System.Char): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$sequential_has"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_CHAR"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHAIN_CHAR"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: CHAIN_CHAR): BOOLEAN is
		external
			"IL static signature (CHAIN_CHAR): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"$$off"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"deep_equal"
		end

	sequential_has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CHAIN_CHAR"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_CHAR"
		alias
			"standard_clone"
		end

	sequence_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: CHAIN_CHAR; v: CHARACTER) is
		external
			"IL static signature (CHAIN_CHAR, System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_CHAR"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_CHAR"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_CHAR"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_CHAR"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_CHAR"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_CHAR"
		alias
			"ToString"
		end

	put_char_int32 (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.CHAIN_CHAR"
		alias
			"put_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: CHAIN_CHAR): CHARACTER is
		external
			"IL static signature (CHAIN_CHAR): System.Char use Implementation.CHAIN_CHAR"
		alias
			"$$last"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_CHAR"
		alias
			"deep_copy"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHAIN_CHAR"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHAIN_CHAR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHAIN_CHAR

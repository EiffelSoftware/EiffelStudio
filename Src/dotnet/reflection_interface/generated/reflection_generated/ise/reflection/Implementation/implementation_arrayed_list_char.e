indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_CHAR"

external class
	IMPLEMENTATION_ARRAYED_LIST_CHAR

inherit
	DYNAMIC_LIST_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	LINEAR_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			index as index_int32
		end
	ACTIVE_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char
		end
	RESIZABLE_CHAR
		rename
			count as count_int32
		end
	BOX_CHAR
	FINITE_CHAR
		rename
			count as count_int32
		end
	CONTAINER_CHAR
	BAG_CHAR
		rename
			occurrences as occurrences_char
		end
	CURSOR_STRUCTURE_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char
		end
	UNBOUNDED_CHAR
		rename
			count as count_int32
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SEQUENCE_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			index as index_int32,
			count as count_int32
		end
	ARRAY_CHAR
		rename
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			item as item_int322,
			force as force_char_int32,
			make as array_make
		end
	TO_SPECIAL_CHAR
		rename
			infix "@" as infix "@"_int32,
			put as put_char_int322,
			valid_index as array_valid_index,
			item as item_int322
		end
	INDEXABLE_CHAR_INT32
		rename
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	CHAIN_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	BOUNDED_CHAR
		rename
			count as count_int32
		end
	BILINEAR_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			index as index_int32
		end
	LIST_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	ARRAYED_LIST_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			make as array_make
		end
	DYNAMIC_CHAIN_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	COLLECTION_CHAR
	TABLE_CHAR_INT32
		rename
			occurrences as occurrences_char,
			infix "@" as infix "@"_int32,
			put_char_int32 as put_char_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	TRAVERSABLE_CHAR
		rename
			item as item_char
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_CHAR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_CHAR is
		external
			"IL field signature :SPECIAL_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$back"
		end

	force_char_int32 (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"force_i_th"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"object_comparison"
		end

	sequential_index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"sequential_index_of"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_CHAR"
		alias
			"____class_name"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"array_count"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_CHAR; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_CHAR) is
		external
			"IL signature (SPECIAL_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"set_area"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_CHAR"
		alias
			"operating_environment"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_CHAR; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_CHAR, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"subcopy"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_CHAR; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"same_type"
		end

	replace (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"replace"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_CHAR; a: ARRAY_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, ARRAY_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"do_if"
		end

	item_char: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"item"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_CHAR"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_CHAR): CHARACTER is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$first"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"has"
		end

	put_left (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_CHAR; n: INTEGER): ARRAYED_LIST_CHAR is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): ARRAYED_LIST_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$duplicate"
		end

	sequence_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"sequence_put"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_CHAR): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_CHAR): CURSOR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"writable"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"is_inserted"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"default_create"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_CHAR; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, CURSOR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_CHAR) is
		external
			"IL signature (ARRAY_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_CHAR; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$make_filled"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_CHAR"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_CHAR"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"_set_lower"
		end

	bag_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"bag_put"
		end

	enter (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_CHAR): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_CHAR; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$set_count"
		end

	sequential_has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_CHAR) is
		external
			"IL signature (DYNAMIC_CHAIN_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_CHAR"
		alias
			"tagged_out"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_CHAR is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_CHAR): ARRAYED_LIST_CHAR is
		external
			"IL static signature (ARRAYED_LIST_CHAR): ARRAYED_LIST_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"start"
		end

	insert (v: CHARACTER; pos: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_CHAR; v: CHARACTER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_CHAR is
		external
			"IL signature (): DYNAMIC_CHAIN_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"new_chain"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"discard_items"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_CHAR) is
		external
			"IL signature (SPECIAL_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"count"
		end

	infix "@"_int32 (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"prunable"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"prune_all"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_CHAR"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_CHAR is
		external
			"IL signature (System.Int32): CHAIN_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"duplicate"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_CHAR; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$valid_index"
		end

	put_front (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"equal"
		end

	put_char_int322 (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"put_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_CHAR"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_CHAR"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"go_i_th"
		end

	area: SPECIAL_CHAR is
		external
			"IL signature (): SPECIAL_CHAR use Implementation.ARRAYED_LIST_CHAR"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_CHAR): CHARACTER is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"empty_area"
		end

	item_int322 (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"i_th"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"array_valid_index"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_CHAR"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"make_area"
		end

	force (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"chain_wipe_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_CHAR"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_CHAR) is
		external
			"IL signature (DYNAMIC_CHAIN_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_CHAR; other: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$merge_right"
		end

	occurrences_char (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"occurrences"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"set_count"
		end

	same_items (other: ARRAY_CHAR): BOOLEAN is
		external
			"IL signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"deep_equal"
		end

	put_right (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"put_right"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_CHAR): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_CHAR): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"make"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_CHAR; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_CHAR; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_CHAR, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_CHAR"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"GetHashCode"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"there_exists"
		end

	put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"resizable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"before"
		end

	extend (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$remove_right"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_CHAR"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_CHAR"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"finish"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_CHAR"
		alias
			"index_set"
		end

	sequential_occurrences (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"sequential_occurrences"
		end

	entry (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"entry"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_CHAR"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_CHAR): CHARACTER is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_CHAR"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"print"
		end

	last: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_CHAR; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [CHARACTER] is
		external
			"IL signature (): System.Char[] use Implementation.ARRAYED_LIST_CHAR"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"copy"
		end

	first: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.ARRAYED_LIST_CHAR"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_CHAR): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_CHAR; other: ARRAYED_LIST_CHAR) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, ARRAYED_LIST_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL signature (SEQUENCE_CHAR): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_CHAR; v: CHARACTER; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_CHAR, System.Char, System.Int32): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_CHAR"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_CHAR"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_CHAR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_CHAR

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_DOUBLE"

external class
	IMPLEMENTATION_ARRAYED_LIST_DOUBLE

inherit
	BOUNDED_DOUBLE
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
	RESIZABLE_DOUBLE
		rename
			count as count_int32
		end
	BILINEAR_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			index as index_int32
		end
	CURSOR_STRUCTURE_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double
		end
	LINEAR_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			index as index_int32
		end
	BOX_DOUBLE
	CHAIN_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	ARRAYED_LIST_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			make as array_make
		end
	CONTAINER_DOUBLE
	DYNAMIC_LIST_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	TO_SPECIAL_DOUBLE
		rename
			infix "@" as infix "@"_int32,
			put as put_double_int322,
			valid_index as array_valid_index,
			item as item_int322
		end
	LIST_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	COLLECTION_DOUBLE
	UNBOUNDED_DOUBLE
		rename
			count as count_int32
		end
	FINITE_DOUBLE
		rename
			count as count_int32
		end
	DYNAMIC_CHAIN_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	SEQUENCE_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double,
			index as index_int32,
			count as count_int32
		end
	TABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	INDEXABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	ARRAY_DOUBLE
		rename
			occurrences as occurrences_double,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_double_int32 as put_double_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			item as item_int322,
			force as force_double_int32,
			make as array_make
		end
	TRAVERSABLE_DOUBLE
		rename
			item as item_double
		end
	BAG_DOUBLE
		rename
			occurrences as occurrences_double
		end
	ACTIVE_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_DOUBLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_DOUBLE is
		external
			"IL field signature :SPECIAL_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"go_to"
		end

	occurrences_double (v: DOUBLE): INTEGER is
		external
			"IL signature (System.Double): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$back"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"object_comparison"
		end

	sequential_index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL signature (System.Double, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"sequential_index_of"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"____class_name"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"array_count"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_DOUBLE; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_DOUBLE) is
		external
			"IL signature (SPECIAL_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"set_area"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"operating_environment"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_DOUBLE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_DOUBLE, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"subcopy"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_DOUBLE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"same_type"
		end

	replace (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"replace"
		end

	sequential_search (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_DOUBLE; a: ARRAY_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, ARRAY_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"do_if"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_DOUBLE is
		external
			"IL signature (): LINEAR_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_DOUBLE): DOUBLE is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$first"
		end

	has (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"has"
		end

	put_left (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_DOUBLE; n: INTEGER): ARRAYED_LIST_DOUBLE is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): ARRAYED_LIST_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$duplicate"
		end

	sequence_put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"sequence_put"
		end

	prune (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_DOUBLE): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): CURSOR use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"writable"
		end

	is_inserted (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"is_inserted"
		end

	force_double_int32 (v: DOUBLE; i: INTEGER) is
		external
			"IL signature (System.Double, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"force_i_th"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_DOUBLE; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, CURSOR): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_DOUBLE): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_DOUBLE) is
		external
			"IL signature (ARRAY_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_DOUBLE; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$make_filled"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"_set_lower"
		end

	bag_put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"bag_put"
		end

	enter (v: DOUBLE; i: INTEGER) is
		external
			"IL signature (System.Double, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_DOUBLE): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_DOUBLE; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$set_count"
		end

	sequential_has (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_DOUBLE) is
		external
			"IL signature (DYNAMIC_CHAIN_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"tagged_out"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_DOUBLE is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_DOUBLE): ARRAYED_LIST_DOUBLE is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): ARRAYED_LIST_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"start"
		end

	insert (v: DOUBLE; pos: INTEGER) is
		external
			"IL signature (System.Double, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_DOUBLE) is
		external
			"IL signature (CONTAINER_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"fill"
		end

	item_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"item"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_DOUBLE is
		external
			"IL signature (): DYNAMIC_CHAIN_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"new_chain"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_DOUBLE) is
		external
			"IL signature (SPECIAL_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"count"
		end

	infix "@"_int32 (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"prunable"
		end

	prune_all (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"prune_all"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_DOUBLE is
		external
			"IL signature (System.Int32): CHAIN_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"duplicate"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_DOUBLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$valid_index"
		end

	put_front (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"go_i_th"
		end

	area: SPECIAL_DOUBLE is
		external
			"IL signature (): SPECIAL_DOUBLE use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_DOUBLE): DOUBLE is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"empty_area"
		end

	item_int322 (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"i_th"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"array_valid_index"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"make_area"
		end

	force (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"chain_wipe_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_DOUBLE) is
		external
			"IL signature (DYNAMIC_CHAIN_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_DOUBLE; other: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$merge_right"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"set_count"
		end

	same_items (other: ARRAY_DOUBLE): BOOLEAN is
		external
			"IL signature (ARRAY_DOUBLE): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"deep_equal"
		end

	put_right (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"put_right"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_DOUBLE): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"make"
		end

	search (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_DOUBLE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_DOUBLE; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"GetHashCode"
		end

	index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL signature (System.Double, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"there_exists"
		end

	put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"resizable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"before"
		end

	extend (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$remove_right"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"finish"
		end

	put_double_int322 (v: DOUBLE; i: INTEGER) is
		external
			"IL signature (System.Double, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"put_i_th"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"index_set"
		end

	sequential_occurrences (v: DOUBLE): INTEGER is
		external
			"IL signature (System.Double): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"sequential_occurrences"
		end

	entry (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"entry"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_DOUBLE): DOUBLE is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"print"
		end

	last: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_DOUBLE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [DOUBLE] is
		external
			"IL signature (): System.Double[] use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"copy"
		end

	first: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_DOUBLE): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_DOUBLE; other: ARRAYED_LIST_DOUBLE) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, ARRAYED_LIST_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_DOUBLE) is
		external
			"IL signature (SEQUENCE_DOUBLE): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_DOUBLE; v: DOUBLE; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_DOUBLE, System.Double, System.Int32): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_DOUBLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_DOUBLE

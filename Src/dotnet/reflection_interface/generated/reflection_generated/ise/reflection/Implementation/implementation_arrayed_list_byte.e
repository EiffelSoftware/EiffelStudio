indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_BYTE"

external class
	IMPLEMENTATION_ARRAYED_LIST_BYTE

inherit
	SEQUENCE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			index as index_int32,
			count as count_int32
		end
	ARRAYED_LIST_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			make as array_make
		end
	CURSOR_STRUCTURE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
	DYNAMIC_CHAIN_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	CONTAINER_BYTE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_BYTE
		rename
			item as item_byte
		end
	CHAIN_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	ARRAY_BYTE
		rename
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			item as item_int322,
			force as force_byte_int32,
			make as array_make
		end
	LIST_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	TABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	BILINEAR_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			index as index_int32
		end
	BAG_BYTE
		rename
			occurrences as occurrences_byte
		end
	ACTIVE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
	BOUNDED_BYTE
		rename
			count as count_int32
		end
	FINITE_BYTE
		rename
			count as count_int32
		end
	COLLECTION_BYTE
	TO_SPECIAL_BYTE
		rename
			infix "@" as infix "@"_int32,
			put as put_byte_int322,
			valid_index as array_valid_index,
			item as item_int322
		end
	BOX_BYTE
	UNBOUNDED_BYTE
		rename
			count as count_int32
		end
	RESIZABLE_BYTE
		rename
			count as count_int32
		end
	DYNAMIC_LIST_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	INDEXABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			infix "@" as infix "@"_int32,
			put_byte_int32 as put_byte_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	LINEAR_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte,
			index as index_int32
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_BYTE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_BYTE is
		external
			"IL field signature :SPECIAL_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$back"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"object_comparison"
		end

	sequential_index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"sequential_index_of"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_BYTE"
		alias
			"____class_name"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"array_count"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_BYTE; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_BYTE) is
		external
			"IL signature (SPECIAL_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"set_area"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_BYTE"
		alias
			"operating_environment"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_BYTE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_BYTE, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"subcopy"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_BYTE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"same_type"
		end

	item_byte: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"item"
		end

	replace (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"replace"
		end

	sequential_search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_BYTE; a: ARRAY_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, ARRAY_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"do_if"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_BYTE"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_BYTE"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_BYTE is
		external
			"IL signature (): LINEAR_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_BYTE): INTEGER_8 is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$first"
		end

	has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"has"
		end

	put_left (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_BYTE; n: INTEGER): ARRAYED_LIST_BYTE is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): ARRAYED_LIST_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$duplicate"
		end

	sequence_put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"sequence_put"
		end

	prune (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_BYTE): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_BYTE): CURSOR use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"writable"
		end

	is_inserted (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_BYTE; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, CURSOR): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_BYTE): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_BYTE) is
		external
			"IL signature (ARRAY_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_BYTE; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$make_filled"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_BYTE"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_BYTE"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"_set_lower"
		end

	bag_put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"bag_put"
		end

	enter (v: INTEGER_8; i: INTEGER) is
		external
			"IL signature (System.Byte, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$prune"
		end

	prune_all (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_BYTE): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_BYTE; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$set_count"
		end

	sequential_has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_BYTE) is
		external
			"IL signature (DYNAMIC_CHAIN_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BYTE"
		alias
			"tagged_out"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_BYTE is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_BYTE): ARRAYED_LIST_BYTE is
		external
			"IL static signature (ARRAYED_LIST_BYTE): ARRAYED_LIST_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"start"
		end

	insert (v: INTEGER_8; pos: INTEGER) is
		external
			"IL signature (System.Byte, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_BYTE) is
		external
			"IL signature (CONTAINER_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_BYTE; v: INTEGER_8): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_BYTE is
		external
			"IL signature (): DYNAMIC_CHAIN_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"new_chain"
		end

	put_byte_int322 (v: INTEGER_8; i: INTEGER) is
		external
			"IL signature (System.Byte, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"put_i_th"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_BYTE) is
		external
			"IL signature (SPECIAL_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"count"
		end

	infix "@"_int32 (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"prunable"
		end

	occurrences_byte (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"occurrences"
		end

	force_byte_int32 (v: INTEGER_8; i: INTEGER) is
		external
			"IL signature (System.Byte, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"force_i_th"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_BYTE"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_BYTE is
		external
			"IL signature (System.Int32): CHAIN_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"duplicate"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_BYTE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$valid_index"
		end

	put_front (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_BYTE"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_BYTE"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"go_i_th"
		end

	area: SPECIAL_BYTE is
		external
			"IL signature (): SPECIAL_BYTE use Implementation.ARRAYED_LIST_BYTE"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_BYTE): INTEGER_8 is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"empty_area"
		end

	item_int322 (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"i_th"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"array_valid_index"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BYTE"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"make_area"
		end

	force (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"chain_wipe_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_BYTE"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_BYTE) is
		external
			"IL signature (DYNAMIC_CHAIN_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_BYTE; v: INTEGER_8) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_BYTE; other: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$merge_right"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"set_count"
		end

	same_items (other: ARRAY_BYTE): BOOLEAN is
		external
			"IL signature (ARRAY_BYTE): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"deep_equal"
		end

	put_right (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"put_right"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_BYTE): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_BYTE): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"make"
		end

	search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_BYTE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_BYTE; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BYTE, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_BYTE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"GetHashCode"
		end

	index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"there_exists"
		end

	put (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"resizable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"before"
		end

	extend (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$remove_right"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_BYTE"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BYTE"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"finish"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_BYTE"
		alias
			"index_set"
		end

	sequential_occurrences (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"sequential_occurrences"
		end

	entry (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"entry"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BYTE"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_BYTE): INTEGER_8 is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_BYTE"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"print"
		end

	last: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_BYTE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use Implementation.ARRAYED_LIST_BYTE"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"copy"
		end

	first: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.ARRAYED_LIST_BYTE"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_BYTE): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BYTE): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_BYTE; other: ARRAYED_LIST_BYTE) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, ARRAYED_LIST_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_BYTE) is
		external
			"IL signature (SEQUENCE_BYTE): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_BYTE; v: INTEGER_8; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BYTE, System.Byte, System.Int32): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BYTE"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_BYTE"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BYTE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_BYTE

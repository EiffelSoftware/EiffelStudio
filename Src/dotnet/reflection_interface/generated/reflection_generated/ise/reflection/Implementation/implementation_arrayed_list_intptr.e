indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_INTPTR"

external class
	IMPLEMENTATION_ARRAYED_LIST_INTPTR

inherit
	TO_SPECIAL_INTPTR
		rename
			infix "@" as infix "@"_int32,
			put as put_int_ptr_int322,
			valid_index as array_valid_index,
			item as item_int322
		end
	DYNAMIC_LIST_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	RESIZABLE_INTPTR
		rename
			count as count_int32
		end
	ACTIVE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end
	INDEXABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	CURSOR_STRUCTURE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end
	BOUNDED_INTPTR
		rename
			count as count_int32
		end
	ARRAY_INTPTR
		rename
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			item as item_int322,
			force as force_int_ptr_int32,
			make as array_make
		end
	BAG_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	BOX_INTPTR
	CONTAINER_INTPTR
	TABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	UNBOUNDED_INTPTR
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
	BILINEAR_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			index as index_int32
		end
	DYNAMIC_CHAIN_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	ARRAYED_LIST_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			make as array_make
		end
	SEQUENCE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			index as index_int32,
			count as count_int32
		end
	FINITE_INTPTR
		rename
			count as count_int32
		end
	LIST_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	LINEAR_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			index as index_int32
		end
	COLLECTION_INTPTR
	CHAIN_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int_ptr_int32 as put_int_ptr_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	TRAVERSABLE_INTPTR
		rename
			item as item_int_ptr
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_INTPTR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_INTPTR is
		external
			"IL field signature :SPECIAL_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$back"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"object_comparison"
		end

	sequential_index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.IntPtr, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"sequential_index_of"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"____class_name"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"array_count"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_INTPTR; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_INTPTR) is
		external
			"IL signature (SPECIAL_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"set_area"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"operating_environment"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_INTPTR; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_INTPTR, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"subcopy"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_INTPTR; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"same_type"
		end

	replace (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"replace"
		end

	sequential_search (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_INTPTR; a: ARRAY_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, ARRAY_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"do_if"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_INTPTR is
		external
			"IL signature (): LINEAR_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_INTPTR): POINTER is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$first"
		end

	has (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"has"
		end

	put_left (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_INTPTR; n: INTEGER): ARRAYED_LIST_INTPTR is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): ARRAYED_LIST_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$duplicate"
		end

	sequence_put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"sequence_put"
		end

	prune (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"prune"
		end

	force_int_ptr_int32 (v: POINTER; i: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"force_i_th"
		end

	occurrences_int_ptr (v: POINTER): INTEGER is
		external
			"IL signature (System.IntPtr): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_INTPTR): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): CURSOR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"writable"
		end

	is_inserted (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_INTPTR; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, CURSOR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_INTPTR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_INTPTR) is
		external
			"IL signature (ARRAY_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_INTPTR; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$make_filled"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"_set_lower"
		end

	bag_put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"bag_put"
		end

	enter (v: POINTER; i: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_INTPTR): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_INTPTR; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$set_count"
		end

	sequential_has (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_INTPTR) is
		external
			"IL signature (DYNAMIC_CHAIN_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"tagged_out"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_INTPTR is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_INTPTR): ARRAYED_LIST_INTPTR is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): ARRAYED_LIST_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"start"
		end

	insert (v: POINTER; pos: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_INTPTR) is
		external
			"IL signature (CONTAINER_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_INTPTR; v: POINTER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_INTPTR is
		external
			"IL signature (): DYNAMIC_CHAIN_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"new_chain"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_INTPTR) is
		external
			"IL signature (SPECIAL_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"count"
		end

	infix "@"_int32 (i: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"prunable"
		end

	prune_all (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"prune_all"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_INTPTR is
		external
			"IL signature (System.Int32): CHAIN_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"duplicate"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_INTPTR; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$valid_index"
		end

	put_front (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"go_i_th"
		end

	area: SPECIAL_INTPTR is
		external
			"IL signature (): SPECIAL_INTPTR use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_INTPTR): POINTER is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"empty_area"
		end

	item_int322 (i: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"i_th"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"array_valid_index"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"make_area"
		end

	force (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"chain_wipe_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_INTPTR) is
		external
			"IL signature (DYNAMIC_CHAIN_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_INTPTR; v: POINTER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_INTPTR; other: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$merge_right"
		end

	put_int_ptr_int322 (v: POINTER; i: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"put_i_th"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"set_count"
		end

	same_items (other: ARRAY_INTPTR): BOOLEAN is
		external
			"IL signature (ARRAY_INTPTR): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"deep_equal"
		end

	put_right (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"put_right"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_INTPTR): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"make"
		end

	search (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"for_all"
		end

	item_int_ptr: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"item"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_INTPTR; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_INTPTR; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"GetHashCode"
		end

	index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.IntPtr, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"there_exists"
		end

	put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"resizable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"before"
		end

	extend (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$remove_right"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"finish"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"index_set"
		end

	sequential_occurrences (v: POINTER): INTEGER is
		external
			"IL signature (System.IntPtr): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"sequential_occurrences"
		end

	entry (i: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"entry"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_INTPTR): POINTER is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"print"
		end

	last: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_INTPTR; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [POINTER] is
		external
			"IL signature (): System.IntPtr[] use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"copy"
		end

	first: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_INTPTR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INTPTR): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_INTPTR; other: ARRAYED_LIST_INTPTR) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, ARRAYED_LIST_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_INTPTR) is
		external
			"IL signature (SEQUENCE_INTPTR): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_INTPTR; v: POINTER; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INTPTR, System.IntPtr, System.Int32): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INTPTR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_INTPTR

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAY_CHAR"

external class
	IMPLEMENTATION_ARRAY_CHAR

inherit
	RESIZABLE_CHAR
	BOX_CHAR
	CONTAINER_CHAR
	ARRAY_CHAR
		rename
			valid_key as valid_index,
			put_char_int32 as put_char_int322,
			infix "@" as infix "@"_int32,
			item as item_int32,
			put as bag_put
		end
	TABLE_CHAR_INT32
		rename
			valid_key as valid_index,
			put_char_int32 as put_char_int322,
			infix "@" as infix "@"_int32,
			item as item_int32,
			put as bag_put
		end
	TO_SPECIAL_CHAR
		rename
			put as put_char_int322,
			infix "@" as infix "@"_int32,
			item as item_int32
		end
	BOUNDED_CHAR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	FINITE_CHAR
	INDEXABLE_CHAR_INT32
		rename
			valid_key as valid_index,
			put_char_int32 as put_char_int322,
			infix "@" as infix "@"_int32,
			item as item_int32,
			put as bag_put
		end
	BAG_CHAR
		rename
			put as bag_put
		end
	COLLECTION_CHAR
		rename
			put as bag_put
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.ARRAY_CHAR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_CHAR is
		external
			"IL field signature :SPECIAL_CHAR use Implementation.ARRAY_CHAR"
		alias
			"$$area"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAY_CHAR"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAY_CHAR"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"default_create"
		end

	same_items (other: ARRAY_CHAR): BOOLEAN is
		external
			"IL signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"same_items"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_CHAR is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_CHAR use Implementation.ARRAY_CHAR"
		alias
			"subarray"
		end

	subcopy (other: ARRAY_CHAR; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_CHAR, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"subcopy"
		end

	frozen ec_illegal_36_ec_illegal_36_auto_resize (current_: ARRAY_CHAR; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$auto_resize"
		end

	infix "@"_int32 (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.ARRAY_CHAR"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$prunable"
		end

	item_int32 (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.ARRAY_CHAR"
		alias
			"item"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"minimal_increase"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: ARRAY_CHAR; other: ARRAY_CHAR) is
		external
			"IL static signature (ARRAY_CHAR, ARRAY_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$copy"
		end

	occurrences (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"occurrences"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"deep_equal"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_CHAR"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_CHAR"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: ARRAY_CHAR): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAY_CHAR): INTEGER_INTERVAL use Implementation.ARRAY_CHAR"
		alias
			"$$index_set"
		end

	make_from_array (a: ARRAY_CHAR) is
		external
			"IL signature (ARRAY_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_discard_items (current_: ARRAY_CHAR) is
		external
			"IL static signature (ARRAY_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$discard_items"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"make"
		end

	bag_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAY_CHAR"
		alias
			"bag_put"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"resize"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAY_CHAR; v: CHARACTER; i: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, System.Char, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$force"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_CHAR"
		alias
			"out"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAY_CHAR; i: INTEGER): CHARACTER is
		external
			"IL static signature (ARRAY_CHAR, System.Int32): System.Char use Implementation.ARRAY_CHAR"
		alias
			"$$item"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAY_CHAR"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$extendible"
		end

	put_char_int322 (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"put"
		end

	a_set_area (area2: SPECIAL_CHAR) is
		external
			"IL signature (SPECIAL_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"_set_area"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAY_CHAR; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_empty_area (current_: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$empty_area"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"valid_index_set"
		end

	entry (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.ARRAY_CHAR"
		alias
			"entry"
		end

	to_cil: NATIVE_ARRAY [CHARACTER] is
		external
			"IL signature (): System.Char[] use Implementation.ARRAY_CHAR"
		alias
			"to_cil"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAY_CHAR; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR, System.Int32): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$valid_index"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_same_items (current_: ARRAY_CHAR; other: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR, ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$same_items"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAY_CHAR"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_all_cleared (current_: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$all_cleared"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"compare_objects"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"resizable"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"all_default"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"empty"
		end

	force (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"force"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"automatic_grow"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_CHAR"
		alias
			"tagged_out"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"all_cleared"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAY_CHAR"
		alias
			"default"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"changeable_comparison_criterion"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"clear_all"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_to_cil (current_: ARRAY_CHAR): NATIVE_ARRAY [CHARACTER] is
		external
			"IL static signature (ARRAY_CHAR): System.Char[] use Implementation.ARRAY_CHAR"
		alias
			"$$to_cil"
		end

	frozen ec_illegal_36_ec_illegal_36_resize (current_: ARRAY_CHAR; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$resize"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAY_CHAR"
		alias
			"index_set"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: ARRAY_CHAR; other: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR, ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$is_equal"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"is_empty"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAY_CHAR"
		alias
			"prune_all"
		end

	area: SPECIAL_CHAR is
		external
			"IL signature (): SPECIAL_CHAR use Implementation.ARRAY_CHAR"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_enter (current_: ARRAY_CHAR; v: CHARACTER; i: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, System.Char, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$enter"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"growth_percentage"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: ARRAY_CHAR): INTEGER is
		external
			"IL static signature (ARRAY_CHAR): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index_set (current_: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$valid_index_set"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"_set_upper"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"standard_is_equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: ARRAY_CHAR; v: CHARACTER): INTEGER is
		external
			"IL static signature (ARRAY_CHAR, System.Char): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"$$occurrences"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"empty_area"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAY_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAY_CHAR, System.Char): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$extend"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: ARRAY_CHAR; v: CHARACTER): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR, System.Char): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_subarray (current_: ARRAY_CHAR; start_pos: INTEGER; end_pos: INTEGER): ARRAY_CHAR is
		external
			"IL static signature (ARRAY_CHAR, System.Int32, System.Int32): ARRAY_CHAR use Implementation.ARRAY_CHAR"
		alias
			"$$subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_subcopy (current_: ARRAY_CHAR; other: ARRAY_CHAR; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, ARRAY_CHAR, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$subcopy"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAY_CHAR; v: CHARACTER) is
		external
			"IL static signature (ARRAY_CHAR, System.Char): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$prune"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.ARRAY_CHAR"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAY_CHAR"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAY_CHAR) is
		external
			"IL static signature (ARRAY_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$wipe_out"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"compare_references"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"full"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_CHAR"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAY_CHAR; a: ARRAY_CHAR) is
		external
			"IL static signature (ARRAY_CHAR, ARRAY_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$make_from_array"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"valid_index"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"equal"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"upper"
		end

	extend (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.ARRAY_CHAR"
		alias
			"extend"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAY_CHAR"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"standard_equal"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"_set_lower"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAY_CHAR"
		alias
			"ToString"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"prunable"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAY_CHAR"
		alias
			"to_c"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$full"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_CHAR"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_to_c (current_: ARRAY_CHAR): ANY is
		external
			"IL static signature (ARRAY_CHAR): ANY use Implementation.ARRAY_CHAR"
		alias
			"$$to_c"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"lower"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"grow"
		end

	frozen ec_illegal_36_ec_illegal_36_entry (current_: ARRAY_CHAR; i: INTEGER): CHARACTER is
		external
			"IL static signature (ARRAY_CHAR, System.Int32): System.Char use Implementation.ARRAY_CHAR"
		alias
			"$$entry"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: ARRAY_CHAR; i: INTEGER): CHARACTER is
		external
			"IL static signature (ARRAY_CHAR, System.Int32): System.Char use Implementation.ARRAY_CHAR"
		alias
			"$$infix "@""
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"additional_space"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_all_default (current_: ARRAY_CHAR): BOOLEAN is
		external
			"IL static signature (ARRAY_CHAR): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"$$all_default"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.ARRAY_CHAR"
		alias
			"has"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: ARRAY_CHAR): LINEAR_CHAR is
		external
			"IL static signature (ARRAY_CHAR): LINEAR_CHAR use Implementation.ARRAY_CHAR"
		alias
			"$$linear_representation"
		end

	set_area (other: SPECIAL_CHAR) is
		external
			"IL signature (SPECIAL_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"set_area"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAY_CHAR"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: ARRAY_CHAR) is
		external
			"IL static signature (ARRAY_CHAR): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$clear_all"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: ARRAY_CHAR; v: CHARACTER; i: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, System.Char, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAY_CHAR"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_CHAR"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAY_CHAR"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_CHAR"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAY_CHAR"
		alias
			"_set_object_comparison"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"make_area"
		end

	frozen ec_illegal_36_ec_illegal_36_capacity (current_: ARRAY_CHAR): INTEGER is
		external
			"IL static signature (ARRAY_CHAR): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"$$capacity"
		end

	enter (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"enter"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"wipe_out"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_CHAR"
		alias
			"count"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_CHAR"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_grow (current_: ARRAY_CHAR; i: INTEGER) is
		external
			"IL static signature (ARRAY_CHAR, System.Int32): System.Void use Implementation.ARRAY_CHAR"
		alias
			"$$grow"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAY_CHAR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAY_CHAR

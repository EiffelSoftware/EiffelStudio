indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.STRING"

external class
	IMPLEMENTATION_STRING

inherit
	RESIZABLE_CHAR
	BOX_CHAR
	CONTAINER_CHAR
	TABLE_CHAR_INT32
		rename
			put as bag_put,
			valid_key as valid_index
		end
	STRING
		rename
			put as bag_put,
			valid_key as valid_index
		end
	HASHABLE
	BOUNDED_CHAR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	BAG_CHAR
		rename
			put as bag_put
		end
	INDEXABLE_CHAR_INT32
		rename
			put as bag_put,
			valid_key as valid_index
		end
	COMPARABLE
	FINITE_CHAR
	PART_COMPARABLE
	COLLECTION_CHAR
		rename
			put as bag_put
		end
	STRING_HANDLER

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.STRING"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_internal_string_builder: STRING_BUILDER is
		external
			"IL field signature :System.Text.StringBuilder use Implementation.STRING"
		alias
			"$$internal_string_builder"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.STRING"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	left_justify is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"left_justify"
		end

	substring (n1: INTEGER; n2: INTEGER): STRING is
		external
			"IL signature (System.Int32, System.Int32): STRING use Implementation.STRING"
		alias
			"substring"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: STRING): INTEGER is
		external
			"IL static signature (STRING): System.Int32 use Implementation.STRING"
		alias
			"$$count"
		end

	make_empty is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"make_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_blank (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$replace_blank"
		end

	last_index_of (c: CHARACTER; start_index_from_end: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"last_index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_shared_with (current_: STRING; other: STRING): BOOLEAN is
		external
			"IL static signature (STRING, STRING): System.Boolean use Implementation.STRING"
		alias
			"$$shared_with"
		end

	make_filled (c: CHARACTER; n: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.STRING"
		alias
			"make_filled"
		end

	infix "<=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.STRING"
		alias
			"infix "<=""
		end

	to_real: REAL is
		external
			"IL signature (): System.Single use Implementation.STRING"
		alias
			"to_real"
		end

	frozen ec_illegal_36_ec_illegal_36_center_justify (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$center_justify"
		end

	to_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"to_boolean"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"object_comparison"
		end

	to_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"to_integer"
		end

	internal_string_builder: STRING_BUILDER is
		external
			"IL signature (): System.Text.StringBuilder use Implementation.STRING"
		alias
			"internal_string_builder"
		end

	prepend_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"prepend_character"
		end

	replace_substring (s: STRING; start_pos: INTEGER; end_pos: INTEGER) is
		external
			"IL signature (STRING, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"replace_substring"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"additional_space"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"changeable_comparison_criterion"
		end

	frozen ec_illegal_36_ec_illegal_36_fuzzy_index (current_: STRING; other: STRING; start: INTEGER; fuzz: INTEGER): INTEGER is
		external
			"IL static signature (STRING, STRING, System.Int32, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"$$fuzzy_index"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.STRING"
		alias
			"____class_name"
		end

	replace_blank is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"replace_blank"
		end

	precede (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"precede"
		end

	three_way_comparison (other: COMPARABLE): INTEGER is
		external
			"IL signature (COMPARABLE): System.Int32 use Implementation.STRING"
		alias
			"three_way_comparison"
		end

	share (other: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STRING"
		alias
			"share"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STRING"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.STRING"
		alias
			"standard_equal"
		end

	set (t: STRING; n1: INTEGER; n2: INTEGER) is
		external
			"IL signature (STRING, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"set"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.STRING"
		alias
			"operating_environment"
		end

	append_integer (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"append_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_right_adjust (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$right_adjust"
		end

	frozen ec_illegal_36_ec_illegal_36_append_integer (current_: STRING; i: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$append_integer"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.STRING"
		alias
			"linear_representation"
		end

	tail (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"tail"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STRING"
		alias
			"same_type"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.STRING"
		alias
			"out"
		end

	make_from_c (c_string: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.STRING"
		alias
			"make_from_c"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"growth_percentage"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: STRING; i: INTEGER): CHARACTER is
		external
			"IL static signature (STRING, System.Int32): System.Char use Implementation.STRING"
		alias
			"$$item"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_cil (current_: STRING; s: SYSTEM_STRING) is
		external
			"IL static signature (STRING, System.String): System.Void use Implementation.STRING"
		alias
			"$$make_from_cil"
		end

	frozen ec_illegal_36_ec_illegal_36_substring_index (current_: STRING; other: STRING; start: INTEGER): INTEGER is
		external
			"IL static signature (STRING, STRING, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"$$substring_index"
		end

	item_code (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.STRING"
		alias
			"item_code"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: STRING): INTEGER_INTERVAL is
		external
			"IL static signature (STRING): INTEGER_INTERVAL use Implementation.STRING"
		alias
			"$$index_set"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.STRING"
		alias
			"io"
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"hash_code"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_substring_all (current_: STRING; original: STRING; new: STRING) is
		external
			"IL static signature (STRING, STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$replace_substring_all"
		end

	frozen ec_illegal_36_ec_illegal_36_fill_character (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$fill_character"
		end

	append_boolean (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.STRING"
		alias
			"append_boolean"
		end

	make_from_cil (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Implementation.STRING"
		alias
			"make_from_cil"
		end

	append_real (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.STRING"
		alias
			"append_real"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: STRING; c: CHARACTER): BOOLEAN is
		external
			"IL static signature (STRING, System.Char): System.Boolean use Implementation.STRING"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_to_lower (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$to_lower"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STRING"
		alias
			"standard_is_equal"
		end

	infix "<" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.STRING"
		alias
			"infix "<""
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_true_constant (current_: STRING): STRING is
		external
			"IL static signature (STRING): STRING use Implementation.STRING"
		alias
			"$$true_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_to_c (current_: STRING): ANY is
		external
			"IL static signature (STRING): ANY use Implementation.STRING"
		alias
			"$$to_c"
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: STRING): STRING is
		external
			"IL static signature (STRING): STRING use Implementation.STRING"
		alias
			"$$out"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.STRING"
		alias
			"has"
		end

	prepend_real (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.STRING"
		alias
			"prepend_real"
		end

	to_lower is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"to_lower"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.STRING"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_string (current_: STRING; s: STRING) is
		external
			"IL static signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$make_from_string"
		end

	frozen ec_illegal_36_ec_illegal_36_prepend_integer (current_: STRING; i: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$prepend_integer"
		end

	true_constant: STRING is
		external
			"IL signature (): STRING use Implementation.STRING"
		alias
			"true_constant"
		end

	prepend_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STRING"
		alias
			"prepend_string"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"prune"
		end

	min (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.STRING"
		alias
			"min"
		end

	make_from_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STRING"
		alias
			"make_from_string"
		end

	make_from_special (arr: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use Implementation.STRING"
		alias
			"make_from_special"
		end

	prepend_double (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.STRING"
		alias
			"prepend_double"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"grow"
		end

	frozen ec_illegal_36_ec_illegal_36_left_adjust (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$left_adjust"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.STRING"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_to_cil (current_: STRING): SYSTEM_STRING is
		external
			"IL static signature (STRING): System.String use Implementation.STRING"
		alias
			"$$to_cil"
		end

	frozen ec_illegal_36_ec_illegal_36_item_code (current_: STRING; i: INTEGER): INTEGER is
		external
			"IL static signature (STRING, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"$$item_code"
		end

	frozen ec_illegal_36_ec_illegal_36_substring (current_: STRING; n1: INTEGER; n2: INTEGER): STRING is
		external
			"IL static signature (STRING, System.Int32, System.Int32): STRING use Implementation.STRING"
		alias
			"$$substring"
		end

	frozen ec_illegal_36_ec_illegal_36_to_real (current_: STRING): REAL is
		external
			"IL static signature (STRING): System.Single use Implementation.STRING"
		alias
			"$$to_real"
		end

	shared_with (other: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"shared_with"
		end

	frozen ec_illegal_36_ec_illegal_36_to_integer (current_: STRING): INTEGER is
		external
			"IL static signature (STRING): System.Int32 use Implementation.STRING"
		alias
			"$$to_integer"
		end

	infix ">" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.STRING"
		alias
			"infix ">""
		end

	split (a_separator: CHARACTER): LIST_ANY is
		external
			"IL signature (System.Char): LIST_ANY use Implementation.STRING"
		alias
			"split"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: STRING; c: CHARACTER; n: INTEGER) is
		external
			"IL static signature (STRING, System.Char, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$make_filled"
		end

	put_char_int32 (v: CHARACTER; k: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.STRING"
		alias
			"put"
		end

	frozen ec_illegal_36_ec_illegal_36_to_double (current_: STRING): DOUBLE is
		external
			"IL static signature (STRING): System.Double use Implementation.STRING"
		alias
			"$$to_double"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.STRING"
		alias
			"default_pointer"
		end

	is_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"is_boolean"
		end

	false_constant: STRING is
		external
			"IL signature (): STRING use Implementation.STRING"
		alias
			"false_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_remake (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$remake"
		end

	frozen ec_illegal_36_ec_illegal_36_tail (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$tail"
		end

	frozen ec_illegal_36_ec_illegal_36_precede (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$precede"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"default_rescue"
		end

	multiply (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"multiply"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_character (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$replace_character"
		end

	frozen ec_illegal_36_ec_illegal_36_prepend_character (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$prepend_character"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: STRING; number: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$set_count"
		end

	frozen ec_illegal_36_ec_illegal_36_share (current_: STRING; other: STRING) is
		external
			"IL static signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$share"
		end

	frozen ec_illegal_36_ec_illegal_36_prepend_real (current_: STRING; r: REAL) is
		external
			"IL static signature (STRING, System.Single): System.Void use Implementation.STRING"
		alias
			"$$prepend_real"
		end

	is_integer: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"is_integer"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.STRING"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_insert_string (current_: STRING; s: STRING; i: INTEGER) is
		external
			"IL static signature (STRING, STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$insert_string"
		end

	frozen ec_illegal_36_ec_illegal_36_adapt (current_: STRING; s: STRING): STRING is
		external
			"IL static signature (STRING, STRING): STRING use Implementation.STRING"
		alias
			"$$adapt"
		end

	frozen ec_illegal_34__in_ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ (current_: STRING; s: STRING): STRING is
		external
			"IL static signature (STRING, STRING): STRING use Implementation.STRING"
		alias
			"$$infix "+""
		end

	keep_head (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"keep_head"
		end

	frozen ec_illegal_36_ec_illegal_36_append_boolean (current_: STRING; b: BOOLEAN) is
		external
			"IL static signature (STRING, System.Boolean): System.Void use Implementation.STRING"
		alias
			"$$append_boolean"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$prune"
		end

	to_upper is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"to_upper"
		end

	remove_head (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"remove_head"
		end

	make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"make"
		end

	frozen ec_illegal_36_ec_illegal_36_character_justify (current_: STRING; pivot: CHARACTER; position: INTEGER) is
		external
			"IL static signature (STRING, System.Char, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$character_justify"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all_leading (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$prune_all_leading"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_tail (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$remove_tail"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_c (current_: STRING; c_string: POINTER) is
		external
			"IL static signature (STRING, System.IntPtr): System.Void use Implementation.STRING"
		alias
			"$$make_from_c"
		end

	frozen ec_illegal_36_ec_illegal_36_make_empty (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$make_empty"
		end

	insert_string (s: STRING; i: INTEGER) is
		external
			"IL signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"insert_string"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.STRING"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_hash_code (current_: STRING): INTEGER is
		external
			"IL static signature (STRING): System.Int32 use Implementation.STRING"
		alias
			"$$hash_code"
		end

	frozen ec_illegal_36_ec_illegal_36_from_c (current_: STRING; c_string: POINTER) is
		external
			"IL static signature (STRING, System.IntPtr): System.Void use Implementation.STRING"
		alias
			"$$from_c"
		end

	replace_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"replace_character"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: STRING; i: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$make"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.STRING"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STRING"
		alias
			"deep_copy"
		end

	prepend (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STRING"
		alias
			"prepend"
		end

	frozen ec_illegal_36_ec_illegal_36_changeable_comparison_criterion (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$changeable_comparison_criterion"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"wipe_out"
		end

	frozen ec_illegal_36_ec_illegal_36_append (current_: STRING; s: STRING) is
		external
			"IL static signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$append"
		end

	frozen ec_illegal_36_ec_illegal_36_append_real (current_: STRING; r: REAL) is
		external
			"IL static signature (STRING, System.Single): System.Void use Implementation.STRING"
		alias
			"$$append_real"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_mirror (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$mirror"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.STRING"
		alias
			"to_c"
		end

	adapt_size is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"adapt_size"
		end

	fill_blank is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"fill_blank"
		end

	frozen ec_illegal_36_ec_illegal_36_resize (current_: STRING; newsize: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$resize"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.STRING"
		alias
			"internal_clone"
		end

	keep_tail (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"keep_tail"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"do_nothing"
		end

	prepend_integer (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"prepend_integer"
		end

	character_justify (pivot: CHARACTER; position: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.STRING"
		alias
			"character_justify"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"prunable"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"prune_all"
		end

	prune_all_leading (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"prune_all_leading"
		end

	is_double: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"is_double"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.STRING"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_append_string (current_: STRING; s: STRING) is
		external
			"IL static signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$append_string"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: STRING; i: INTEGER): BOOLEAN is
		external
			"IL static signature (STRING, System.Int32): System.Boolean use Implementation.STRING"
		alias
			"$$valid_index"
		end

	center_justify is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"center_justify"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.STRING"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$extendible"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: STRING; other: STRING): BOOLEAN is
		external
			"IL static signature (STRING, STRING): System.Boolean use Implementation.STRING"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_to_boolean (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$to_boolean"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$clear_all"
		end

	ec_illegal_34__in_infix " (s: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.STRING"
		alias
			"infix "+""
		end

	frozen ec_illegal_36_ec_illegal_36_remove_head (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$remove_head"
		end

	left_adjust is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"left_adjust"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.STRING"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_append_character (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$append_character"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"compare_references"
		end

	subcopy (other: STRING; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (STRING, System.Int32, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"subcopy"
		end

	append_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STRING"
		alias
			"append_string"
		end

	prepend_boolean (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.STRING"
		alias
			"prepend_boolean"
		end

	prune_all_trailing (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"prune_all_trailing"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STRING"
		alias
			"conforms_to"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.STRING"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$prunable"
		end

	frozen ec_illegal_36_ec_illegal_36_is_boolean (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$is_boolean"
		end

	frozen ec_illegal_36_ec_illegal_36_split (current_: STRING; a_separator: CHARACTER): LIST_ANY is
		external
			"IL static signature (STRING, System.Char): LIST_ANY use Implementation.STRING"
		alias
			"$$split"
		end

	replace_substring_all (original: STRING; new: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"replace_substring_all"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all_trailing (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$prune_all_trailing"
		end

	infix "@" (k: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.STRING"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_last_index_of (current_: STRING; c: CHARACTER; start_index_from_end: INTEGER): INTEGER is
		external
			"IL static signature (STRING, System.Char, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"$$last_index_of"
		end

	to_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.STRING"
		alias
			"to_double"
		end

	frozen ec_illegal_36_ec_illegal_36_append_double (current_: STRING; d: DOUBLE) is
		external
			"IL static signature (STRING, System.Double): System.Void use Implementation.STRING"
		alias
			"$$append_double"
		end

	fill_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"fill_character"
		end

	bag_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_area (current_: STRING): SPECIAL_CHAR is
		external
			"IL static signature (STRING): SPECIAL_CHAR use Implementation.STRING"
		alias
			"$$area"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"minimal_increase"
		end

	append_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"append_character"
		end

	set_count (number: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"set_count"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$prune_all"
		end

	mirrored: STRING is
		external
			"IL signature (): STRING use Implementation.STRING"
		alias
			"mirrored"
		end

	frozen ec_illegal_36_ec_illegal_36_keep_head (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$keep_head"
		end

	frozen ec_illegal_36_ec_illegal_36_multiply (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$multiply"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.STRING"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: STRING; c: CHARACTER; start: INTEGER): INTEGER is
		external
			"IL static signature (STRING, System.Char, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"$$index_of"
		end

	substring_index (other: STRING; start: INTEGER): INTEGER is
		external
			"IL signature (STRING, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"substring_index"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STRING"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_prepend_boolean (current_: STRING; b: BOOLEAN) is
		external
			"IL static signature (STRING, System.Boolean): System.Void use Implementation.STRING"
		alias
			"$$prepend_boolean"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: STRING; c: CHARACTER; i: INTEGER) is
		external
			"IL static signature (STRING, System.Char, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$put"
		end

	remove_tail (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"remove_tail"
		end

	fuzzy_index (other: STRING; start: INTEGER; fuzz: INTEGER): INTEGER is
		external
			"IL signature (STRING, System.Int32, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"fuzzy_index"
		end

	area: SPECIAL_CHAR is
		external
			"IL signature (): SPECIAL_CHAR use Implementation.STRING"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_grow (current_: STRING; newsize: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$grow"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.STRING"
		alias
			"deep_clone"
		end

	item (k: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.STRING"
		alias
			"item"
		end

	frozen ec_illegal_36_ec_illegal_36_set (current_: STRING; t: STRING; n1: INTEGER; n2: INTEGER) is
		external
			"IL static signature (STRING, STRING, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$set"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"GetHashCode"
		end

	is_real: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"is_real"
		end

	index_of (c: CHARACTER; start: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.STRING"
		alias
			"index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_is_integer (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$is_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_substring (current_: STRING; s: STRING; start_pos: INTEGER; end_pos: INTEGER) is
		external
			"IL static signature (STRING, STRING, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$replace_substring"
		end

	max (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.STRING"
		alias
			"max"
		end

	frozen ec_illegal_36_ec_illegal_36_prepend_string (current_: STRING; s: STRING) is
		external
			"IL static signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$prepend_string"
		end

	frozen ec_illegal_36_ec_illegal_36_mirrored (current_: STRING): STRING is
		external
			"IL static signature (STRING): STRING use Implementation.STRING"
		alias
			"$$mirrored"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_special (current_: STRING; arr: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL static signature (STRING, System.Char[]): System.Void use Implementation.STRING"
		alias
			"$$make_from_special"
		end

	frozen ec_illegal_36_ec_illegal_36_right_justify (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$right_justify"
		end

	frozen ec_illegal_36_ec_illegal_36_prepend_double (current_: STRING; d: DOUBLE) is
		external
			"IL static signature (STRING, System.Double): System.Void use Implementation.STRING"
		alias
			"$$prepend_double"
		end

	frozen ec_illegal_36_ec_illegal_36_fill_blank (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$fill_blank"
		end

	infix ">=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.STRING"
		alias
			"infix ">=""
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"resizable"
		end

	remake (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"remake"
		end

	frozen ec_illegal_36_ec_illegal_36_is_real (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$is_real"
		end

	frozen ec_illegal_36_ec_illegal_36_from_cil (current_: STRING; s: SYSTEM_STRING) is
		external
			"IL static signature (STRING, System.String): System.Void use Implementation.STRING"
		alias
			"$$from_cil"
		end

	extend (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STRING"
		alias
			"extend"
		end

	insert (s: STRING; i: INTEGER) is
		external
			"IL signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"insert"
		end

	frozen ec_illegal_36_ec_illegal_36_adapt_size (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$adapt_size"
		end

	frozen ec_illegal_36_ec_illegal_36_from_c_substring (current_: STRING; c_string: POINTER; start_pos: INTEGER; end_pos: INTEGER) is
		external
			"IL static signature (STRING, System.IntPtr, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$from_c_substring"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.STRING"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.STRING"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: STRING; other: STRING) is
		external
			"IL static signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$copy"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"extendible"
		end

	from_c_substring (c_string: POINTER; start_pos: INTEGER; end_pos: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"from_c_substring"
		end

	right_justify is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"right_justify"
		end

	frozen ec_illegal_36_ec_illegal_36_keep_tail (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$keep_tail"
		end

	from_cil (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Implementation.STRING"
		alias
			"from_cil"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.STRING"
		alias
			"index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_left_justify (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$left_justify"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"is_hashable"
		end

	append_double (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.STRING"
		alias
			"append_double"
		end

	frozen ec_illegal_36_ec_illegal_36_to_upper (current_: STRING) is
		external
			"IL static signature (STRING): System.Void use Implementation.STRING"
		alias
			"$$to_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_is_double (current_: STRING): BOOLEAN is
		external
			"IL static signature (STRING): System.Boolean use Implementation.STRING"
		alias
			"$$is_double"
		end

	head (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"head"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"full"
		end

	adapt (s: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.STRING"
		alias
			"adapt"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STRING"
		alias
			"count"
		end

	resize (newsize: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.STRING"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STRING"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_subcopy (current_: STRING; other: STRING; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL static signature (STRING, STRING, System.Int32, System.Int32, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$subcopy"
		end

	remove (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STRING"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: STRING; c: CHARACTER): INTEGER is
		external
			"IL static signature (STRING, System.Char): System.Int32 use Implementation.STRING"
		alias
			"$$occurrences"
		end

	occurrences (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.STRING"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: STRING): LINEAR_CHAR is
		external
			"IL static signature (STRING): LINEAR_CHAR use Implementation.STRING"
		alias
			"$$linear_representation"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_60_ec_illegal_34_ (current_: STRING; other: STRING): BOOLEAN is
		external
			"IL static signature (STRING, STRING): System.Boolean use Implementation.STRING"
		alias
			"$$infix "<""
		end

	to_cil: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.STRING"
		alias
			"to_cil"
		end

	frozen ec_illegal_36_ec_illegal_36_capacity (current_: STRING): INTEGER is
		external
			"IL static signature (STRING): System.Int32 use Implementation.STRING"
		alias
			"$$capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: STRING; i: INTEGER): CHARACTER is
		external
			"IL static signature (STRING, System.Int32): System.Char use Implementation.STRING"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: STRING; c: CHARACTER) is
		external
			"IL static signature (STRING, System.Char): System.Void use Implementation.STRING"
		alias
			"$$extend"
		end

	from_c (c_string: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.STRING"
		alias
			"from_c"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STRING"
		alias
			"copy"
		end

	a_set_internal_string_builder (internal_string_builder2: STRING_BUILDER) is
		external
			"IL signature (System.Text.StringBuilder): System.Void use Implementation.STRING"
		alias
			"_set_internal_string_builder"
		end

	frozen ec_illegal_36_ec_illegal_36_head (current_: STRING; n: INTEGER) is
		external
			"IL static signature (STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$head"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STRING"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_prepend (current_: STRING; s: STRING) is
		external
			"IL static signature (STRING, STRING): System.Void use Implementation.STRING"
		alias
			"$$prepend"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_false_constant (current_: STRING): STRING is
		external
			"IL static signature (STRING): STRING use Implementation.STRING"
		alias
			"$$false_constant"
		end

	append (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STRING"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: STRING; s: STRING; i: INTEGER) is
		external
			"IL static signature (STRING, STRING, System.Int32): System.Void use Implementation.STRING"
		alias
			"$$insert"
		end

	mirror is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"mirror"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.STRING"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.STRING"
		alias
			"generator"
		end

	right_adjust is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"right_adjust"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.STRING"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_STRING

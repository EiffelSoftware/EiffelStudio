indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.FILE_NAME"

external class
	IMPLEMENTATION_FILE_NAME

inherit
	RESIZABLE_CHAR
	BOX_CHAR
	CONTAINER_CHAR
	BAG_CHAR
		rename
			extend as string_extend,
			put as bag_put
		end
	PATH_NAME
		rename
			extend as string_extend,
			put as bag_put,
			valid_key as valid_index,
			make_from_string as string_make_from_string,
			make as string_make
		end
	TABLE_CHAR_INT32
		rename
			extend as string_extend,
			put as bag_put,
			valid_key as valid_index
		end
	STRING
		rename
			extend as string_extend,
			put as bag_put,
			valid_key as valid_index,
			make_from_string as string_make_from_string,
			make as string_make
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
	FILE_NAME
		rename
			extend as string_extend,
			put as bag_put,
			valid_key as valid_index,
			make_from_string as string_make_from_string,
			make as string_make
		end
	INDEXABLE_CHAR_INT32
		rename
			extend as string_extend,
			put as bag_put,
			valid_key as valid_index
		end
	COMPARABLE
	FINITE_CHAR
	PART_COMPARABLE
	COLLECTION_CHAR
		rename
			extend as string_extend,
			put as bag_put
		end
	STRING_HANDLER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.FILE_NAME"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_internal_string_builder: STRING_BUILDER is
		external
			"IL field signature :System.Text.StringBuilder use Implementation.FILE_NAME"
		alias
			"$$internal_string_builder"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.FILE_NAME"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	left_justify is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"left_justify"
		end

	substring (n1: INTEGER; n2: INTEGER): STRING is
		external
			"IL signature (System.Int32, System.Int32): STRING use Implementation.FILE_NAME"
		alias
			"substring"
		end

	make_empty is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"make_empty"
		end

	last_index_of (c: CHARACTER; start_index_from_end: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.FILE_NAME"
		alias
			"last_index_of"
		end

	make_filled (c: CHARACTER; n: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"make_filled"
		end

	infix "<=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.FILE_NAME"
		alias
			"infix "<=""
		end

	to_real: REAL is
		external
			"IL signature (): System.Single use Implementation.FILE_NAME"
		alias
			"to_real"
		end

	to_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"to_boolean"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"object_comparison"
		end

	to_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"to_integer"
		end

	internal_string_builder: STRING_BUILDER is
		external
			"IL signature (): System.Text.StringBuilder use Implementation.FILE_NAME"
		alias
			"internal_string_builder"
		end

	prepend_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"prepend_character"
		end

	replace_substring (s: STRING; start_pos: INTEGER; end_pos: INTEGER) is
		external
			"IL signature (STRING, System.Int32, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"replace_substring"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"additional_space"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"changeable_comparison_criterion"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.FILE_NAME"
		alias
			"____class_name"
		end

	replace_blank is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"replace_blank"
		end

	precede (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"precede"
		end

	three_way_comparison (other: COMPARABLE): INTEGER is
		external
			"IL signature (COMPARABLE): System.Int32 use Implementation.FILE_NAME"
		alias
			"three_way_comparison"
		end

	share (other: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"share"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_equal"
		end

	set (t: STRING; n1: INTEGER; n2: INTEGER) is
		external
			"IL signature (STRING, System.Int32, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"set"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.FILE_NAME"
		alias
			"operating_environment"
		end

	is_file_name_valid (f_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_file_name_valid"
		end

	append_integer (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"append_integer"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.FILE_NAME"
		alias
			"linear_representation"
		end

	tail (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"tail"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE_NAME"
		alias
			"same_type"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.FILE_NAME"
		alias
			"out"
		end

	make_from_c (c_string: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.FILE_NAME"
		alias
			"make_from_c"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"growth_percentage"
		end

	append_boolean (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.FILE_NAME"
		alias
			"append_boolean"
		end

	item_code (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.FILE_NAME"
		alias
			"item_code"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.FILE_NAME"
		alias
			"io"
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"hash_code"
		end

	append_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"append_character"
		end

	make_from_cil (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Implementation.FILE_NAME"
		alias
			"make_from_cil"
		end

	append_real (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.FILE_NAME"
		alias
			"append_real"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE_NAME"
		alias
			"standard_is_equal"
		end

	infix "<" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.FILE_NAME"
		alias
			"infix "<""
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"compare_objects"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.FILE_NAME"
		alias
			"has"
		end

	is_directory_name_valid (dir_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_directory_name_valid"
		end

	prepend_real (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.FILE_NAME"
		alias
			"prepend_real"
		end

	to_lower is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"to_lower"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.FILE_NAME"
		alias
			"valid_index"
		end

	set_subdirectory (directory_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"set_subdirectory"
		end

	true_constant: STRING is
		external
			"IL signature (): STRING use Implementation.FILE_NAME"
		alias
			"true_constant"
		end

	prepend_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"prepend_string"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"prune"
		end

	min (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.FILE_NAME"
		alias
			"min"
		end

	frozen ec_illegal_36_ec_illegal_36_add_extension (current_: FILE_NAME; ext: STRING) is
		external
			"IL static signature (FILE_NAME, STRING): System.Void use Implementation.FILE_NAME"
		alias
			"$$add_extension"
		end

	make_from_special (arr: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use Implementation.FILE_NAME"
		alias
			"make_from_special"
		end

	prepend_double (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.FILE_NAME"
		alias
			"prepend_double"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"grow"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"automatic_grow"
		end

	set_directory (directory_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"set_directory"
		end

	shared_with (other: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.FILE_NAME"
		alias
			"shared_with"
		end

	bag_put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_is_extension_valid (current_: FILE_NAME; ext: STRING): BOOLEAN is
		external
			"IL static signature (FILE_NAME, STRING): System.Boolean use Implementation.FILE_NAME"
		alias
			"$$is_extension_valid"
		end

	infix ">" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.FILE_NAME"
		alias
			"infix ">""
		end

	split (a_separator: CHARACTER): LIST_ANY is
		external
			"IL signature (System.Char): LIST_ANY use Implementation.FILE_NAME"
		alias
			"split"
		end

	put_char_int32 (v: CHARACTER; k: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"put"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.FILE_NAME"
		alias
			"default_pointer"
		end

	is_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_boolean"
		end

	false_constant: STRING is
		external
			"IL signature (): STRING use Implementation.FILE_NAME"
		alias
			"false_constant"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"default_rescue"
		end

	multiply (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"multiply"
		end

	fuzzy_index (other: STRING; start: INTEGER; fuzz: INTEGER): INTEGER is
		external
			"IL signature (STRING, System.Int32, System.Int32): System.Int32 use Implementation.FILE_NAME"
		alias
			"fuzzy_index"
		end

	frozen ec_illegal_36_ec_illegal_36_is_file_name_valid (current_: FILE_NAME; f_name: STRING): BOOLEAN is
		external
			"IL static signature (FILE_NAME, STRING): System.Boolean use Implementation.FILE_NAME"
		alias
			"$$is_file_name_valid"
		end

	is_integer: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_integer"
		end

	string_make_from_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"string_make_from_string"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.FILE_NAME"
		alias
			"tagged_out"
		end

	keep_head (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"keep_head"
		end

	to_upper is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"to_upper"
		end

	remove_head (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"remove_head"
		end

	frozen ec_illegal_36_ec_illegal_36_make_temporary_name (current_: FILE_NAME) is
		external
			"IL static signature (FILE_NAME): System.Void use Implementation.FILE_NAME"
		alias
			"$$make_temporary_name"
		end

	set_volume (volume_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"set_volume"
		end

	insert_string (s: STRING; i: INTEGER) is
		external
			"IL signature (STRING, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"insert_string"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.FILE_NAME"
		alias
			"fill"
		end

	replace_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"replace_character"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.FILE_NAME"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE_NAME"
		alias
			"deep_copy"
		end

	prepend (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"prepend"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"wipe_out"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"capacity"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.FILE_NAME"
		alias
			"to_c"
		end

	adapt_size is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"adapt_size"
		end

	fill_blank is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"fill_blank"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.FILE_NAME"
		alias
			"internal_clone"
		end

	keep_tail (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"keep_tail"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"do_nothing"
		end

	prepend_integer (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"prepend_integer"
		end

	character_justify (pivot: CHARACTER; position: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"character_justify"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"prunable"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"prune_all"
		end

	prune_all_leading (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"prune_all_leading"
		end

	is_double: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_double"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FILE_NAME"
		alias
			"clone"
		end

	center_justify is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"center_justify"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FILE_NAME"
		alias
			"equal"
		end

	ec_illegal_34__in_infix " (s: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.FILE_NAME"
		alias
			"infix "+""
		end

	left_adjust is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"left_adjust"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.FILE_NAME"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"compare_references"
		end

	frozen ec_illegal_36_ec_illegal_36_set_file_name (current_: FILE_NAME; file_name: STRING) is
		external
			"IL static signature (FILE_NAME, STRING): System.Void use Implementation.FILE_NAME"
		alias
			"$$set_file_name"
		end

	subcopy (other: STRING; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (STRING, System.Int32, System.Int32, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"subcopy"
		end

	append_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"append_string"
		end

	prepend_boolean (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.FILE_NAME"
		alias
			"prepend_boolean"
		end

	prune_all_trailing (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"prune_all_trailing"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE_NAME"
		alias
			"conforms_to"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.FILE_NAME"
		alias
			"Equals"
		end

	make_temporary_name is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"make_temporary_name"
		end

	replace_substring_all (original: STRING; new: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.FILE_NAME"
		alias
			"replace_substring_all"
		end

	add_extension (ext: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"add_extension"
		end

	infix "@" (k: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.FILE_NAME"
		alias
			"infix "@""
		end

	to_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.FILE_NAME"
		alias
			"to_double"
		end

	set_file_name (file_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"set_file_name"
		end

	fill_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"fill_character"
		end

	is_volume_name_valid (vol_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_volume_name_valid"
		end

	make_void is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"make"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"minimal_increase"
		end

	is_extension_valid (ext: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_extension_valid"
		end

	set_count (number: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"set_count"
		end

	mirrored: STRING is
		external
			"IL signature (): STRING use Implementation.FILE_NAME"
		alias
			"mirrored"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FILE_NAME"
		alias
			"deep_equal"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"GetHashCode"
		end

	substring_index (other: STRING; start: INTEGER): INTEGER is
		external
			"IL signature (STRING, System.Int32): System.Int32 use Implementation.FILE_NAME"
		alias
			"substring_index"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE_NAME"
		alias
			"standard_copy"
		end

	make_from_string_string (p: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"make_from_string"
		end

	remove_tail (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"remove_tail"
		end

	extend_string (directory_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"extend"
		end

	area: SPECIAL_CHAR is
		external
			"IL signature (): SPECIAL_CHAR use Implementation.FILE_NAME"
		alias
			"area"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FILE_NAME"
		alias
			"deep_clone"
		end

	item (k: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.FILE_NAME"
		alias
			"item"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FILE_NAME"
		alias
			"standard_equal"
		end

	is_real: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_real"
		end

	index_of (c: CHARACTER; start: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.FILE_NAME"
		alias
			"index_of"
		end

	max (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.FILE_NAME"
		alias
			"max"
		end

	infix ">=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.FILE_NAME"
		alias
			"infix ">=""
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"resizable"
		end

	remake (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"remake"
		end

	insert (s: STRING; i: INTEGER) is
		external
			"IL signature (STRING, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"insert"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.FILE_NAME"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.FILE_NAME"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"extendible"
		end

	from_c_substring (c_string: POINTER; start_pos: INTEGER; end_pos: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32, System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"from_c_substring"
		end

	right_justify is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"right_justify"
		end

	string_make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"string_make"
		end

	from_cil (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Implementation.FILE_NAME"
		alias
			"from_cil"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.FILE_NAME"
		alias
			"index_set"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_hashable"
		end

	append_double (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.FILE_NAME"
		alias
			"append_double"
		end

	extend_from_array (directories: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.FILE_NAME"
		alias
			"extend_from_array"
		end

	head (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"head"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"full"
		end

	adapt (s: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.FILE_NAME"
		alias
			"adapt"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE_NAME"
		alias
			"count"
		end

	resize (newsize: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FILE_NAME"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE_NAME"
		alias
			"print"
		end

	remove (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE_NAME"
		alias
			"remove"
		end

	occurrences (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.FILE_NAME"
		alias
			"occurrences"
		end

	string_extend (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE_NAME"
		alias
			"string_extend"
		end

	to_cil: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.FILE_NAME"
		alias
			"to_cil"
		end

	from_c (c_string: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.FILE_NAME"
		alias
			"from_c"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE_NAME"
		alias
			"copy"
		end

	a_set_internal_string_builder (internal_string_builder2: STRING_BUILDER) is
		external
			"IL signature (System.Text.StringBuilder): System.Void use Implementation.FILE_NAME"
		alias
			"_set_internal_string_builder"
		end

	frozen ec_illegal_36_ec_illegal_36_is_valid (current_: FILE_NAME): BOOLEAN is
		external
			"IL static signature (FILE_NAME): System.Boolean use Implementation.FILE_NAME"
		alias
			"$$is_valid"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE_NAME"
		alias
			"internal_copy"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_empty"
		end

	append (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE_NAME"
		alias
			"append"
		end

	mirror is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"mirror"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.FILE_NAME"
		alias
			"generator"
		end

	right_adjust is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"right_adjust"
		end

	is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE_NAME"
		alias
			"is_valid"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.FILE_NAME"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_FILE_NAME

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAY_SINGLE"

external class
	IMPLEMENTATION_ARRAY_SINGLE

inherit
	BOX_SINGLE
	CONTAINER_SINGLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	INDEXABLE_SINGLE_INT32
		rename
			valid_key as valid_index,
			put_single_int32 as put_single_int322,
			infix "@" as infix "@"_int32,
			item as item_int32,
			put as bag_put
		end
	FINITE_SINGLE
	TABLE_SINGLE_INT32
		rename
			valid_key as valid_index,
			put_single_int32 as put_single_int322,
			infix "@" as infix "@"_int32,
			item as item_int32,
			put as bag_put
		end
	BAG_SINGLE
		rename
			put as bag_put
		end
	COLLECTION_SINGLE
		rename
			put as bag_put
		end
	ARRAY_SINGLE
		rename
			valid_key as valid_index,
			put_single_int32 as put_single_int322,
			infix "@" as infix "@"_int32,
			item as item_int32,
			put as bag_put
		end
	TO_SPECIAL_SINGLE
		rename
			put as put_single_int322,
			infix "@" as infix "@"_int32,
			item as item_int32
		end
	BOUNDED_SINGLE
	RESIZABLE_SINGLE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.ARRAY_SINGLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_SINGLE is
		external
			"IL field signature :SPECIAL_SINGLE use Implementation.ARRAY_SINGLE"
		alias
			"$$area"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAY_SINGLE"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAY_SINGLE"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"default_create"
		end

	same_items (other: ARRAY_SINGLE): BOOLEAN is
		external
			"IL signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"same_items"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_SINGLE is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_SINGLE use Implementation.ARRAY_SINGLE"
		alias
			"subarray"
		end

	subcopy (other: ARRAY_SINGLE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_SINGLE, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"subcopy"
		end

	frozen ec_illegal_36_ec_illegal_36_auto_resize (current_: ARRAY_SINGLE; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$auto_resize"
		end

	infix "@"_int32 (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.ARRAY_SINGLE"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$prunable"
		end

	item_int32 (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.ARRAY_SINGLE"
		alias
			"item"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"minimal_increase"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: ARRAY_SINGLE; other: ARRAY_SINGLE) is
		external
			"IL static signature (ARRAY_SINGLE, ARRAY_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$copy"
		end

	occurrences (v: REAL): INTEGER is
		external
			"IL signature (System.Single): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"occurrences"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"deep_equal"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_SINGLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: ARRAY_SINGLE): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAY_SINGLE): INTEGER_INTERVAL use Implementation.ARRAY_SINGLE"
		alias
			"$$index_set"
		end

	make_from_array (a: ARRAY_SINGLE) is
		external
			"IL signature (ARRAY_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_discard_items (current_: ARRAY_SINGLE) is
		external
			"IL static signature (ARRAY_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$discard_items"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"make"
		end

	bag_put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"bag_put"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"resize"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAY_SINGLE; v: REAL; i: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, System.Single, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$force"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_SINGLE"
		alias
			"out"
		end

	is_inserted (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAY_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32): System.Single use Implementation.ARRAY_SINGLE"
		alias
			"$$item"
		end

	prune (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$extendible"
		end

	a_set_area (area2: SPECIAL_SINGLE) is
		external
			"IL signature (SPECIAL_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"_set_area"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAY_SINGLE; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_empty_area (current_: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$empty_area"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"valid_index_set"
		end

	entry (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.ARRAY_SINGLE"
		alias
			"entry"
		end

	to_cil: NATIVE_ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use Implementation.ARRAY_SINGLE"
		alias
			"to_cil"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAY_SINGLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$valid_index"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_same_items (current_: ARRAY_SINGLE; other: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE, ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$same_items"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAY_SINGLE"
		alias
			"io"
		end

	prune_all (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"prune_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"compare_objects"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"resizable"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"all_default"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"empty"
		end

	force (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"force"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"automatic_grow"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_SINGLE"
		alias
			"tagged_out"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"all_cleared"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAY_SINGLE"
		alias
			"default"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"changeable_comparison_criterion"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"clear_all"
		end

	fill (other: CONTAINER_SINGLE) is
		external
			"IL signature (CONTAINER_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_to_cil (current_: ARRAY_SINGLE): NATIVE_ARRAY [REAL] is
		external
			"IL static signature (ARRAY_SINGLE): System.Single[] use Implementation.ARRAY_SINGLE"
		alias
			"$$to_cil"
		end

	frozen ec_illegal_36_ec_illegal_36_resize (current_: ARRAY_SINGLE; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$resize"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAY_SINGLE"
		alias
			"index_set"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: ARRAY_SINGLE; other: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE, ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$is_equal"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"is_empty"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"same_type"
		end

	area: SPECIAL_SINGLE is
		external
			"IL signature (): SPECIAL_SINGLE use Implementation.ARRAY_SINGLE"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_enter (current_: ARRAY_SINGLE; v: REAL; i: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, System.Single, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$enter"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"growth_percentage"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: ARRAY_SINGLE): INTEGER is
		external
			"IL static signature (ARRAY_SINGLE): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index_set (current_: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$valid_index_set"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"_set_upper"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"standard_is_equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: ARRAY_SINGLE; v: REAL): INTEGER is
		external
			"IL static signature (ARRAY_SINGLE, System.Single): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"$$occurrences"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"empty_area"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAY_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAY_SINGLE, System.Single): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$extend"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: ARRAY_SINGLE; v: REAL): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE, System.Single): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_subarray (current_: ARRAY_SINGLE; start_pos: INTEGER; end_pos: INTEGER): ARRAY_SINGLE is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32, System.Int32): ARRAY_SINGLE use Implementation.ARRAY_SINGLE"
		alias
			"$$subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_subcopy (current_: ARRAY_SINGLE; other: ARRAY_SINGLE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, ARRAY_SINGLE, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$subcopy"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAY_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAY_SINGLE, System.Single): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$prune"
		end

	linear_representation: LINEAR_SINGLE is
		external
			"IL signature (): LINEAR_SINGLE use Implementation.ARRAY_SINGLE"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAY_SINGLE"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAY_SINGLE) is
		external
			"IL static signature (ARRAY_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$wipe_out"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"compare_references"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"full"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAY_SINGLE; a: ARRAY_SINGLE) is
		external
			"IL static signature (ARRAY_SINGLE, ARRAY_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$make_from_array"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"valid_index"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"equal"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"upper"
		end

	extend (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"extend"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAY_SINGLE"
		alias
			"clone"
		end

	put_single_int322 (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"put"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"_set_lower"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAY_SINGLE"
		alias
			"ToString"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"prunable"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAY_SINGLE"
		alias
			"to_c"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$full"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_to_c (current_: ARRAY_SINGLE): ANY is
		external
			"IL static signature (ARRAY_SINGLE): ANY use Implementation.ARRAY_SINGLE"
		alias
			"$$to_c"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"lower"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"grow"
		end

	frozen ec_illegal_36_ec_illegal_36_entry (current_: ARRAY_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32): System.Single use Implementation.ARRAY_SINGLE"
		alias
			"$$entry"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: ARRAY_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32): System.Single use Implementation.ARRAY_SINGLE"
		alias
			"$$infix "@""
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"additional_space"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_all_default (current_: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$all_default"
		end

	has (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"has"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: ARRAY_SINGLE): LINEAR_SINGLE is
		external
			"IL static signature (ARRAY_SINGLE): LINEAR_SINGLE use Implementation.ARRAY_SINGLE"
		alias
			"$$linear_representation"
		end

	frozen ec_illegal_36_ec_illegal_36_all_cleared (current_: ARRAY_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAY_SINGLE"
		alias
			"$$all_cleared"
		end

	set_area (other: SPECIAL_SINGLE) is
		external
			"IL signature (SPECIAL_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"set_area"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAY_SINGLE"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: ARRAY_SINGLE) is
		external
			"IL static signature (ARRAY_SINGLE): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$clear_all"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: ARRAY_SINGLE; v: REAL; i: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, System.Single, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAY_SINGLE"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAY_SINGLE"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAY_SINGLE"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"_set_object_comparison"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"make_area"
		end

	frozen ec_illegal_36_ec_illegal_36_capacity (current_: ARRAY_SINGLE): INTEGER is
		external
			"IL static signature (ARRAY_SINGLE): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"$$capacity"
		end

	enter (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"enter"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"wipe_out"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAY_SINGLE"
		alias
			"count"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_grow (current_: ARRAY_SINGLE; i: INTEGER) is
		external
			"IL static signature (ARRAY_SINGLE, System.Int32): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"$$grow"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAY_SINGLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAY_SINGLE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.INTEGER_INTERVAL"

external class
	IMPLEMENTATION_INTEGER_INTERVAL

inherit
	CONTAINER_INT32
	SET_INT32
		rename
			count as count_int32,
			put as bag_put
		end
	BAG_INT32
		rename
			put as bag_put
		end
	TABLE_INT32_INT32
		rename
			valid_key as valid_index,
			put as bag_put
		end
	BOUNDED_INT32
		rename
			count as count_int32
		end
	BOX_INT32
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	INTEGER_INTERVAL
		rename
			count as count_int32,
			valid_key as valid_index,
			put as bag_put
		end
	RESIZABLE_INT32
		rename
			count as count_int32
		end
	FINITE_INT32
		rename
			count as count_int32
		end
	INDEXABLE_INT32_INT32
		rename
			valid_key as valid_index,
			put as bag_put
		end
	COLLECTION_INT32
		rename
			put as bag_put
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.INTEGER_INTERVAL"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper_defined: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$upper_defined"
		end

	frozen ec_illegal_36_ec_illegal_36_lower_defined: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$lower_defined"
		end

	frozen ec_illegal_36_ec_illegal_36_upper_internal: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$upper_internal"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_lower_internal: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$lower_internal"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.INTEGER_INTERVAL"
		alias
			"operating_environment"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"is_equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INTEGER_INTERVAL"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: INTEGER_INTERVAL): INTEGER_INTERVAL is
		external
			"IL static signature (INTEGER_INTERVAL): INTEGER_INTERVAL use Implementation.INTEGER_INTERVAL"
		alias
			"$$index_set"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: INTEGER_INTERVAL): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$prunable"
		end

	frozen ec_illegal_36_ec_illegal_36_all_cleared (current_: INTEGER_INTERVAL): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$all_cleared"
		end

	exists (condition: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"exists"
		end

	frozen ec_illegal_36_ec_illegal_36_as_array (current_: INTEGER_INTERVAL): ARRAY_INT32 is
		external
			"IL static signature (INTEGER_INTERVAL): ARRAY_INT32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$as_array"
		end

	frozen ec_illegal_36_ec_illegal_36_for_all (current_: INTEGER_INTERVAL; condition: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL, FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$for_all"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"minimal_increase"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: INTEGER_INTERVAL; other: INTEGER_INTERVAL) is
		external
			"IL static signature (INTEGER_INTERVAL, INTEGER_INTERVAL): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$copy"
		end

	occurrences (v: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"occurrences"
		end

	exists1 (condition: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"exists1"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"copy"
		end

	upper_defined: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"upper_defined"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_INTERVAL"
		alias
			"generating_type"
		end

	resize_exactly (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"resize_exactly"
		end

	put_int32_int32 (v: INTEGER; k: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"indexable_put"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"make"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"same_type"
		end

	subinterval (start_pos: INTEGER; end_pos: INTEGER): INTEGER_INTERVAL is
		external
			"IL signature (System.Int32, System.Int32): INTEGER_INTERVAL use Implementation.INTEGER_INTERVAL"
		alias
			"subinterval"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"resize"
		end

	frozen ec_illegal_36_ec_illegal_36_exists (current_: INTEGER_INTERVAL; condition: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL, FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$exists"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_INTERVAL"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: INTEGER_INTERVAL) is
		external
			"IL static signature (INTEGER_INTERVAL): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$wipe_out"
		end

	is_inserted (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"is_inserted"
		end

	prune (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: INTEGER_INTERVAL): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$extendible"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"changeable_comparison_criterion"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: INTEGER_INTERVAL; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: INTEGER_INTERVAL; i: INTEGER): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$item"
		end

	frozen ec_illegal_36_ec_illegal_36_upper (current_: INTEGER_INTERVAL): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_resize_exactly (current_: INTEGER_INTERVAL; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$resize_exactly"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_indexable_put (current_: INTEGER_INTERVAL; v: INTEGER; k: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$indexable_put"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.INTEGER_INTERVAL"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"GetHashCode"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"compare_objects"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"resizable"
		end

	frozen ec_illegal_36_ec_illegal_36_resize (current_: INTEGER_INTERVAL; min_index: INTEGER; max_index: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$resize"
		end

	for_all (condition: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"empty"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"automatic_grow"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_INTERVAL"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: INTEGER_INTERVAL; i: INTEGER): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$infix "@""
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.INTEGER_INTERVAL"
		alias
			"default"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTEGER_INTERVAL"
		alias
			"deep_clone"
		end

	fill (other: CONTAINER_INT32) is
		external
			"IL signature (CONTAINER_INT32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"do_nothing"
		end

	a_set_upper_defined (upper_defined2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"_set_upper_defined"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.INTEGER_INTERVAL"
		alias
			"index_set"
		end

	has (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"has"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: INTEGER_INTERVAL; other: INTEGER_INTERVAL): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL, INTEGER_INTERVAL): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$is_equal"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"is_empty"
		end

	prune_all (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"prune_all"
		end

	a_set_lower_defined (lower_defined2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"_set_lower_defined"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"all_cleared"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: INTEGER_INTERVAL): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$count"
		end

	put_int32 (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"put"
		end

	frozen ec_illegal_36_ec_illegal_36_subinterval (current_: INTEGER_INTERVAL; start_pos: INTEGER; end_pos: INTEGER): INTEGER_INTERVAL is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32, System.Int32): INTEGER_INTERVAL use Implementation.INTEGER_INTERVAL"
		alias
			"$$subinterval"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"count"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"growth_percentage"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: INTEGER_INTERVAL; v: INTEGER): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_adapt (current_: INTEGER_INTERVAL; other: INTEGER_INTERVAL) is
		external
			"IL static signature (INTEGER_INTERVAL, INTEGER_INTERVAL): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$adapt"
		end

	frozen ec_illegal_36_ec_illegal_36_hold_count (current_: INTEGER_INTERVAL; condition: FUNCTION_ANY_ANY_BOOLEAN): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL, FUNCTION_ANY_ANY_BOOLEAN): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$hold_count"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: INTEGER_INTERVAL; v: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$extend"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"standard_is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: INTEGER_INTERVAL; v: INTEGER): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$has"
		end

	a_set_upper_internal (upper_internal2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"_set_upper_internal"
		end

	bag_put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"bag_put"
		end

	item (k: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"item"
		end

	linear_representation: LINEAR_INT32 is
		external
			"IL signature (): LINEAR_INT32 use Implementation.INTEGER_INTERVAL"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.INTEGER_INTERVAL"
		alias
			"default_pointer"
		end

	infix "@" (k: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_lower (current_: INTEGER_INTERVAL): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$lower"
		end

	a_set_lower_internal (lower_internal2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"_set_lower_internal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"compare_references"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"full"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"print"
		end

	valid_index (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"valid_index"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"equal"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"upper"
		end

	extend (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"extend"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTEGER_INTERVAL"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: INTEGER_INTERVAL; v: INTEGER): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$valid_index"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"prunable"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.INTEGER_INTERVAL"
		alias
			"to_c"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: INTEGER_INTERVAL; v: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$prune"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"lower"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"grow"
		end

	as_array: ARRAY_INT32 is
		external
			"IL signature (): ARRAY_INT32 use Implementation.INTEGER_INTERVAL"
		alias
			"as_array"
		end

	upper_internal: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"upper_internal"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"additional_space"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"Equals"
		end

	lower_defined: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"lower_defined"
		end

	frozen ec_illegal_36_ec_illegal_36_to_c (current_: INTEGER_INTERVAL): ANY is
		external
			"IL static signature (INTEGER_INTERVAL): ANY use Implementation.INTEGER_INTERVAL"
		alias
			"$$to_c"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: INTEGER_INTERVAL): LINEAR_INT32 is
		external
			"IL static signature (INTEGER_INTERVAL): LINEAR_INT32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$linear_representation"
		end

	frozen ec_illegal_36_ec_illegal_36_exists1 (current_: INTEGER_INTERVAL; condition: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL static signature (INTEGER_INTERVAL, FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.INTEGER_INTERVAL"
		alias
			"$$exists1"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTEGER_INTERVAL"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_grow (current_: INTEGER_INTERVAL; i: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$grow"
		end

	adapt (other: INTEGER_INTERVAL) is
		external
			"IL signature (INTEGER_INTERVAL): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"adapt"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.INTEGER_INTERVAL"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_INTERVAL"
		alias
			"generator"
		end

	lower_internal: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"lower_internal"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_capacity (current_: INTEGER_INTERVAL): INTEGER is
		external
			"IL static signature (INTEGER_INTERVAL): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"$$capacity"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INTEGER_INTERVAL"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"wipe_out"
		end

	hold_count (condition: FUNCTION_ANY_ANY_BOOLEAN): INTEGER is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Int32 use Implementation.INTEGER_INTERVAL"
		alias
			"hold_count"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: INTEGER_INTERVAL; v: INTEGER) is
		external
			"IL static signature (INTEGER_INTERVAL, System.Int32): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"$$put"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.INTEGER_INTERVAL"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_INTEGER_INTERVAL

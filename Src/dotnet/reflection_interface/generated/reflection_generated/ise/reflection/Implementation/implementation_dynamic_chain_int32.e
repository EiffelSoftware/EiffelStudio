indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DYNAMIC_CHAIN_INT32"

deferred external class
	IMPLEMENTATION_DYNAMIC_CHAIN_INT32

inherit
	CONTAINER_INT32
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end
	BILINEAR_INT32
		rename
			occurrences as occurrences_int32
		end
	TABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			valid_key as valid_index,
			item as item_int322
		end
	ACTIVE_INT32
		rename
			occurrences as occurrences_int32
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CURSOR_STRUCTURE_INT32
		rename
			occurrences as occurrences_int32
		end
	BOX_INT32
	FINITE_INT32
	CHAIN_INT32
		rename
			occurrences as occurrences_int32,
			valid_key as valid_index
		end
	DYNAMIC_CHAIN_INT32
		rename
			occurrences as occurrences_int32,
			valid_key as valid_index
		end
	SEQUENCE_INT32
		rename
			occurrences as occurrences_int32
		end
	TRAVERSABLE_INT32
	UNBOUNDED_INT32
	LINEAR_INT32
		rename
			occurrences as occurrences_int32
		end
	INDEXABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			valid_key as valid_index,
			item as item_int322
		end
	COLLECTION_INT32

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: DYNAMIC_CHAIN_INT32): BOOLEAN is
		external
			"IL static signature (DYNAMIC_CHAIN_INT32): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"$$prunable"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"start"
		end

	last: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"last"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"do_if"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: DYNAMIC_CHAIN_INT32): BOOLEAN is
		external
			"IL static signature (DYNAMIC_CHAIN_INT32): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"$$extendible"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"generating_type"
		end

	put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"put"
		end

	bag_put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"bag_put"
		end

	put_int32_int32 (v: INTEGER; i: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"put_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"out"
		end

	is_inserted (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"is_inserted"
		end

	prune (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"changeable_comparison_criterion"
		end

	append (s: SEQUENCE_INT32) is
		external
			"IL signature (SEQUENCE_INT32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"there_exists"
		end

	sequential_index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"GetHashCode"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"empty"
		end

	force (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"tagged_out"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"readable"
		end

	item_int322 (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"i_th"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"do_all"
		end

	index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"index_of"
		end

	fill (other: CONTAINER_INT32) is
		external
			"IL signature (CONTAINER_INT32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: DYNAMIC_CHAIN_INT32) is
		external
			"IL static signature (DYNAMIC_CHAIN_INT32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"$$wipe_out"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"index_set"
		end

	has (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"has"
		end

	first: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"first"
		end

	sequential_occurrences (v: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"sequential_occurrences"
		end

	prune_all (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"writable"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: DYNAMIC_CHAIN_INT32; n: INTEGER): DYNAMIC_CHAIN_INT32 is
		external
			"IL static signature (DYNAMIC_CHAIN_INT32, System.Int32): DYNAMIC_CHAIN_INT32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"$$duplicate"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"go_i_th"
		end

	infix "@" (k: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"infix "@""
		end

	linear_representation: LINEAR_INT32 is
		external
			"IL signature (): LINEAR_INT32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"compare_references"
		end

	duplicate (n: INTEGER): CHAIN_INT32 is
		external
			"IL signature (System.Int32): CHAIN_INT32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"duplicate"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"print"
		end

	sequential_search (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"valid_index"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"equal"
		end

	occurrences_int32 (v: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"occurrences"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: DYNAMIC_CHAIN_INT32; v: INTEGER) is
		external
			"IL static signature (DYNAMIC_CHAIN_INT32, System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"$$prune_all"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: DYNAMIC_CHAIN_INT32; v: INTEGER) is
		external
			"IL static signature (DYNAMIC_CHAIN_INT32, System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"$$prune"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"deep_equal"
		end

	sequential_has (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"standard_clone"
		end

	sequence_put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"sequence_put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"wipe_out"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"deep_copy"
		end

	search (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_CHAIN_INT32"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DYNAMIC_CHAIN_INT32

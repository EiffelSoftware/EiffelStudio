indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHAIN_ANY"

deferred external class
	IMPLEMENTATION_CHAIN_ANY

inherit
	CONTAINER_ANY
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	CURSOR_STRUCTURE_ANY
		rename
			occurrences as occurrences_any
		end
	SEQUENCE_ANY
		rename
			occurrences as occurrences_any
		end
	INDEXABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			valid_key as valid_index,
			item as item_int32
		end
	CHAIN_ANY
		rename
			occurrences as occurrences_any,
			valid_key as valid_index
		end
	FINITE_ANY
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_ANY
	ACTIVE_ANY
		rename
			occurrences as occurrences_any
		end
	BOX_ANY
	COLLECTION_ANY
	LINEAR_ANY
		rename
			occurrences as occurrences_any
		end
	TABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			valid_key as valid_index,
			item as item_int32
		end
	BILINEAR_ANY
		rename
			occurrences as occurrences_any
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHAIN_ANY"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_ANY"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_index_of (current_: CHAIN_ANY; v: ANY; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_ANY, ANY, System.Int32): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"$$sequential_index_of"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor_index (current_: CHAIN_ANY; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_ANY, System.Int32): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$valid_cursor_index"
		end

	frozen ec_illegal_36_ec_illegal_36_put_i_th (current_: CHAIN_ANY; v: ANY; i: INTEGER) is
		external
			"IL static signature (CHAIN_ANY, ANY, System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$put_i_th"
		end

	last: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_ANY"
		alias
			"last"
		end

	item_int32 (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.CHAIN_ANY"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CHAIN_ANY"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: CHAIN_ANY; v: ANY): INTEGER is
		external
			"IL static signature (CHAIN_ANY, ANY): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"$$occurrences"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_ANY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: CHAIN_ANY): ANY is
		external
			"IL static signature (CHAIN_ANY): ANY use Implementation.CHAIN_ANY"
		alias
			"$$last"
		end

	put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_ANY"
		alias
			"out"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: CHAIN_ANY) is
		external
			"IL static signature (CHAIN_ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$finish"
		end

	prune (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"changeable_comparison_criterion"
		end

	sequential_occurrences (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"sequential_occurrences"
		end

	append (s: SEQUENCE_ANY) is
		external
			"IL signature (SEQUENCE_ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"there_exists"
		end

	sequential_index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHAIN_ANY"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"empty"
		end

	force (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_ANY"
		alias
			"tagged_out"
		end

	occurrences_any (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: CHAIN_ANY) is
		external
			"IL static signature (CHAIN_ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"readable"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: CHAIN_ANY; i: INTEGER): ANY is
		external
			"IL static signature (CHAIN_ANY, System.Int32): ANY use Implementation.CHAIN_ANY"
		alias
			"$$infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"do_all"
		end

	index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"index_of"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL signature (CONTAINER_ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.CHAIN_ANY"
		alias
			"index_set"
		end

	has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"has"
		end

	first: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_ANY"
		alias
			"first"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"move"
		end

	prune_all (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: CHAIN_ANY): BOOLEAN is
		external
			"IL static signature (CHAIN_ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$islast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_sequence_put (current_: CHAIN_ANY; v: ANY) is
		external
			"IL static signature (CHAIN_ANY, ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$sequence_put"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"swap"
		end

	put_any_int32 (v: ANY; i: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"put_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: CHAIN_ANY; i: INTEGER) is
		external
			"IL static signature (CHAIN_ANY, System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: CHAIN_ANY): INTEGER_INTERVAL is
		external
			"IL static signature (CHAIN_ANY): INTEGER_INTERVAL use Implementation.CHAIN_ANY"
		alias
			"$$index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: CHAIN_ANY) is
		external
			"IL static signature (CHAIN_ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: CHAIN_ANY; v: ANY): BOOLEAN is
		external
			"IL static signature (CHAIN_ANY, ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: CHAIN_ANY; i: INTEGER) is
		external
			"IL static signature (CHAIN_ANY, System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.CHAIN_ANY"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: CHAIN_ANY): BOOLEAN is
		external
			"IL static signature (CHAIN_ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$isfirst"
		end

	linear_representation: LINEAR_ANY is
		external
			"IL signature (): LINEAR_ANY use Implementation.CHAIN_ANY"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_ANY"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_ANY"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"compare_references"
		end

	bag_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: CHAIN_ANY; i: INTEGER): ANY is
		external
			"IL static signature (CHAIN_ANY, System.Int32): ANY use Implementation.CHAIN_ANY"
		alias
			"$$i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_bag_put (current_: CHAIN_ANY; v: ANY) is
		external
			"IL static signature (CHAIN_ANY, ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"print"
		end

	sequential_search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_occurrences (current_: CHAIN_ANY; v: ANY): INTEGER is
		external
			"IL static signature (CHAIN_ANY, ANY): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"$$sequential_occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: CHAIN_ANY): ANY is
		external
			"IL static signature (CHAIN_ANY): ANY use Implementation.CHAIN_ANY"
		alias
			"$$first"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_ANY"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: CHAIN_ANY; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_ANY, System.Int32): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$valid_index"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_has (current_: CHAIN_ANY; v: ANY): BOOLEAN is
		external
			"IL static signature (CHAIN_ANY, ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$sequential_has"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: CHAIN_ANY): BOOLEAN is
		external
			"IL static signature (CHAIN_ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"$$off"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"deep_equal"
		end

	sequential_has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_ANY"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_ANY"
		alias
			"standard_clone"
		end

	sequence_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: CHAIN_ANY; v: ANY) is
		external
			"IL static signature (CHAIN_ANY, ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_ANY"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_ANY"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_ANY"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_ANY"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: CHAIN_ANY; i: INTEGER) is
		external
			"IL static signature (CHAIN_ANY, System.Int32): System.Void use Implementation.CHAIN_ANY"
		alias
			"$$move"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_ANY"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: CHAIN_ANY; v: ANY; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_ANY, ANY, System.Int32): System.Int32 use Implementation.CHAIN_ANY"
		alias
			"$$index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"deep_copy"
		end

	search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_ANY"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHAIN_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHAIN_ANY

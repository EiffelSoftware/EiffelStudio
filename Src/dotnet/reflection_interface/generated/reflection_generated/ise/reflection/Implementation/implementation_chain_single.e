indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHAIN_SINGLE"

deferred external class
	IMPLEMENTATION_CHAIN_SINGLE

inherit
	SEQUENCE_SINGLE
		rename
			occurrences as occurrences_single
		end
	TABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			valid_key as valid_index,
			item as item_int32
		end
	BOX_SINGLE
	CONTAINER_SINGLE
	BILINEAR_SINGLE
		rename
			occurrences as occurrences_single
		end
	LINEAR_SINGLE
		rename
			occurrences as occurrences_single
		end
	FINITE_SINGLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ACTIVE_SINGLE
		rename
			occurrences as occurrences_single
		end
	INDEXABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			valid_key as valid_index,
			item as item_int32
		end
	TRAVERSABLE_SINGLE
	CHAIN_SINGLE
		rename
			occurrences as occurrences_single,
			valid_key as valid_index
		end
	BAG_SINGLE
		rename
			occurrences as occurrences_single
		end
	COLLECTION_SINGLE
	CURSOR_STRUCTURE_SINGLE
		rename
			occurrences as occurrences_single
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHAIN_SINGLE"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_SINGLE"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_index_of (current_: CHAIN_SINGLE; v: REAL; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_SINGLE, System.Single, System.Int32): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"$$sequential_index_of"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor_index (current_: CHAIN_SINGLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_SINGLE, System.Int32): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$valid_cursor_index"
		end

	frozen ec_illegal_36_ec_illegal_36_put_i_th (current_: CHAIN_SINGLE; v: REAL; i: INTEGER) is
		external
			"IL static signature (CHAIN_SINGLE, System.Single, System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$put_i_th"
		end

	last: REAL is
		external
			"IL signature (): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"last"
		end

	item_int32 (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: CHAIN_SINGLE; v: REAL): INTEGER is
		external
			"IL static signature (CHAIN_SINGLE, System.Single): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"$$occurrences"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_SINGLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: CHAIN_SINGLE): REAL is
		external
			"IL static signature (CHAIN_SINGLE): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"$$last"
		end

	put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_SINGLE"
		alias
			"out"
		end

	is_inserted (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: CHAIN_SINGLE) is
		external
			"IL static signature (CHAIN_SINGLE): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$finish"
		end

	prune (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"changeable_comparison_criterion"
		end

	sequential_occurrences (v: REAL): INTEGER is
		external
			"IL signature (System.Single): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"sequential_occurrences"
		end

	append (s: SEQUENCE_SINGLE) is
		external
			"IL signature (SEQUENCE_SINGLE): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"there_exists"
		end

	sequential_index_of (v: REAL; i: INTEGER): INTEGER is
		external
			"IL signature (System.Single, System.Int32): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHAIN_SINGLE"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"empty"
		end

	force (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"force"
		end

	occurrences_single (v: REAL): INTEGER is
		external
			"IL signature (System.Single): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_SINGLE"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: CHAIN_SINGLE) is
		external
			"IL static signature (CHAIN_SINGLE): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"readable"
		end

	put_single_int32 (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"put_i_th"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"do_all"
		end

	index_of (v: REAL; i: INTEGER): INTEGER is
		external
			"IL signature (System.Single, System.Int32): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"index_of"
		end

	fill (other: CONTAINER_SINGLE) is
		external
			"IL signature (CONTAINER_SINGLE): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.CHAIN_SINGLE"
		alias
			"index_set"
		end

	has (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"has"
		end

	first: REAL is
		external
			"IL signature (): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"first"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"move"
		end

	prune_all (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: CHAIN_SINGLE): BOOLEAN is
		external
			"IL static signature (CHAIN_SINGLE): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$islast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_sequence_put (current_: CHAIN_SINGLE; v: REAL) is
		external
			"IL static signature (CHAIN_SINGLE, System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$sequence_put"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: CHAIN_SINGLE; i: INTEGER) is
		external
			"IL static signature (CHAIN_SINGLE, System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$move"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: CHAIN_SINGLE; i: INTEGER) is
		external
			"IL static signature (CHAIN_SINGLE, System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: CHAIN_SINGLE): INTEGER_INTERVAL is
		external
			"IL static signature (CHAIN_SINGLE): INTEGER_INTERVAL use Implementation.CHAIN_SINGLE"
		alias
			"$$index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: CHAIN_SINGLE) is
		external
			"IL static signature (CHAIN_SINGLE): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: CHAIN_SINGLE; v: REAL): BOOLEAN is
		external
			"IL static signature (CHAIN_SINGLE, System.Single): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: CHAIN_SINGLE; i: INTEGER) is
		external
			"IL static signature (CHAIN_SINGLE, System.Int32): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: CHAIN_SINGLE): BOOLEAN is
		external
			"IL static signature (CHAIN_SINGLE): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$isfirst"
		end

	linear_representation: LINEAR_SINGLE is
		external
			"IL signature (): LINEAR_SINGLE use Implementation.CHAIN_SINGLE"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_SINGLE"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_SINGLE"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"compare_references"
		end

	bag_put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: CHAIN_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (CHAIN_SINGLE, System.Int32): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"$$i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_bag_put (current_: CHAIN_SINGLE; v: REAL) is
		external
			"IL static signature (CHAIN_SINGLE, System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"print"
		end

	sequential_search (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_occurrences (current_: CHAIN_SINGLE; v: REAL): INTEGER is
		external
			"IL static signature (CHAIN_SINGLE, System.Single): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"$$sequential_occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: CHAIN_SINGLE): REAL is
		external
			"IL static signature (CHAIN_SINGLE): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"$$first"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_SINGLE"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: CHAIN_SINGLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_SINGLE, System.Int32): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$valid_index"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_has (current_: CHAIN_SINGLE; v: REAL): BOOLEAN is
		external
			"IL static signature (CHAIN_SINGLE, System.Single): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$sequential_has"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: CHAIN_SINGLE): BOOLEAN is
		external
			"IL static signature (CHAIN_SINGLE): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"$$off"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: CHAIN_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (CHAIN_SINGLE, System.Int32): System.Single use Implementation.CHAIN_SINGLE"
		alias
			"$$infix "@""
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"deep_equal"
		end

	sequential_has (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.CHAIN_SINGLE"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_SINGLE"
		alias
			"standard_clone"
		end

	sequence_put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: CHAIN_SINGLE; v: REAL) is
		external
			"IL static signature (CHAIN_SINGLE, System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_SINGLE"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_SINGLE"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_SINGLE"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_SINGLE"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: CHAIN_SINGLE; v: REAL; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_SINGLE, System.Single, System.Int32): System.Int32 use Implementation.CHAIN_SINGLE"
		alias
			"$$index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"deep_copy"
		end

	search (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHAIN_SINGLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHAIN_SINGLE

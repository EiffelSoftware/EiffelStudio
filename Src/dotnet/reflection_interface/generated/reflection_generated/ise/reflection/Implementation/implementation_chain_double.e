indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHAIN_DOUBLE"

deferred external class
	IMPLEMENTATION_CHAIN_DOUBLE

inherit
	INDEXABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			valid_key as valid_index,
			item as item_int32
		end
	BILINEAR_DOUBLE
		rename
			occurrences as occurrences_double
		end
	ACTIVE_DOUBLE
		rename
			occurrences as occurrences_double
		end
	COLLECTION_DOUBLE
	LINEAR_DOUBLE
		rename
			occurrences as occurrences_double
		end
	BAG_DOUBLE
		rename
			occurrences as occurrences_double
		end
	BOX_DOUBLE
	SEQUENCE_DOUBLE
		rename
			occurrences as occurrences_double
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_DOUBLE
	FINITE_DOUBLE
	CURSOR_STRUCTURE_DOUBLE
		rename
			occurrences as occurrences_double
		end
	CHAIN_DOUBLE
		rename
			occurrences as occurrences_double,
			valid_key as valid_index
		end
	CONTAINER_DOUBLE
	TABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			valid_key as valid_index,
			item as item_int32
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHAIN_DOUBLE"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_DOUBLE"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_index_of (current_: CHAIN_DOUBLE; v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double, System.Int32): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"$$sequential_index_of"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor_index (current_: CHAIN_DOUBLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_DOUBLE, System.Int32): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$valid_cursor_index"
		end

	frozen ec_illegal_36_ec_illegal_36_put_i_th (current_: CHAIN_DOUBLE; v: DOUBLE; i: INTEGER) is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double, System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$put_i_th"
		end

	last: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"last"
		end

	item_int32 (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: CHAIN_DOUBLE; v: DOUBLE): INTEGER is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"$$occurrences"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_DOUBLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: CHAIN_DOUBLE): DOUBLE is
		external
			"IL static signature (CHAIN_DOUBLE): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"$$last"
		end

	put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_DOUBLE"
		alias
			"out"
		end

	occurrences_double (v: DOUBLE): INTEGER is
		external
			"IL signature (System.Double): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"occurrences"
		end

	is_inserted (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: CHAIN_DOUBLE) is
		external
			"IL static signature (CHAIN_DOUBLE): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$finish"
		end

	prune (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"changeable_comparison_criterion"
		end

	sequential_occurrences (v: DOUBLE): INTEGER is
		external
			"IL signature (System.Double): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"sequential_occurrences"
		end

	append (s: SEQUENCE_DOUBLE) is
		external
			"IL signature (SEQUENCE_DOUBLE): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"there_exists"
		end

	sequential_index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL signature (System.Double, System.Int32): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"conforms_to"
		end

	put_double_int32 (v: DOUBLE; i: INTEGER) is
		external
			"IL signature (System.Double, System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"put_i_th"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHAIN_DOUBLE"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"empty"
		end

	force (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_DOUBLE"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: CHAIN_DOUBLE) is
		external
			"IL static signature (CHAIN_DOUBLE): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"readable"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: CHAIN_DOUBLE; i: INTEGER): DOUBLE is
		external
			"IL static signature (CHAIN_DOUBLE, System.Int32): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"$$infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"do_all"
		end

	index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL signature (System.Double, System.Int32): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"index_of"
		end

	fill (other: CONTAINER_DOUBLE) is
		external
			"IL signature (CONTAINER_DOUBLE): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.CHAIN_DOUBLE"
		alias
			"index_set"
		end

	has (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"has"
		end

	first: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"first"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"move"
		end

	prune_all (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: CHAIN_DOUBLE): BOOLEAN is
		external
			"IL static signature (CHAIN_DOUBLE): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$islast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_sequence_put (current_: CHAIN_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$sequence_put"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: CHAIN_DOUBLE; i: INTEGER) is
		external
			"IL static signature (CHAIN_DOUBLE, System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$move"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: CHAIN_DOUBLE; i: INTEGER) is
		external
			"IL static signature (CHAIN_DOUBLE, System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: CHAIN_DOUBLE): INTEGER_INTERVAL is
		external
			"IL static signature (CHAIN_DOUBLE): INTEGER_INTERVAL use Implementation.CHAIN_DOUBLE"
		alias
			"$$index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: CHAIN_DOUBLE) is
		external
			"IL static signature (CHAIN_DOUBLE): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: CHAIN_DOUBLE; v: DOUBLE): BOOLEAN is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: CHAIN_DOUBLE; i: INTEGER) is
		external
			"IL static signature (CHAIN_DOUBLE, System.Int32): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: CHAIN_DOUBLE): BOOLEAN is
		external
			"IL static signature (CHAIN_DOUBLE): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$isfirst"
		end

	linear_representation: LINEAR_DOUBLE is
		external
			"IL signature (): LINEAR_DOUBLE use Implementation.CHAIN_DOUBLE"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_DOUBLE"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_DOUBLE"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"compare_references"
		end

	bag_put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: CHAIN_DOUBLE; i: INTEGER): DOUBLE is
		external
			"IL static signature (CHAIN_DOUBLE, System.Int32): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"$$i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_bag_put (current_: CHAIN_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"print"
		end

	sequential_search (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_occurrences (current_: CHAIN_DOUBLE; v: DOUBLE): INTEGER is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"$$sequential_occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: CHAIN_DOUBLE): DOUBLE is
		external
			"IL static signature (CHAIN_DOUBLE): System.Double use Implementation.CHAIN_DOUBLE"
		alias
			"$$first"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_DOUBLE"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: CHAIN_DOUBLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_DOUBLE, System.Int32): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$valid_index"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_has (current_: CHAIN_DOUBLE; v: DOUBLE): BOOLEAN is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$sequential_has"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: CHAIN_DOUBLE): BOOLEAN is
		external
			"IL static signature (CHAIN_DOUBLE): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"$$off"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"deep_equal"
		end

	sequential_has (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.CHAIN_DOUBLE"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_DOUBLE"
		alias
			"standard_clone"
		end

	sequence_put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: CHAIN_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_DOUBLE"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_DOUBLE"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_DOUBLE"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_DOUBLE"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: CHAIN_DOUBLE; v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_DOUBLE, System.Double, System.Int32): System.Int32 use Implementation.CHAIN_DOUBLE"
		alias
			"$$index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"deep_copy"
		end

	search (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHAIN_DOUBLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHAIN_DOUBLE

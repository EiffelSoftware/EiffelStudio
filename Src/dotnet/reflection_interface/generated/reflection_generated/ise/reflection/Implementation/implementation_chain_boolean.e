indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHAIN_BOOLEAN"

deferred external class
	IMPLEMENTATION_CHAIN_BOOLEAN

inherit
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	BILINEAR_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	BOX_BOOLEAN
	LINEAR_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	SEQUENCE_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_BOOLEAN
	FINITE_BOOLEAN
	TABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			valid_key as valid_index,
			item as item_int32
		end
	CONTAINER_BOOLEAN
	COLLECTION_BOOLEAN
	ACTIVE_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	CURSOR_STRUCTURE_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	CHAIN_BOOLEAN
		rename
			occurrences as occurrences_boolean,
			valid_key as valid_index
		end
	INDEXABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			valid_key as valid_index,
			item as item_int32
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHAIN_BOOLEAN"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_BOOLEAN"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_index_of (current_: CHAIN_BOOLEAN; v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean, System.Int32): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"$$sequential_index_of"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor_index (current_: CHAIN_BOOLEAN; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$valid_cursor_index"
		end

	frozen ec_illegal_36_ec_illegal_36_put_i_th (current_: CHAIN_BOOLEAN; v: BOOLEAN; i: INTEGER) is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean, System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$put_i_th"
		end

	last: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"last"
		end

	item_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: CHAIN_BOOLEAN; v: BOOLEAN): INTEGER is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"$$occurrences"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BOOLEAN"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: CHAIN_BOOLEAN): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$last"
		end

	put (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BOOLEAN"
		alias
			"out"
		end

	is_inserted (v: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: CHAIN_BOOLEAN) is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$finish"
		end

	prune (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"changeable_comparison_criterion"
		end

	sequential_occurrences (v: BOOLEAN): INTEGER is
		external
			"IL signature (System.Boolean): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"sequential_occurrences"
		end

	append (s: SEQUENCE_BOOLEAN) is
		external
			"IL signature (SEQUENCE_BOOLEAN): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"there_exists"
		end

	sequential_index_of (v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL signature (System.Boolean, System.Int32): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHAIN_BOOLEAN"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"empty"
		end

	force (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BOOLEAN"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: CHAIN_BOOLEAN) is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"readable"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: CHAIN_BOOLEAN; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"do_all"
		end

	index_of (v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL signature (System.Boolean, System.Int32): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"index_of"
		end

	fill (other: CONTAINER_BOOLEAN) is
		external
			"IL signature (CONTAINER_BOOLEAN): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.CHAIN_BOOLEAN"
		alias
			"index_set"
		end

	has (v: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"has"
		end

	first: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"first"
		end

	occurrences_boolean (v: BOOLEAN): INTEGER is
		external
			"IL signature (System.Boolean): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"occurrences"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"move"
		end

	prune_all (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: CHAIN_BOOLEAN): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$islast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_sequence_put (current_: CHAIN_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$sequence_put"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: CHAIN_BOOLEAN; i: INTEGER) is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$move"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: CHAIN_BOOLEAN; i: INTEGER) is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: CHAIN_BOOLEAN): INTEGER_INTERVAL is
		external
			"IL static signature (CHAIN_BOOLEAN): INTEGER_INTERVAL use Implementation.CHAIN_BOOLEAN"
		alias
			"$$index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: CHAIN_BOOLEAN) is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: CHAIN_BOOLEAN; v: BOOLEAN): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: CHAIN_BOOLEAN; i: INTEGER) is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: CHAIN_BOOLEAN): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$isfirst"
		end

	linear_representation: LINEAR_BOOLEAN is
		external
			"IL signature (): LINEAR_BOOLEAN use Implementation.CHAIN_BOOLEAN"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_BOOLEAN"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_BOOLEAN"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"compare_references"
		end

	bag_put (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: CHAIN_BOOLEAN; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_bag_put (current_: CHAIN_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"print"
		end

	sequential_search (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_occurrences (current_: CHAIN_BOOLEAN; v: BOOLEAN): INTEGER is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"$$sequential_occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: CHAIN_BOOLEAN): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$first"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_BOOLEAN"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: CHAIN_BOOLEAN; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Int32): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$valid_index"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_has (current_: CHAIN_BOOLEAN; v: BOOLEAN): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$sequential_has"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"GetHashCode"
		end

	put_boolean_int32 (v: BOOLEAN; i: INTEGER) is
		external
			"IL signature (System.Boolean, System.Int32): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"put_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: CHAIN_BOOLEAN): BOOLEAN is
		external
			"IL static signature (CHAIN_BOOLEAN): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"$$off"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"deep_equal"
		end

	sequential_has (v: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use Implementation.CHAIN_BOOLEAN"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_BOOLEAN"
		alias
			"standard_clone"
		end

	sequence_put (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: CHAIN_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_BOOLEAN"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_BOOLEAN"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_BOOLEAN"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_BOOLEAN"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: CHAIN_BOOLEAN; v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_BOOLEAN, System.Boolean, System.Int32): System.Int32 use Implementation.CHAIN_BOOLEAN"
		alias
			"$$index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"deep_copy"
		end

	search (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHAIN_BOOLEAN"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHAIN_BOOLEAN

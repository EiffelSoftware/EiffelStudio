indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHAIN_INTPTR"

deferred external class
	IMPLEMENTATION_CHAIN_INTPTR

inherit
	TRAVERSABLE_INTPTR
	SEQUENCE_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	INDEXABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			valid_key as valid_index,
			item as item_int32
		end
	ACTIVE_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	BILINEAR_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	COLLECTION_INTPTR
	CHAIN_INTPTR
		rename
			occurrences as occurrences_int_ptr,
			valid_key as valid_index
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	BAG_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	TABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			valid_key as valid_index,
			item as item_int32
		end
	CONTAINER_INTPTR
	BOX_INTPTR
	LINEAR_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	FINITE_INTPTR
	CURSOR_STRUCTURE_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHAIN_INTPTR"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_INTPTR"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_index_of (current_: CHAIN_INTPTR; v: POINTER; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr, System.Int32): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"$$sequential_index_of"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor_index (current_: CHAIN_INTPTR; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_INTPTR, System.Int32): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$valid_cursor_index"
		end

	frozen ec_illegal_36_ec_illegal_36_put_i_th (current_: CHAIN_INTPTR; v: POINTER; i: INTEGER) is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr, System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$put_i_th"
		end

	last: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"last"
		end

	item_int32 (i: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: CHAIN_INTPTR; v: POINTER): INTEGER is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"$$occurrences"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_INTPTR"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: CHAIN_INTPTR): POINTER is
		external
			"IL static signature (CHAIN_INTPTR): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"$$last"
		end

	put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_INTPTR"
		alias
			"out"
		end

	put_int_ptr_int32 (v: POINTER; i: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"put_i_th"
		end

	is_inserted (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: CHAIN_INTPTR) is
		external
			"IL static signature (CHAIN_INTPTR): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$finish"
		end

	prune (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"changeable_comparison_criterion"
		end

	append (s: SEQUENCE_INTPTR) is
		external
			"IL signature (SEQUENCE_INTPTR): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"there_exists"
		end

	sequential_index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.IntPtr, System.Int32): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHAIN_INTPTR"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"empty"
		end

	force (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_INTPTR"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: CHAIN_INTPTR) is
		external
			"IL static signature (CHAIN_INTPTR): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"readable"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: CHAIN_INTPTR; i: INTEGER): POINTER is
		external
			"IL static signature (CHAIN_INTPTR, System.Int32): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"$$infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"do_all"
		end

	index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.IntPtr, System.Int32): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"index_of"
		end

	fill (other: CONTAINER_INTPTR) is
		external
			"IL signature (CONTAINER_INTPTR): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.CHAIN_INTPTR"
		alias
			"index_set"
		end

	has (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"has"
		end

	first: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"first"
		end

	sequential_occurrences (v: POINTER): INTEGER is
		external
			"IL signature (System.IntPtr): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"sequential_occurrences"
		end

	prune_all (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: CHAIN_INTPTR): BOOLEAN is
		external
			"IL static signature (CHAIN_INTPTR): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$islast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_sequence_put (current_: CHAIN_INTPTR; v: POINTER) is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$sequence_put"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: CHAIN_INTPTR; i: INTEGER) is
		external
			"IL static signature (CHAIN_INTPTR, System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$move"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: CHAIN_INTPTR; i: INTEGER) is
		external
			"IL static signature (CHAIN_INTPTR, System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_index_set (current_: CHAIN_INTPTR): INTEGER_INTERVAL is
		external
			"IL static signature (CHAIN_INTPTR): INTEGER_INTERVAL use Implementation.CHAIN_INTPTR"
		alias
			"$$index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: CHAIN_INTPTR) is
		external
			"IL static signature (CHAIN_INTPTR): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: CHAIN_INTPTR; v: POINTER): BOOLEAN is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$has"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: CHAIN_INTPTR; i: INTEGER) is
		external
			"IL static signature (CHAIN_INTPTR, System.Int32): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: CHAIN_INTPTR): BOOLEAN is
		external
			"IL static signature (CHAIN_INTPTR): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$isfirst"
		end

	linear_representation: LINEAR_INTPTR is
		external
			"IL signature (): LINEAR_INTPTR use Implementation.CHAIN_INTPTR"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_INTPTR"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"compare_references"
		end

	bag_put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: CHAIN_INTPTR; i: INTEGER): POINTER is
		external
			"IL static signature (CHAIN_INTPTR, System.Int32): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"$$i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_bag_put (current_: CHAIN_INTPTR; v: POINTER) is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"print"
		end

	sequential_search (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_occurrences (current_: CHAIN_INTPTR; v: POINTER): INTEGER is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"$$sequential_occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: CHAIN_INTPTR): POINTER is
		external
			"IL static signature (CHAIN_INTPTR): System.IntPtr use Implementation.CHAIN_INTPTR"
		alias
			"$$first"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"equal"
		end

	occurrences_int_ptr (v: POINTER): INTEGER is
		external
			"IL signature (System.IntPtr): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"occurrences"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_INTPTR"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: CHAIN_INTPTR; i: INTEGER): BOOLEAN is
		external
			"IL static signature (CHAIN_INTPTR, System.Int32): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$valid_index"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_has (current_: CHAIN_INTPTR; v: POINTER): BOOLEAN is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$sequential_has"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: CHAIN_INTPTR): BOOLEAN is
		external
			"IL static signature (CHAIN_INTPTR): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"$$off"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"deep_equal"
		end

	sequential_has (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.CHAIN_INTPTR"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_INTPTR"
		alias
			"standard_clone"
		end

	sequence_put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: CHAIN_INTPTR; v: POINTER) is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHAIN_INTPTR"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHAIN_INTPTR"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHAIN_INTPTR"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHAIN_INTPTR"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: CHAIN_INTPTR; v: POINTER; i: INTEGER): INTEGER is
		external
			"IL static signature (CHAIN_INTPTR, System.IntPtr, System.Int32): System.Int32 use Implementation.CHAIN_INTPTR"
		alias
			"$$index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"deep_copy"
		end

	search (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHAIN_INTPTR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHAIN_INTPTR

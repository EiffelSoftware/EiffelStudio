indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.LIST_INTPTR"

deferred external class
	IMPLEMENTATION_LIST_INTPTR

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
	LIST_INTPTR
		rename
			occurrences as occurrences_int_ptr,
			valid_key as valid_index
		end
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
			"IL field signature :System.Boolean use Implementation.LIST_INTPTR"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.LIST_INTPTR"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LIST_INTPTR"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"default_create"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"start"
		end

	last: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.LIST_INTPTR"
		alias
			"last"
		end

	frozen ec_illegal_36_ec_illegal_36_before (current_: LIST_INTPTR): BOOLEAN is
		external
			"IL static signature (LIST_INTPTR): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"$$before"
		end

	item_int32 (i: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.LIST_INTPTR"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.LIST_INTPTR"
		alias
			"do_if"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"after"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LIST_INTPTR"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.LIST_INTPTR"
		alias
			"generating_type"
		end

	put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"put"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.LIST_INTPTR"
		alias
			"go_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.LIST_INTPTR"
		alias
			"out"
		end

	put_int_ptr_int32 (v: POINTER; i: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.LIST_INTPTR"
		alias
			"put_i_th"
		end

	is_inserted (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"is_inserted"
		end

	prune (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"changeable_comparison_criterion"
		end

	append (s: SEQUENCE_INTPTR) is
		external
			"IL signature (SEQUENCE_INTPTR): System.Void use Implementation.LIST_INTPTR"
		alias
			"append"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"there_exists"
		end

	sequential_index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.IntPtr, System.Int32): System.Int32 use Implementation.LIST_INTPTR"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.LIST_INTPTR"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.LIST_INTPTR"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"empty"
		end

	force (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.LIST_INTPTR"
		alias
			"tagged_out"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"readable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"before"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.LIST_INTPTR"
		alias
			"do_all"
		end

	index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.IntPtr, System.Int32): System.Int32 use Implementation.LIST_INTPTR"
		alias
			"index_of"
		end

	fill (other: CONTAINER_INTPTR) is
		external
			"IL signature (CONTAINER_INTPTR): System.Void use Implementation.LIST_INTPTR"
		alias
			"fill"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"do_nothing"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.LIST_INTPTR"
		alias
			"index_set"
		end

	has (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"has"
		end

	first: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.LIST_INTPTR"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: LIST_INTPTR; other: LIST_INTPTR): BOOLEAN is
		external
			"IL static signature (LIST_INTPTR, LIST_INTPTR): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"$$is_equal"
		end

	sequential_occurrences (v: POINTER): INTEGER is
		external
			"IL signature (System.IntPtr): System.Int32 use Implementation.LIST_INTPTR"
		alias
			"sequential_occurrences"
		end

	prune_all (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"writable"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.LIST_INTPTR"
		alias
			"swap"
		end

	infix "@" (k: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.LIST_INTPTR"
		alias
			"infix "@""
		end

	linear_representation: LINEAR_INTPTR is
		external
			"IL signature (): LINEAR_INTPTR use Implementation.LIST_INTPTR"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.LIST_INTPTR"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.LIST_INTPTR"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"compare_references"
		end

	bag_put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"bag_put"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LIST_INTPTR"
		alias
			"print"
		end

	sequential_search (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"valid_index"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"equal"
		end

	occurrences_int_ptr (v: POINTER): INTEGER is
		external
			"IL signature (System.IntPtr): System.Int32 use Implementation.LIST_INTPTR"
		alias
			"occurrences"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LIST_INTPTR"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LIST_INTPTR"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.LIST_INTPTR"
		alias
			"GetHashCode"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"deep_equal"
		end

	sequential_has (v: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LIST_INTPTR"
		alias
			"standard_clone"
		end

	sequence_put (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"sequence_put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.LIST_INTPTR"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.LIST_INTPTR"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LIST_INTPTR"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LIST_INTPTR"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LIST_INTPTR"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LIST_INTPTR"
		alias
			"ToString"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LIST_INTPTR"
		alias
			"deep_copy"
		end

	search (v: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.LIST_INTPTR"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_after (current_: LIST_INTPTR): BOOLEAN is
		external
			"IL static signature (LIST_INTPTR): System.Boolean use Implementation.LIST_INTPTR"
		alias
			"$$after"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.LIST_INTPTR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_LIST_INTPTR

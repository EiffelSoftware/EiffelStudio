indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.COUNTABLE_SEQUENCE_INT32"

deferred external class
	IMPLEMENTATION_COUNTABLE_SEQUENCE_INT32

inherit
	CONTAINER_INT32
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end
	BOX_INT32
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ACTIVE_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32
		end
	TRAVERSABLE_INT32
		rename
			item as item_int32
		end
	COUNTABLE_SEQUENCE_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32,
			index as index_int32
		end
	COUNTABLE_INT32
	INFINITE_INT32
	LINEAR_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32,
			index as index_int32
		end
	COLLECTION_INT32

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$index"
		end

feature -- Basic Operations

	frozen ec_illegal_36_ec_illegal_36_writable (current_: COUNTABLE_SEQUENCE_INT32): BOOLEAN is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$writable"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: COUNTABLE_SEQUENCE_INT32): BOOLEAN is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$prunable"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: COUNTABLE_SEQUENCE_INT32) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$finish"
		end

	item_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"item"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"do_if"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: COUNTABLE_SEQUENCE_INT32): BOOLEAN is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$extendible"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"deep_equal"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"_set_index"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"generating_type"
		end

	put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"put"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"out"
		end

	is_inserted (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"is_inserted"
		end

	prune (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"changeable_comparison_criterion"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"forth"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: COUNTABLE_SEQUENCE_INT32): INTEGER is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Int32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$item"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"there_exists"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"remove"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"empty"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"operating_environment"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"after"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: COUNTABLE_SEQUENCE_INT32) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"readable"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"do_all"
		end

	index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"index_of"
		end

	fill (other: CONTAINER_INT32) is
		external
			"IL signature (CONTAINER_INT32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: COUNTABLE_SEQUENCE_INT32) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$wipe_out"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"compare_objects"
		end

	occurrences_int32 (v: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: COUNTABLE_SEQUENCE_INT32; v: INTEGER) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32, System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$replace"
		end

	prune_all (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"prune_all"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"writable"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"standard_is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: COUNTABLE_SEQUENCE_INT32; v: INTEGER) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32, System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$extend"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: COUNTABLE_SEQUENCE_INT32) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$start"
		end

	linear_representation: LINEAR_INT32 is
		external
			"IL signature (): LINEAR_INT32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_readable (current_: COUNTABLE_SEQUENCE_INT32): BOOLEAN is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$readable"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"compare_references"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"index"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"full"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"exhausted"
		end

	replace (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"replace"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"equal"
		end

	extend (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"extend"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"standard_equal"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: COUNTABLE_SEQUENCE_INT32; v: INTEGER) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32, System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: COUNTABLE_SEQUENCE_INT32) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$forth"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"GetHashCode"
		end

	has (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"has"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: COUNTABLE_SEQUENCE_INT32): LINEAR_INT32 is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): LINEAR_INT32 use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$linear_representation"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: COUNTABLE_SEQUENCE_INT32; v: INTEGER) is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32, System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"wipe_out"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"deep_copy"
		end

	search (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_after (current_: COUNTABLE_SEQUENCE_INT32): BOOLEAN is
		external
			"IL static signature (COUNTABLE_SEQUENCE_INT32): System.Boolean use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"$$after"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.COUNTABLE_SEQUENCE_INT32"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_COUNTABLE_SEQUENCE_INT32

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_DOUBLE"

deferred external class
	ARRAYED_LIST_DOUBLE

inherit
	BILINEAR_DOUBLE
	INDEXABLE_DOUBLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_double
		end
	TO_SPECIAL_DOUBLE
		rename
			put as put_double_int322,
			item as item_int322
		end
	TABLE_DOUBLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_double
		end
	COLLECTION_DOUBLE
	LINEAR_DOUBLE
	BAG_DOUBLE
		rename
			occurrences as occurrences_double
		end
	CHAIN_DOUBLE
		rename
			infix "@" as infix "@_int32"
		end
	SEQUENCE_DOUBLE
	DYNAMIC_CHAIN_DOUBLE
		rename
			infix "@" as infix "@_int32"
		end
	TRAVERSABLE_DOUBLE
	RESIZABLE_DOUBLE
	ARRAY_DOUBLE
		rename
			force as force_double_int32,
			occurrences as occurrences_double,
			item as item_int322
		end
	ACTIVE_DOUBLE
		rename
			occurrences as occurrences_double,
			item as item_double
		end
	BOUNDED_DOUBLE
	LIST_DOUBLE
		rename
			infix "@" as infix "@_int32"
		end
	UNBOUNDED_DOUBLE
	DYNAMIC_LIST_DOUBLE
		rename
			infix "@" as infix "@_int32"
		end
	CURSOR_STRUCTURE_DOUBLE
		rename
			occurrences as occurrences_double,
			item as item_double
		end
	FINITE_DOUBLE
	CONTAINER_DOUBLE
	BOX_DOUBLE

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_DOUBLE"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_DOUBLE"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_DOUBLE"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_DOUBLE"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_DOUBLE"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_DOUBLE"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_DOUBLE"
		alias
			"count"
		end

	insert (v: DOUBLE; pos: INTEGER) is
		external
			"IL deferred signature (System.Double, System.Int32): System.Void use ARRAYED_LIST_DOUBLE"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_DOUBLE"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_DOUBLE"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_DOUBLE"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_DOUBLE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_ANY"

deferred external class
	ARRAYED_LIST_ANY

inherit
	CONTAINER_ANY
	RESIZABLE_ANY
	CURSOR_STRUCTURE_ANY
		rename
			occurrences as occurrences_any,
			item as item_any
		end
	FINITE_ANY
	ARRAY_ANY
		rename
			force as force_any_int32,
			occurrences as occurrences_any,
			item as item_int322
		end
	ACTIVE_ANY
		rename
			occurrences as occurrences_any,
			item as item_any
		end
	INDEXABLE_ANY_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_any
		end
	BOX_ANY
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	TRAVERSABLE_ANY
	SEQUENCE_ANY
	LIST_ANY
		rename
			infix "@" as infix "@_int32"
		end
	DYNAMIC_CHAIN_ANY
		rename
			infix "@" as infix "@_int32"
		end
	DYNAMIC_LIST_ANY
		rename
			infix "@" as infix "@_int32"
		end
	CHAIN_ANY
		rename
			infix "@" as infix "@_int32"
		end
	TABLE_ANY_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_any
		end
	COLLECTION_ANY
	LINEAR_ANY
	UNBOUNDED_ANY
	TO_SPECIAL_ANY
		rename
			put as put_any_int322,
			item as item_int322
		end
	BILINEAR_ANY
	BOUNDED_ANY

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_ANY"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_ANY"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_ANY"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_ANY"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_ANY"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_ANY"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_ANY"
		alias
			"count"
		end

	insert (v: ANY; pos: INTEGER) is
		external
			"IL deferred signature (ANY, System.Int32): System.Void use ARRAYED_LIST_ANY"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_ANY"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_ANY"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_ANY"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_ANY

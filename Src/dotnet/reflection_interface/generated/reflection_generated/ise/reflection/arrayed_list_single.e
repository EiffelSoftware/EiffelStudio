indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_SINGLE"

deferred external class
	ARRAYED_LIST_SINGLE

inherit
	BOX_SINGLE
	DYNAMIC_LIST_SINGLE
		rename
			infix "@" as infix "@_int32"
		end
	CHAIN_SINGLE
		rename
			infix "@" as infix "@_int32"
		end
	LIST_SINGLE
		rename
			infix "@" as infix "@_int32"
		end
	CONTAINER_SINGLE
	TRAVERSABLE_SINGLE
	LINEAR_SINGLE
	SEQUENCE_SINGLE
	BILINEAR_SINGLE
	ACTIVE_SINGLE
		rename
			occurrences as occurrences_single,
			item as item_single
		end
	CURSOR_STRUCTURE_SINGLE
		rename
			occurrences as occurrences_single,
			item as item_single
		end
	INDEXABLE_SINGLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_single
		end
	UNBOUNDED_SINGLE
	FINITE_SINGLE
	TABLE_SINGLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_single
		end
	BAG_SINGLE
		rename
			occurrences as occurrences_single
		end
	DYNAMIC_CHAIN_SINGLE
		rename
			infix "@" as infix "@_int32"
		end
	COLLECTION_SINGLE
	ARRAY_SINGLE
		rename
			force as force_single_int32,
			occurrences as occurrences_single,
			item as item_int322
		end
	TO_SPECIAL_SINGLE
		rename
			put as put_single_int322,
			item as item_int322
		end
	BOUNDED_SINGLE
	RESIZABLE_SINGLE

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_SINGLE"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_SINGLE"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_SINGLE"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_SINGLE"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_SINGLE"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_SINGLE"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_SINGLE"
		alias
			"count"
		end

	insert (v: REAL; pos: INTEGER) is
		external
			"IL deferred signature (System.Single, System.Int32): System.Void use ARRAYED_LIST_SINGLE"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_SINGLE"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_SINGLE"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_SINGLE"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_SINGLE

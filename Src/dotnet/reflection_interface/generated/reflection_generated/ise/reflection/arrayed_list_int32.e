indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_INT32"

deferred external class
	ARRAYED_LIST_INT32

inherit
	CONTAINER_INT32
	CURSOR_STRUCTURE_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32
		end
	LIST_INT32
		rename
			infix "@" as infix "@_int32"
		end
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end
	BILINEAR_INT32
	TABLE_INT32_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int322,
			occurrences as occurrences_int32
		end
	BOUNDED_INT32
	BOX_INT32
	DYNAMIC_CHAIN_INT32
		rename
			infix "@" as infix "@_int32"
		end
	TO_SPECIAL_INT32
		rename
			put as put_int32_int322,
			item as item_int3223
		end
	ACTIVE_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32
		end
	RESIZABLE_INT32
	FINITE_INT32
	CHAIN_INT32
		rename
			infix "@" as infix "@_int32"
		end
	TRAVERSABLE_INT32
	SEQUENCE_INT32
	DYNAMIC_LIST_INT32
		rename
			infix "@" as infix "@_int32"
		end
	UNBOUNDED_INT32
	ARRAY_INT32
		rename
			force as force_int32_int32,
			item_int32 as item_int322,
			occurrences as occurrences_int32,
			item as item_int3223
		end
	LINEAR_INT32
	INDEXABLE_INT32_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int322,
			occurrences as occurrences_int32
		end
	COLLECTION_INT32

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_INT32"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INT32"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_INT32"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_INT32"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INT32"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INT32"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_INT32"
		alias
			"count"
		end

	insert (v: INTEGER; pos: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAYED_LIST_INT32"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INT32"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_INT32"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INT32"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_INT32

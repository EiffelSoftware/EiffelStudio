indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_INTPTR"

deferred external class
	ARRAYED_LIST_INTPTR

inherit
	ARRAY_INTPTR
		rename
			force as force_int_ptr_int32,
			occurrences as occurrences_int_ptr,
			item as item_int322
		end
	SEQUENCE_INTPTR
	ACTIVE_INTPTR
		rename
			occurrences as occurrences_int_ptr,
			item as item_int_ptr
		end
	BILINEAR_INTPTR
	INDEXABLE_INTPTR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_int_ptr
		end
	TO_SPECIAL_INTPTR
		rename
			put as put_int_ptr_int322,
			item as item_int322
		end
	RESIZABLE_INTPTR
	DYNAMIC_CHAIN_INTPTR
		rename
			infix "@" as infix "@_int32"
		end
	CHAIN_INTPTR
		rename
			infix "@" as infix "@_int32"
		end
	BOUNDED_INTPTR
	COLLECTION_INTPTR
	BAG_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	TRAVERSABLE_INTPTR
	TABLE_INTPTR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_int_ptr
		end
	CONTAINER_INTPTR
	LINEAR_INTPTR
	LIST_INTPTR
		rename
			infix "@" as infix "@_int32"
		end
	BOX_INTPTR
	DYNAMIC_LIST_INTPTR
		rename
			infix "@" as infix "@_int32"
		end
	UNBOUNDED_INTPTR
	FINITE_INTPTR
	CURSOR_STRUCTURE_INTPTR
		rename
			occurrences as occurrences_int_ptr,
			item as item_int_ptr
		end

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_INTPTR"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INTPTR"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_INTPTR"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_INTPTR"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INTPTR"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INTPTR"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_INTPTR"
		alias
			"count"
		end

	insert (v: POINTER; pos: INTEGER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Void use ARRAYED_LIST_INTPTR"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INTPTR"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_INTPTR"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_INTPTR"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_INTPTR

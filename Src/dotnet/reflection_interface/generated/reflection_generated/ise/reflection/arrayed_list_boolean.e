indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_BOOLEAN"

deferred external class
	ARRAYED_LIST_BOOLEAN

inherit
	BOUNDED_BOOLEAN
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	COLLECTION_BOOLEAN
	TRAVERSABLE_BOOLEAN
	BILINEAR_BOOLEAN
	LINEAR_BOOLEAN
	CURSOR_STRUCTURE_BOOLEAN
		rename
			occurrences as occurrences_boolean,
			item as item_boolean
		end
	ARRAY_BOOLEAN
		rename
			force as force_boolean_int32,
			occurrences as occurrences_boolean,
			item as item_int322
		end
	DYNAMIC_LIST_BOOLEAN
		rename
			infix "@" as infix "@_int32"
		end
	SEQUENCE_BOOLEAN
	UNBOUNDED_BOOLEAN
	TO_SPECIAL_BOOLEAN
		rename
			put as put_boolean_int322,
			item as item_int322
		end
	LIST_BOOLEAN
		rename
			infix "@" as infix "@_int32"
		end
	TABLE_BOOLEAN_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_boolean
		end
	DYNAMIC_CHAIN_BOOLEAN
		rename
			infix "@" as infix "@_int32"
		end
	CONTAINER_BOOLEAN
	FINITE_BOOLEAN
	ACTIVE_BOOLEAN
		rename
			occurrences as occurrences_boolean,
			item as item_boolean
		end
	BOX_BOOLEAN
	CHAIN_BOOLEAN
		rename
			infix "@" as infix "@_int32"
		end
	INDEXABLE_BOOLEAN_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_boolean
		end
	RESIZABLE_BOOLEAN

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_BOOLEAN"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BOOLEAN"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_BOOLEAN"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_BOOLEAN"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BOOLEAN"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BOOLEAN"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_BOOLEAN"
		alias
			"count"
		end

	insert (v: BOOLEAN; pos: INTEGER) is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Void use ARRAYED_LIST_BOOLEAN"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BOOLEAN"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_BOOLEAN"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BOOLEAN"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_BOOLEAN

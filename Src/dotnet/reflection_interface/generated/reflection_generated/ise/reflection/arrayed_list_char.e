indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_CHAR"

deferred external class
	ARRAYED_LIST_CHAR

inherit
	RESIZABLE_CHAR
	BOX_CHAR
	CONTAINER_CHAR
	ARRAY_CHAR
		rename
			force as force_char_int32,
			occurrences as occurrences_char,
			item as item_int322
		end
	SEQUENCE_CHAR
	ACTIVE_CHAR
		rename
			occurrences as occurrences_char,
			item as item_char
		end
	TABLE_CHAR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_char
		end
	TO_SPECIAL_CHAR
		rename
			put as put_char_int322,
			item as item_int322
		end
	CURSOR_STRUCTURE_CHAR
		rename
			occurrences as occurrences_char,
			item as item_char
		end
	BOUNDED_CHAR
	LINEAR_CHAR
	FINITE_CHAR
	INDEXABLE_CHAR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_char
		end
	CHAIN_CHAR
		rename
			infix "@" as infix "@_int32"
		end
	UNBOUNDED_CHAR
	LIST_CHAR
		rename
			infix "@" as infix "@_int32"
		end
	BAG_CHAR
		rename
			occurrences as occurrences_char
		end
	BILINEAR_CHAR
	DYNAMIC_CHAIN_CHAR
		rename
			infix "@" as infix "@_int32"
		end
	TRAVERSABLE_CHAR
	COLLECTION_CHAR
	DYNAMIC_LIST_CHAR
		rename
			infix "@" as infix "@_int32"
		end

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_CHAR"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_CHAR"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_CHAR"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_CHAR"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_CHAR"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_CHAR"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_CHAR"
		alias
			"count"
		end

	insert (v: CHARACTER; pos: INTEGER) is
		external
			"IL deferred signature (System.Char, System.Int32): System.Void use ARRAYED_LIST_CHAR"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_CHAR"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_CHAR"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_CHAR"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_CHAR

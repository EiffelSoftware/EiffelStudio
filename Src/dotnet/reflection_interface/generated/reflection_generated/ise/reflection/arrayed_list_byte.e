indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAYED_LIST_BYTE"

deferred external class
	ARRAYED_LIST_BYTE

inherit
	ACTIVE_BYTE
		rename
			occurrences as occurrences_byte,
			item as item_byte
		end
	TRAVERSABLE_BYTE
	ARRAY_BYTE
		rename
			force as force_byte_int32,
			occurrences as occurrences_byte,
			item as item_int322
		end
	SEQUENCE_BYTE
	BILINEAR_BYTE
	BAG_BYTE
		rename
			occurrences as occurrences_byte
		end
	CURSOR_STRUCTURE_BYTE
		rename
			occurrences as occurrences_byte,
			item as item_byte
		end
	BOUNDED_BYTE
	TO_SPECIAL_BYTE
		rename
			put as put_byte_int322,
			item as item_int322
		end
	LIST_BYTE
		rename
			infix "@" as infix "@_int32"
		end
	TABLE_BYTE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_byte
		end
	DYNAMIC_CHAIN_BYTE
		rename
			infix "@" as infix "@_int32"
		end
	COLLECTION_BYTE
	FINITE_BYTE
	CONTAINER_BYTE
	INDEXABLE_BYTE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32,
			occurrences as occurrences_byte
		end
	CHAIN_BYTE
		rename
			infix "@" as infix "@_int32"
		end
	UNBOUNDED_BYTE
	BOX_BYTE
	RESIZABLE_BYTE
	DYNAMIC_LIST_BYTE
		rename
			infix "@" as infix "@_int32"
		end
	LINEAR_BYTE

feature -- Basic Operations

	array_index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use ARRAYED_LIST_BYTE"
		alias
			"array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BYTE"
		alias
			"make"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAYED_LIST_BYTE"
		alias
			"valid_index"
		end

	array_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_BYTE"
		alias
			"array_count"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BYTE"
		alias
			"_set_index"
		end

	set_count (new_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BYTE"
		alias
			"set_count"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_BYTE"
		alias
			"count"
		end

	insert (v: INTEGER_8; pos: INTEGER) is
		external
			"IL deferred signature (System.Byte, System.Int32): System.Void use ARRAYED_LIST_BYTE"
		alias
			"insert"
		end

	make_filled (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BYTE"
		alias
			"make_filled"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAYED_LIST_BYTE"
		alias
			"index"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAYED_LIST_BYTE"
		alias
			"_set_count"
		end

end -- class ARRAYED_LIST_BYTE

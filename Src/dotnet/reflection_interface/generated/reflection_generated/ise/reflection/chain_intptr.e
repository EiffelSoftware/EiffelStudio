indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_INTPTR"

deferred external class
	CHAIN_INTPTR

inherit
	TRAVERSABLE_INTPTR
	SEQUENCE_INTPTR
	INDEXABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			item as item_int32
		end
	ACTIVE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end
	BILINEAR_INTPTR
	COLLECTION_INTPTR
	BOX_INTPTR
	BAG_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	TABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			item as item_int32
		end
	CONTAINER_INTPTR
	LINEAR_INTPTR
	FINITE_INTPTR
	CURSOR_STRUCTURE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_INTPTR"
		alias
			"islast"
		end

	sequential_occurrences (v: POINTER): INTEGER is
		external
			"IL deferred signature (System.IntPtr): System.Int32 use CHAIN_INTPTR"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_INTPTR"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Int32 use CHAIN_INTPTR"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_INTPTR is
		external
			"IL deferred signature (System.Int32): CHAIN_INTPTR use CHAIN_INTPTR"
		alias
			"duplicate"
		end

	sequential_has (v: POINTER): BOOLEAN is
		external
			"IL deferred signature (System.IntPtr): System.Boolean use CHAIN_INTPTR"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INTPTR"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INTPTR"
		alias
			"go_i_th"
		end

	last: POINTER is
		external
			"IL deferred signature (): System.IntPtr use CHAIN_INTPTR"
		alias
			"last"
		end

	sequence_put (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use CHAIN_INTPTR"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_INTPTR"
		alias
			"isfirst"
		end

	bag_put (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use CHAIN_INTPTR"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INTPTR"
		alias
			"swap"
		end

	first: POINTER is
		external
			"IL deferred signature (): System.IntPtr use CHAIN_INTPTR"
		alias
			"first"
		end

end -- class CHAIN_INTPTR

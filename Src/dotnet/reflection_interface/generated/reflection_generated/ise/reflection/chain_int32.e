indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_INT32"

deferred external class
	CHAIN_INT32

inherit
	CONTAINER_INT32
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end
	BILINEAR_INT32
	TABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int322
		end
	ACTIVE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	CURSOR_STRUCTURE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	BOX_INT32
	FINITE_INT32
	SEQUENCE_INT32
	TRAVERSABLE_INT32
	LINEAR_INT32
	INDEXABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int322
		end
	COLLECTION_INT32

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_INT32"
		alias
			"islast"
		end

	sequential_occurrences (v: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use CHAIN_INT32"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_INT32"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Int32 use CHAIN_INT32"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_INT32 is
		external
			"IL deferred signature (System.Int32): CHAIN_INT32 use CHAIN_INT32"
		alias
			"duplicate"
		end

	sequential_has (v: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_INT32"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INT32"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INT32"
		alias
			"go_i_th"
		end

	last: INTEGER is
		external
			"IL deferred signature (): System.Int32 use CHAIN_INT32"
		alias
			"last"
		end

	sequence_put (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INT32"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_INT32"
		alias
			"isfirst"
		end

	bag_put (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INT32"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_INT32"
		alias
			"swap"
		end

	first: INTEGER is
		external
			"IL deferred signature (): System.Int32 use CHAIN_INT32"
		alias
			"first"
		end

end -- class CHAIN_INT32

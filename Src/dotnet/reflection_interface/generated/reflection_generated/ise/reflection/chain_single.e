indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_SINGLE"

deferred external class
	CHAIN_SINGLE

inherit
	BOX_SINGLE
	CONTAINER_SINGLE
	TRAVERSABLE_SINGLE
	LINEAR_SINGLE
	FINITE_SINGLE
	BILINEAR_SINGLE
	SEQUENCE_SINGLE
	INDEXABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			item as item_int32
		end
	ACTIVE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single
		end
	TABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			item as item_int32
		end
	BAG_SINGLE
		rename
			occurrences as occurrences_single
		end
	COLLECTION_SINGLE
	CURSOR_STRUCTURE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single
		end

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_SINGLE"
		alias
			"islast"
		end

	sequential_occurrences (v: REAL): INTEGER is
		external
			"IL deferred signature (System.Single): System.Int32 use CHAIN_SINGLE"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_SINGLE"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: REAL; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Single, System.Int32): System.Int32 use CHAIN_SINGLE"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_SINGLE is
		external
			"IL deferred signature (System.Int32): CHAIN_SINGLE use CHAIN_SINGLE"
		alias
			"duplicate"
		end

	sequential_has (v: REAL): BOOLEAN is
		external
			"IL deferred signature (System.Single): System.Boolean use CHAIN_SINGLE"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_SINGLE"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_SINGLE"
		alias
			"go_i_th"
		end

	last: REAL is
		external
			"IL deferred signature (): System.Single use CHAIN_SINGLE"
		alias
			"last"
		end

	sequence_put (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use CHAIN_SINGLE"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_SINGLE"
		alias
			"isfirst"
		end

	bag_put (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use CHAIN_SINGLE"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_SINGLE"
		alias
			"swap"
		end

	first: REAL is
		external
			"IL deferred signature (): System.Single use CHAIN_SINGLE"
		alias
			"first"
		end

end -- class CHAIN_SINGLE

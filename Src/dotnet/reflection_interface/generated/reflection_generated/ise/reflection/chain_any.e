indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_ANY"

deferred external class
	CHAIN_ANY

inherit
	SEQUENCE_ANY
	CONTAINER_ANY
	CURSOR_STRUCTURE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	FINITE_ANY
	INDEXABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			item as item_int32
		end
	BOX_ANY
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	TRAVERSABLE_ANY
	ACTIVE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	COLLECTION_ANY
	LINEAR_ANY
	TABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			item as item_int32
		end
	BILINEAR_ANY

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_ANY"
		alias
			"islast"
		end

	sequential_occurrences (v: ANY): INTEGER is
		external
			"IL deferred signature (ANY): System.Int32 use CHAIN_ANY"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_ANY"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL deferred signature (ANY, System.Int32): System.Int32 use CHAIN_ANY"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_ANY is
		external
			"IL deferred signature (System.Int32): CHAIN_ANY use CHAIN_ANY"
		alias
			"duplicate"
		end

	sequential_has (v: ANY): BOOLEAN is
		external
			"IL deferred signature (ANY): System.Boolean use CHAIN_ANY"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_ANY"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_ANY"
		alias
			"go_i_th"
		end

	last: ANY is
		external
			"IL deferred signature (): ANY use CHAIN_ANY"
		alias
			"last"
		end

	sequence_put (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use CHAIN_ANY"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_ANY"
		alias
			"isfirst"
		end

	bag_put (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use CHAIN_ANY"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_ANY"
		alias
			"swap"
		end

	first: ANY is
		external
			"IL deferred signature (): ANY use CHAIN_ANY"
		alias
			"first"
		end

end -- class CHAIN_ANY

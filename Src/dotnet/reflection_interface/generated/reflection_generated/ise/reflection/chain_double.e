indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_DOUBLE"

deferred external class
	CHAIN_DOUBLE

inherit
	INDEXABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			item as item_int32
		end
	BILINEAR_DOUBLE
	ACTIVE_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double
		end
	COLLECTION_DOUBLE
	LINEAR_DOUBLE
	BAG_DOUBLE
		rename
			occurrences as occurrences_double
		end
	BOX_DOUBLE
	SEQUENCE_DOUBLE
	TRAVERSABLE_DOUBLE
	FINITE_DOUBLE
	CURSOR_STRUCTURE_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double
		end
	CONTAINER_DOUBLE
	TABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			item as item_int32
		end

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_DOUBLE"
		alias
			"islast"
		end

	sequential_occurrences (v: DOUBLE): INTEGER is
		external
			"IL deferred signature (System.Double): System.Int32 use CHAIN_DOUBLE"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_DOUBLE"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Double, System.Int32): System.Int32 use CHAIN_DOUBLE"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_DOUBLE is
		external
			"IL deferred signature (System.Int32): CHAIN_DOUBLE use CHAIN_DOUBLE"
		alias
			"duplicate"
		end

	sequential_has (v: DOUBLE): BOOLEAN is
		external
			"IL deferred signature (System.Double): System.Boolean use CHAIN_DOUBLE"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_DOUBLE"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_DOUBLE"
		alias
			"go_i_th"
		end

	last: DOUBLE is
		external
			"IL deferred signature (): System.Double use CHAIN_DOUBLE"
		alias
			"last"
		end

	sequence_put (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use CHAIN_DOUBLE"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_DOUBLE"
		alias
			"isfirst"
		end

	bag_put (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use CHAIN_DOUBLE"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_DOUBLE"
		alias
			"swap"
		end

	first: DOUBLE is
		external
			"IL deferred signature (): System.Double use CHAIN_DOUBLE"
		alias
			"first"
		end

end -- class CHAIN_DOUBLE

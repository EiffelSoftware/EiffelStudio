indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_BOOLEAN"

deferred external class
	CHAIN_BOOLEAN

inherit
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	BILINEAR_BOOLEAN
	LINEAR_BOOLEAN
	ACTIVE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	TRAVERSABLE_BOOLEAN
	FINITE_BOOLEAN
	TABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			item as item_int32
		end
	CONTAINER_BOOLEAN
	COLLECTION_BOOLEAN
	SEQUENCE_BOOLEAN
	CURSOR_STRUCTURE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	INDEXABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			item as item_int32
		end
	BOX_BOOLEAN

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_BOOLEAN"
		alias
			"islast"
		end

	sequential_occurrences (v: BOOLEAN): INTEGER is
		external
			"IL deferred signature (System.Boolean): System.Int32 use CHAIN_BOOLEAN"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_BOOLEAN"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Int32 use CHAIN_BOOLEAN"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_BOOLEAN is
		external
			"IL deferred signature (System.Int32): CHAIN_BOOLEAN use CHAIN_BOOLEAN"
		alias
			"duplicate"
		end

	sequential_has (v: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Boolean): System.Boolean use CHAIN_BOOLEAN"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_BOOLEAN"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_BOOLEAN"
		alias
			"go_i_th"
		end

	last: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_BOOLEAN"
		alias
			"last"
		end

	sequence_put (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use CHAIN_BOOLEAN"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_BOOLEAN"
		alias
			"isfirst"
		end

	bag_put (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use CHAIN_BOOLEAN"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_BOOLEAN"
		alias
			"swap"
		end

	first: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_BOOLEAN"
		alias
			"first"
		end

end -- class CHAIN_BOOLEAN

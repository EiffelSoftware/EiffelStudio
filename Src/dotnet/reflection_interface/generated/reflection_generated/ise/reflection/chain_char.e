indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_CHAR"

deferred external class
	CHAIN_CHAR

inherit
	BOX_CHAR
	CONTAINER_CHAR
	SEQUENCE_CHAR
	TABLE_CHAR_INT32
		rename
			occurrences as occurrences_char,
			item as item_int32
		end
	CURSOR_STRUCTURE_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char
		end
	LINEAR_CHAR
	BAG_CHAR
		rename
			occurrences as occurrences_char
		end
	INDEXABLE_CHAR_INT32
		rename
			occurrences as occurrences_char,
			item as item_int32
		end
	FINITE_CHAR
	ACTIVE_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char
		end
	BILINEAR_CHAR
	TRAVERSABLE_CHAR
	COLLECTION_CHAR

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_CHAR"
		alias
			"islast"
		end

	sequential_occurrences (v: CHARACTER): INTEGER is
		external
			"IL deferred signature (System.Char): System.Int32 use CHAIN_CHAR"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_CHAR"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Char, System.Int32): System.Int32 use CHAIN_CHAR"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_CHAR is
		external
			"IL deferred signature (System.Int32): CHAIN_CHAR use CHAIN_CHAR"
		alias
			"duplicate"
		end

	sequential_has (v: CHARACTER): BOOLEAN is
		external
			"IL deferred signature (System.Char): System.Boolean use CHAIN_CHAR"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_CHAR"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_CHAR"
		alias
			"go_i_th"
		end

	last: CHARACTER is
		external
			"IL deferred signature (): System.Char use CHAIN_CHAR"
		alias
			"last"
		end

	sequence_put (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use CHAIN_CHAR"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_CHAR"
		alias
			"isfirst"
		end

	bag_put (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use CHAIN_CHAR"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_CHAR"
		alias
			"swap"
		end

	first: CHARACTER is
		external
			"IL deferred signature (): System.Char use CHAIN_CHAR"
		alias
			"first"
		end

end -- class CHAIN_CHAR

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CHAIN_BYTE"

deferred external class
	CHAIN_BYTE

inherit
	LINEAR_BYTE
	SEQUENCE_BYTE
	BILINEAR_BYTE
	BAG_BYTE
		rename
			occurrences as occurrences_byte
		end
	CURSOR_STRUCTURE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
	COLLECTION_BYTE
	TRAVERSABLE_BYTE
	TABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			item as item_int32
		end
	FINITE_BYTE
	CONTAINER_BYTE
	INDEXABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			item as item_int32
		end
	ACTIVE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
	BOX_BYTE

feature -- Basic Operations

	islast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_BYTE"
		alias
			"islast"
		end

	sequential_occurrences (v: INTEGER_8): INTEGER is
		external
			"IL deferred signature (System.Byte): System.Int32 use CHAIN_BYTE"
		alias
			"sequential_occurrences"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use CHAIN_BYTE"
		alias
			"valid_cursor_index"
		end

	sequential_index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte, System.Int32): System.Int32 use CHAIN_BYTE"
		alias
			"sequential_index_of"
		end

	duplicate (n: INTEGER): CHAIN_BYTE is
		external
			"IL deferred signature (System.Int32): CHAIN_BYTE use CHAIN_BYTE"
		alias
			"duplicate"
		end

	sequential_has (v: INTEGER_8): BOOLEAN is
		external
			"IL deferred signature (System.Byte): System.Boolean use CHAIN_BYTE"
		alias
			"sequential_has"
		end

	move (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_BYTE"
		alias
			"move"
		end

	go_i_th (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_BYTE"
		alias
			"go_i_th"
		end

	last: INTEGER_8 is
		external
			"IL deferred signature (): System.Byte use CHAIN_BYTE"
		alias
			"last"
		end

	sequence_put (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use CHAIN_BYTE"
		alias
			"sequence_put"
		end

	isfirst: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CHAIN_BYTE"
		alias
			"isfirst"
		end

	bag_put (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use CHAIN_BYTE"
		alias
			"bag_put"
		end

	swap (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CHAIN_BYTE"
		alias
			"swap"
		end

	first: INTEGER_8 is
		external
			"IL deferred signature (): System.Byte use CHAIN_BYTE"
		alias
			"first"
		end

end -- class CHAIN_BYTE

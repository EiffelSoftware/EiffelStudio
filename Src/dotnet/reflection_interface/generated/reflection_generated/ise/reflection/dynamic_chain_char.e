indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_CHAR"

deferred external class
	DYNAMIC_CHAIN_CHAR

inherit
	CHAIN_CHAR
	BOX_CHAR
	CONTAINER_CHAR
	SEQUENCE_CHAR
	TABLE_CHAR_INT32
		rename
			occurrences as occurrences_char,
			item as item_int32
		end
	UNBOUNDED_CHAR
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

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_CHAR"
		alias
			"remove_right"
		end

	put_left (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use DYNAMIC_CHAIN_CHAR"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_CHAR) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_CHAR): System.Void use DYNAMIC_CHAIN_CHAR"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_CHAR) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_CHAR): System.Void use DYNAMIC_CHAIN_CHAR"
		alias
			"merge_right"
		end

	put_right (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use DYNAMIC_CHAIN_CHAR"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_CHAR"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_CHAR is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_CHAR use DYNAMIC_CHAIN_CHAR"
		alias
			"new_chain"
		end

	put_front (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use DYNAMIC_CHAIN_CHAR"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_CHAR

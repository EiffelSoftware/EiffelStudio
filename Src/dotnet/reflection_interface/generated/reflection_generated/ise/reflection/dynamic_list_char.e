indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_CHAR"

deferred external class
	DYNAMIC_LIST_CHAR

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
	LIST_CHAR
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
	DYNAMIC_CHAIN_CHAR

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_CHAR"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_CHAR

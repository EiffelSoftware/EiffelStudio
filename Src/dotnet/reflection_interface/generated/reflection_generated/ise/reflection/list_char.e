indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LIST_CHAR"

deferred external class
	LIST_CHAR

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

end -- class LIST_CHAR

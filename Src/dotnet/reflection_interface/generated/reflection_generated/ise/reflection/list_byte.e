indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LIST_BYTE"

deferred external class
	LIST_BYTE

inherit
	ACTIVE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
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
	LINEAR_BYTE
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
	CHAIN_BYTE
	BOX_BYTE

end -- class LIST_BYTE

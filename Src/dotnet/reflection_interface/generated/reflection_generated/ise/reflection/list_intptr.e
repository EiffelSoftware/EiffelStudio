indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LIST_INTPTR"

deferred external class
	LIST_INTPTR

inherit
	TRAVERSABLE_INTPTR
	SEQUENCE_INTPTR
	INDEXABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			item as item_int32
		end
	ACTIVE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end
	BILINEAR_INTPTR
	COLLECTION_INTPTR
	CHAIN_INTPTR
	BAG_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	TABLE_INTPTR_INT32
		rename
			occurrences as occurrences_int_ptr,
			item as item_int32
		end
	CONTAINER_INTPTR
	BOX_INTPTR
	LINEAR_INTPTR
	FINITE_INTPTR
	CURSOR_STRUCTURE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end

end -- class LIST_INTPTR

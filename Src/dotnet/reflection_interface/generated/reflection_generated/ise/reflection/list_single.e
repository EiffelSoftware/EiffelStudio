indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LIST_SINGLE"

deferred external class
	LIST_SINGLE

inherit
	SEQUENCE_SINGLE
	TABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			item as item_int32
		end
	BOX_SINGLE
	CONTAINER_SINGLE
	LINEAR_SINGLE
	FINITE_SINGLE
	BILINEAR_SINGLE
	ACTIVE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single
		end
	INDEXABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			item as item_int32
		end
	TRAVERSABLE_SINGLE
	CHAIN_SINGLE
	BAG_SINGLE
		rename
			occurrences as occurrences_single
		end
	COLLECTION_SINGLE
	CURSOR_STRUCTURE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single
		end

end -- class LIST_SINGLE

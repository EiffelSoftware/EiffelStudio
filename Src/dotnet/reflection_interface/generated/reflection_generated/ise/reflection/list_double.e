indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LIST_DOUBLE"

deferred external class
	LIST_DOUBLE

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
	CHAIN_DOUBLE
	CONTAINER_DOUBLE
	TABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			item as item_int32
		end

end -- class LIST_DOUBLE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LIST_BOOLEAN"

deferred external class
	LIST_BOOLEAN

inherit
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	BILINEAR_BOOLEAN
	BOX_BOOLEAN
	LINEAR_BOOLEAN
	SEQUENCE_BOOLEAN
	TRAVERSABLE_BOOLEAN
	FINITE_BOOLEAN
	TABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			item as item_int32
		end
	CONTAINER_BOOLEAN
	COLLECTION_BOOLEAN
	ACTIVE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	CURSOR_STRUCTURE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	CHAIN_BOOLEAN
	INDEXABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			item as item_int32
		end

end -- class LIST_BOOLEAN

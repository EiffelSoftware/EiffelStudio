indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_BOOLEAN"

deferred external class
	DYNAMIC_LIST_BOOLEAN

inherit
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	LIST_BOOLEAN
	TRAVERSABLE_BOOLEAN
	BOX_BOOLEAN
	LINEAR_BOOLEAN
	SEQUENCE_BOOLEAN
	UNBOUNDED_BOOLEAN
	BILINEAR_BOOLEAN
	FINITE_BOOLEAN
	TABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			item as item_int32
		end
	DYNAMIC_CHAIN_BOOLEAN
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

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_BOOLEAN"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_BOOLEAN

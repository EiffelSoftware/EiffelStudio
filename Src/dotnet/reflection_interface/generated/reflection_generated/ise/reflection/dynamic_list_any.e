indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_ANY"

deferred external class
	DYNAMIC_LIST_ANY

inherit
	CONTAINER_ANY
	CURSOR_STRUCTURE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	SEQUENCE_ANY
	INDEXABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			item as item_int32
		end
	CHAIN_ANY
	FINITE_ANY
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	TRAVERSABLE_ANY
	LIST_ANY
	DYNAMIC_CHAIN_ANY
	ACTIVE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	BOX_ANY
	COLLECTION_ANY
	LINEAR_ANY
	UNBOUNDED_ANY
	TABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			item as item_int32
		end
	BILINEAR_ANY

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_ANY"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_ANY

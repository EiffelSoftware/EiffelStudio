indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_INT32"

deferred external class
	DYNAMIC_LIST_INT32

inherit
	CONTAINER_INT32
	LIST_INT32
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end
	BILINEAR_INT32
	TABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int322
		end
	ACTIVE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	DYNAMIC_CHAIN_INT32
	CURSOR_STRUCTURE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	BOX_INT32
	FINITE_INT32
	CHAIN_INT32
	SEQUENCE_INT32
	TRAVERSABLE_INT32
	UNBOUNDED_INT32
	LINEAR_INT32
	INDEXABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int322
		end
	COLLECTION_INT32

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_INT32"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_INT32

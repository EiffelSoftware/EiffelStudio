indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_SINGLE"

deferred external class
	DYNAMIC_LIST_SINGLE

inherit
	SEQUENCE_SINGLE
	TABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			item as item_int32
		end
	BOX_SINGLE
	LIST_SINGLE
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
	UNBOUNDED_SINGLE
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
	DYNAMIC_CHAIN_SINGLE

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_SINGLE"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_SINGLE

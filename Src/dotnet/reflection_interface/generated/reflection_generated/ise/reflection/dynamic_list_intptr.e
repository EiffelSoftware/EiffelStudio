indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_INTPTR"

deferred external class
	DYNAMIC_LIST_INTPTR

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
	DYNAMIC_CHAIN_INTPTR
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
	LIST_INTPTR
	BOX_INTPTR
	LINEAR_INTPTR
	UNBOUNDED_INTPTR
	FINITE_INTPTR
	CURSOR_STRUCTURE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_INTPTR"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_INTPTR

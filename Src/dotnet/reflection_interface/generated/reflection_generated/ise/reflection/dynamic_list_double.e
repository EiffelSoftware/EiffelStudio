indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_DOUBLE"

deferred external class
	DYNAMIC_LIST_DOUBLE

inherit
	DYNAMIC_CHAIN_DOUBLE
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
	TABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			item as item_int32
		end
	SEQUENCE_DOUBLE
	BOX_DOUBLE
	TRAVERSABLE_DOUBLE
	FINITE_DOUBLE
	UNBOUNDED_DOUBLE
	CURSOR_STRUCTURE_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double
		end
	CHAIN_DOUBLE
	CONTAINER_DOUBLE
	LIST_DOUBLE

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_DOUBLE"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_DOUBLE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COUNTABLE_SEQUENCE_INT32"

deferred external class
	COUNTABLE_SEQUENCE_INT32

inherit
	CONTAINER_INT32
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end
	BOX_INT32
	ACTIVE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	TRAVERSABLE_INT32
	COUNTABLE_INT32
		rename
			item as item_int322
		end
	INFINITE_INT32
	LINEAR_INT32
	COLLECTION_INT32

feature -- Basic Operations

	a_set_index (index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use COUNTABLE_SEQUENCE_INT32"
		alias
			"_set_index"
		end

	index_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use COUNTABLE_SEQUENCE_INT32"
		alias
			"index"
		end

end -- class COUNTABLE_SEQUENCE_INT32

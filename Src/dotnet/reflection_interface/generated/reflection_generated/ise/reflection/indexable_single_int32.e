indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "INDEXABLE_SINGLE_INT32"

deferred external class
	INDEXABLE_SINGLE_INT32

inherit
	CONTAINER_SINGLE
	COLLECTION_SINGLE
	TABLE_SINGLE_INT32
	BAG_SINGLE

feature -- Basic Operations

	index_set: INTEGER_INTERVAL is
		external
			"IL deferred signature (): INTEGER_INTERVAL use INDEXABLE_SINGLE_INT32"
		alias
			"index_set"
		end

end -- class INDEXABLE_SINGLE_INT32

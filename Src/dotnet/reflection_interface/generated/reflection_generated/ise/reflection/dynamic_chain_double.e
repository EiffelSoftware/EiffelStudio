indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_DOUBLE"

deferred external class
	DYNAMIC_CHAIN_DOUBLE

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
	UNBOUNDED_DOUBLE
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

feature -- Basic Operations

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_DOUBLE"
		alias
			"remove_right"
		end

	put_left (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use DYNAMIC_CHAIN_DOUBLE"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_DOUBLE) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_DOUBLE): System.Void use DYNAMIC_CHAIN_DOUBLE"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_DOUBLE) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_DOUBLE): System.Void use DYNAMIC_CHAIN_DOUBLE"
		alias
			"merge_right"
		end

	put_right (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use DYNAMIC_CHAIN_DOUBLE"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_DOUBLE"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_DOUBLE is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_DOUBLE use DYNAMIC_CHAIN_DOUBLE"
		alias
			"new_chain"
		end

	put_front (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use DYNAMIC_CHAIN_DOUBLE"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_DOUBLE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_ANY"

deferred external class
	DYNAMIC_CHAIN_ANY

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

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_ANY"
		alias
			"remove_right"
		end

	put_left (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use DYNAMIC_CHAIN_ANY"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_ANY): System.Void use DYNAMIC_CHAIN_ANY"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_ANY): System.Void use DYNAMIC_CHAIN_ANY"
		alias
			"merge_right"
		end

	put_right (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use DYNAMIC_CHAIN_ANY"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_ANY"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_ANY is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_ANY use DYNAMIC_CHAIN_ANY"
		alias
			"new_chain"
		end

	put_front (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use DYNAMIC_CHAIN_ANY"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_ANY

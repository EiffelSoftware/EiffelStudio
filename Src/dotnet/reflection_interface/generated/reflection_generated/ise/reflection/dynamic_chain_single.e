indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_SINGLE"

deferred external class
	DYNAMIC_CHAIN_SINGLE

inherit
	SEQUENCE_SINGLE
	TABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			item as item_int32
		end
	BOX_SINGLE
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

feature -- Basic Operations

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_SINGLE"
		alias
			"remove_right"
		end

	put_left (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use DYNAMIC_CHAIN_SINGLE"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_SINGLE) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_SINGLE): System.Void use DYNAMIC_CHAIN_SINGLE"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_SINGLE) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_SINGLE): System.Void use DYNAMIC_CHAIN_SINGLE"
		alias
			"merge_right"
		end

	put_right (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use DYNAMIC_CHAIN_SINGLE"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_SINGLE"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_SINGLE is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_SINGLE use DYNAMIC_CHAIN_SINGLE"
		alias
			"new_chain"
		end

	put_front (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use DYNAMIC_CHAIN_SINGLE"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_SINGLE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_INT32"

deferred external class
	DYNAMIC_CHAIN_INT32

inherit
	CONTAINER_INT32
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
	UNBOUNDED_INT32
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
	LINEAR_INT32
	INDEXABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int322
		end
	COLLECTION_INT32

feature -- Basic Operations

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_INT32"
		alias
			"remove_right"
		end

	put_left (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use DYNAMIC_CHAIN_INT32"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_INT32) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_INT32): System.Void use DYNAMIC_CHAIN_INT32"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_INT32) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_INT32): System.Void use DYNAMIC_CHAIN_INT32"
		alias
			"merge_right"
		end

	put_right (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use DYNAMIC_CHAIN_INT32"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_INT32"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_INT32 is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_INT32 use DYNAMIC_CHAIN_INT32"
		alias
			"new_chain"
		end

	put_front (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use DYNAMIC_CHAIN_INT32"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_INT32

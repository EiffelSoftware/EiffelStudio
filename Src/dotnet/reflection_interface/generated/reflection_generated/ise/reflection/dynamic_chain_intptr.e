indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_INTPTR"

deferred external class
	DYNAMIC_CHAIN_INTPTR

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

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_INTPTR"
		alias
			"remove_right"
		end

	put_left (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use DYNAMIC_CHAIN_INTPTR"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_INTPTR) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_INTPTR): System.Void use DYNAMIC_CHAIN_INTPTR"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_INTPTR) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_INTPTR): System.Void use DYNAMIC_CHAIN_INTPTR"
		alias
			"merge_right"
		end

	put_right (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use DYNAMIC_CHAIN_INTPTR"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_INTPTR"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_INTPTR is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_INTPTR use DYNAMIC_CHAIN_INTPTR"
		alias
			"new_chain"
		end

	put_front (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use DYNAMIC_CHAIN_INTPTR"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_INTPTR

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_LIST_BYTE"

deferred external class
	DYNAMIC_LIST_BYTE

inherit
	LINEAR_BYTE
	TRAVERSABLE_BYTE
	SEQUENCE_BYTE
	BILINEAR_BYTE
	BAG_BYTE
		rename
			occurrences as occurrences_byte
		end
	CURSOR_STRUCTURE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
	COLLECTION_BYTE
	DYNAMIC_CHAIN_BYTE
	LIST_BYTE
	ACTIVE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
	FINITE_BYTE
	CONTAINER_BYTE
	INDEXABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			item as item_int32
		end
	CHAIN_BYTE
	TABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			item as item_int32
		end
	UNBOUNDED_BYTE
	BOX_BYTE

feature -- Basic Operations

	chain_wipe_out is
		external
			"IL deferred signature (): System.Void use DYNAMIC_LIST_BYTE"
		alias
			"chain_wipe_out"
		end

end -- class DYNAMIC_LIST_BYTE

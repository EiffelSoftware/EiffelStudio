indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_BYTE"

deferred external class
	DYNAMIC_CHAIN_BYTE

inherit
	ACTIVE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
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
	LINEAR_BYTE
	TRAVERSABLE_BYTE
	TABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			item as item_int32
		end
	FINITE_BYTE
	CONTAINER_BYTE
	INDEXABLE_BYTE_INT32
		rename
			occurrences as occurrences_byte,
			item as item_int32
		end
	CHAIN_BYTE
	UNBOUNDED_BYTE
	BOX_BYTE

feature -- Basic Operations

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_BYTE"
		alias
			"remove_right"
		end

	put_left (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use DYNAMIC_CHAIN_BYTE"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_BYTE) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_BYTE): System.Void use DYNAMIC_CHAIN_BYTE"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_BYTE) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_BYTE): System.Void use DYNAMIC_CHAIN_BYTE"
		alias
			"merge_right"
		end

	put_right (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use DYNAMIC_CHAIN_BYTE"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_BYTE"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_BYTE is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_BYTE use DYNAMIC_CHAIN_BYTE"
		alias
			"new_chain"
		end

	put_front (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use DYNAMIC_CHAIN_BYTE"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_BYTE

indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "DYNAMIC_CHAIN_BOOLEAN"

deferred external class
	DYNAMIC_CHAIN_BOOLEAN

inherit
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	BILINEAR_BOOLEAN
	BOX_BOOLEAN
	LINEAR_BOOLEAN
	SEQUENCE_BOOLEAN
	UNBOUNDED_BOOLEAN
	TRAVERSABLE_BOOLEAN
	FINITE_BOOLEAN
	TABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			item as item_int32
		end
	CONTAINER_BOOLEAN
	COLLECTION_BOOLEAN
	ACTIVE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	CURSOR_STRUCTURE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	CHAIN_BOOLEAN
	INDEXABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			item as item_int32
		end

feature -- Basic Operations

	remove_right is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"remove_right"
		end

	put_left (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"put_left"
		end

	merge_left (other: DYNAMIC_CHAIN_BOOLEAN) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_BOOLEAN): System.Void use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"merge_left"
		end

	merge_right (other: DYNAMIC_CHAIN_BOOLEAN) is
		external
			"IL deferred signature (DYNAMIC_CHAIN_BOOLEAN): System.Void use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"merge_right"
		end

	put_right (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"put_right"
		end

	remove_left is
		external
			"IL deferred signature (): System.Void use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"remove_left"
		end

	new_chain: DYNAMIC_CHAIN_BOOLEAN is
		external
			"IL deferred signature (): DYNAMIC_CHAIN_BOOLEAN use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"new_chain"
		end

	put_front (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use DYNAMIC_CHAIN_BOOLEAN"
		alias
			"put_front"
		end

end -- class DYNAMIC_CHAIN_BOOLEAN

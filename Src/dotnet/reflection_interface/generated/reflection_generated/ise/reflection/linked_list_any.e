indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINKED_LIST_ANY"

deferred external class
	LINKED_LIST_ANY

inherit
	CONTAINER_ANY
	CURSOR_STRUCTURE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	SEQUENCE_ANY
	ACTIVE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	INDEXABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			item as item_int32
		end
	BOX_ANY
	FINITE_ANY
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	TRAVERSABLE_ANY
	LIST_ANY
	DYNAMIC_CHAIN_ANY
	DYNAMIC_LIST_ANY
	CHAIN_ANY
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

	a_set_before (before2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use LINKED_LIST_ANY"
		alias
			"_set_before"
		end

	new_cell (v: ANY): LINKABLE_ANY is
		external
			"IL deferred signature (ANY): LINKABLE_ANY use LINKED_LIST_ANY"
		alias
			"new_cell"
		end

	internal_wipe_out is
		external
			"IL deferred signature (): System.Void use LINKED_LIST_ANY"
		alias
			"internal_wipe_out"
		end

	make is
		external
			"IL deferred signature (): System.Void use LINKED_LIST_ANY"
		alias
			"make"
		end

	a_set_first_element (first_element2: LINKABLE_ANY) is
		external
			"IL deferred signature (LINKABLE_ANY): System.Void use LINKED_LIST_ANY"
		alias
			"_set_first_element"
		end

	cleanup_after_remove (v: LINKABLE_ANY) is
		external
			"IL deferred signature (LINKABLE_ANY): System.Void use LINKED_LIST_ANY"
		alias
			"cleanup_after_remove"
		end

	last_element: LINKABLE_ANY is
		external
			"IL deferred signature (): LINKABLE_ANY use LINKED_LIST_ANY"
		alias
			"last_element"
		end

	active: LINKABLE_ANY is
		external
			"IL deferred signature (): LINKABLE_ANY use LINKED_LIST_ANY"
		alias
			"active"
		end

	previous: LINKABLE_ANY is
		external
			"IL deferred signature (): LINKABLE_ANY use LINKED_LIST_ANY"
		alias
			"previous"
		end

	a_set_active (active2: LINKABLE_ANY) is
		external
			"IL deferred signature (LINKABLE_ANY): System.Void use LINKED_LIST_ANY"
		alias
			"_set_active"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use LINKED_LIST_ANY"
		alias
			"_set_count"
		end

	a_set_after (after2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use LINKED_LIST_ANY"
		alias
			"_set_after"
		end

	before_boolean: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINKED_LIST_ANY"
		alias
			"before"
		end

	next: LINKABLE_ANY is
		external
			"IL deferred signature (): LINKABLE_ANY use LINKED_LIST_ANY"
		alias
			"next"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINKED_LIST_ANY"
		alias
			"count"
		end

	first_element: LINKABLE_ANY is
		external
			"IL deferred signature (): LINKABLE_ANY use LINKED_LIST_ANY"
		alias
			"first_element"
		end

	after_boolean: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINKED_LIST_ANY"
		alias
			"after"
		end

end -- class LINKED_LIST_ANY

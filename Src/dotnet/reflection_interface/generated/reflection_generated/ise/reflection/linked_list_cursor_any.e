indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINKED_LIST_CURSOR_ANY"

deferred external class
	LINKED_LIST_CURSOR_ANY

inherit
	CURSOR

feature -- Basic Operations

	a_set_before (before2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use LINKED_LIST_CURSOR_ANY"
		alias
			"_set_before"
		end

	make (active_element: LINKABLE_ANY; aft: BOOLEAN; bef: BOOLEAN) is
		external
			"IL deferred signature (LINKABLE_ANY, System.Boolean, System.Boolean): System.Void use LINKED_LIST_CURSOR_ANY"
		alias
			"make"
		end

	active: LINKABLE_ANY is
		external
			"IL deferred signature (): LINKABLE_ANY use LINKED_LIST_CURSOR_ANY"
		alias
			"active"
		end

	before: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINKED_LIST_CURSOR_ANY"
		alias
			"before"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINKED_LIST_CURSOR_ANY"
		alias
			"after"
		end

	a_set_active (active2: LINKABLE_ANY) is
		external
			"IL deferred signature (LINKABLE_ANY): System.Void use LINKED_LIST_CURSOR_ANY"
		alias
			"_set_active"
		end

	a_set_after (after2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use LINKED_LIST_CURSOR_ANY"
		alias
			"_set_after"
		end

end -- class LINKED_LIST_CURSOR_ANY

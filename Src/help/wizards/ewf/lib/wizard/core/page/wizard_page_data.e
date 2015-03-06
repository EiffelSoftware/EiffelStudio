note
	description: "Summary description for {WIZARD_PAGE_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PAGE_DATA

inherit
	TABLE_ITERABLE [READABLE_STRING_32, READABLE_STRING_GENERAL]

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_page_id: READABLE_STRING_8)
		do
			page_id := a_page_id
			create items.make_caseless (0)
		end

feature -- Access

	page_id: READABLE_STRING_8
			-- Associated page id.

	item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			Result := items.item (k)
		end

	boolean_item (k: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached item (k) as v then
				Result := v.is_case_insensitive_equal_general ("yes") or
						v.is_case_insensitive_equal_general ("true") or
						v.is_case_insensitive_equal_general ("on")
			end
		end

	items: STRING_TABLE [READABLE_STRING_32]

	count: INTEGER
		do
			Result := items.count
		end

	new_cursor: HASH_TABLE_ITERATION_CURSOR [READABLE_STRING_32, READABLE_STRING_GENERAL]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Status report

	has (k: READABLE_STRING_GENERAL): BOOLEAN
			-- Has item indexed by `k'?
		do
			Result := items.has (k)
		end

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string_general (page_id)
			Result.append (" count=")
			Result.append_integer (count)
		end

feature -- Change

	put (v: READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		do
			items.put (v, k)
		end

	force (v: READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		do
			items.force (v, k)
		end

	remove (k: READABLE_STRING_GENERAL)
		do
			items.remove (k)
		end

end

indexing
	description: "[
	 	Captured eiffel object defined through a number of items. This is currently used for {TUPLE} or
	 	    {SPECIAL} objects.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_CAPTURED_ITEM_OBJECT

inherit
	EIFFEL_TEST_CAPTURED_OBJECT
		redefine
			has_items,
			items
		end

create
	make

feature {NONE} -- Initialization

	make (a_id: like id; a_type: like type; a_count: INTEGER)
			-- Initialize `Current'.
			--
			-- `a_id': Identifier for object.
			-- `a_type': Full type name of captured object
			-- `a_count': Expected number of items
		do
			make_object (a_id, a_type)
			create {!DS_ARRAYED_LIST [!STRING]} items.make (a_count)
		end

feature -- Access

	items: !DS_LIST [!STRING]

feature -- Status report

	has_items: BOOLEAN = True
			-- <Precursor>

end

indexing
	description: "[
		Captured eiffel object containing arbitrary attributes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CAPTURED_ATTRIBUTE_OBJECT

inherit
	TEST_CAPTURED_OBJECT
		redefine
			has_attributes,
			attributes
		end

create
	make

feature {NONE} -- Initialization

	make (a_id: like id; a_type: like type; a_count: INTEGER)
			-- Initialize `Current'.
			--
			-- `a_id': Identifier for object.
			-- `a_type': Full type name of captured object
			-- `a_count': Expected number of attributes
		do
			make_object (a_id, a_type)
			create attributes.make (a_count)
		end

feature -- Access

	attributes: !DS_HASH_TABLE [!STRING, !STRING]

feature -- Status report

	has_attributes: BOOLEAN = True
			-- <Precursor>


end

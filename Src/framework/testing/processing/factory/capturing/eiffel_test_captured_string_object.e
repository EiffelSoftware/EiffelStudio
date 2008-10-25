indexing
	description: "[
		Captured string object ({STRING_8} or {STRING_32}).
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_CAPTURED_STRING_OBJECT

inherit
	EIFFEL_TEST_CAPTURED_OBJECT
		redefine
			is_string,
			string
		end

create
	make

feature {NONE} -- Initialization

	make (a_id: like id; a_type: like type; a_string: like string)
			-- Initialize `Current'.
			--
			-- `a_id': Identifier for object.
			-- `a_type': Full type name of captured object
			-- `a_string': Original string
		do
			make_object (a_id, a_type)
			create string.make_from_string (a_string)
		ensure
			string_equals_a_string: string.is_equal (a_string)
		end

feature -- Access

	string: !STRING
			-- <Precursor>

feature -- Status report

	is_string: BOOLEAN = True
			-- <Precursor>

invariant
	invariant_clause: True -- Your invariant here

end

indexing
	description: "Objects that provide once access to a TEST_CONTROLLER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEST_CONTROLLER

feature -- Access

	test_controller: TEST_CONTROLLER is
			-- Once access to TEST_CONTROLLER object.
		once
			create Result
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class SHARED_TEST_CONTROLLER

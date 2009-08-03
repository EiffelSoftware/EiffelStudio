note
	description: "Tests for EV_PIXMAP"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_PIXMAP

inherit
	VISION2_TEST_SET

feature -- Test routines

	create_with_size
			-- Set the text and reads it again.
		local
			pixmap: EV_PIXMAP
		do
			create pixmap.make_with_size (123, 345)

			assert ("size_correct", pixmap.width = 123 and pixmap.height = 345)
		end

end

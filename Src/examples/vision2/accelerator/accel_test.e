indexing
	description: "Thest of accelerators (shortcut keys)."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	ACCEL_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		do
			test_accelerators
		end

	test_accelerators is
		local
			box: EV_HORIZONTAL_BOX
			tf: EV_TEXT_FIELD
			but: EV_BUTTON
		do
			create box
			create but.make_with_text ("Test")
			create tf
			box.extend (but)
			box.extend (tf)
			first_window.extend (box)
		end

end -- class ACCEL_TEST

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

	list: EV_LIST
	but: EV_BUTTON

	test_accelerators is
		local
			box: EV_HORIZONTAL_BOX
		do
			create box
			create but.make_with_text ("Test")
			but.press_actions.extend (~on_click)
			create list
			box.extend (but)
			box.extend (list)
			first_window.extend (box)
		end

	on_click is
		do
			list.extend (create {EV_LIST_ITEM}.make_with_text ("Tadaa"))
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
			Result.set_title ("Accel")
		end

end -- class ACCEL_TEST

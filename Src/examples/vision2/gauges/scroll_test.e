indexing
	description: "Test of scrollable_area."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLL_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		do
			test_scrollable_area
		end

	test_scrollable_area is
		local
			but: EV_BUTTON
		do
			create but.make_with_text ("dialog test")
			first_window.extend (but)
			but.press_actions.extend (~on_click)
		end

	on_click is
		do
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
			Result.set_title ("Main window")
			Result.show
			Result.set_size (300, 300)
		end

end -- class DIALOG_TEST

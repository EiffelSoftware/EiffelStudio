indexing
	description: "Test of tests."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DYNAMIC_LIST_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		local
			hbox_test, vbox_test: EV_LIST_TEST [EV_WIDGET]
		do
			first_window.set_title ("EV_BOX test")
			post_launch_actions.extend (~do_tests)
		end

	do_tests is
		local
			hbox_test, vbox_test: EV_LIST_TEST [EV_WIDGET]
			exeptions: EXCEPTIONS
		do
			create hbox_test.make ("EV_HORIZONTAL_BOX", ~hbox_list_generator, ~item_generator)
			create vbox_test.make ("EV_HORIZONTAL_BOX", ~vbox_list_generator, ~item_generator)
			hbox_test.execute
			vbox_test.execute
			print (hbox_test.description)
			print (vbox_test.description)
			if hbox_test.test_successful and vbox_test.test_successful then
				destroy
			else
				create exceptions
				exceptions.die (1)
			end
		end

	item_generator: EV_BUTTON is
		do
			create Result
		end

	hbox_list_generator: EV_HORIZONTAL_BOX is
		do
			create Result
		end

	vbox_list_generator: EV_VERTICAL_BOX is
		do
			create Result
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

end -- class TEST_TEST

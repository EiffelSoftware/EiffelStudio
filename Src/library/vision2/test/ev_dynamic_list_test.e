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
			(create {MEMORY}).collection_off
		end

	do_tests is
		local
			hbox_test, vbox_test, nb_test: EV_LIST_TEST [EV_WIDGET]
			ex: EXCEPTIONS
		do
			create hbox_test.make ("EV_HORIZONTAL_BOX", ~hbox_list_generator, ~item_generator)
			create vbox_test.make ("EV_VERTICAL_BOX", ~vbox_list_generator, ~item_generator)
			create nb_test.make ("EV_NOTEBOOK", ~notebook_list_generator, ~item_generator)
			hbox_test.execute
			vbox_test.execute
			nb_test.execute
			print (hbox_test.description + "%N")
			print (vbox_test.description + "%N")
			print (nb_test.description + "%N")
			if
				hbox_test.test_successful and
				vbox_test.test_successful and
				nb_test.test_successful
			then
				destroy
			else
				create ex
				ex.die (1)
			end
		end

	item_generator: EV_BUTTON is
		do
			create Result
		end

	notebook_list_generator: EV_NOTEBOOK is
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

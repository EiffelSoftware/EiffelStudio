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
			--(create {MEMORY}).collection_off
		end

	do_tests is
		local
			hbox_test, vbox_test, nb_test : EV_LIST_TEST [EV_WIDGET]
			list_test, tb_test, sb_test, mcl_test: EV_LIST_TEST [EV_ITEM]
		do
			create hbox_test.make ("EV_HORIZONTAL_BOX", ~hbox_list_generator, ~item_generator)
			create vbox_test.make ("EV_VERTICAL_BOX", ~vbox_list_generator, ~item_generator)
			create nb_test.make ("EV_NOTEBOOK", ~notebook_list_generator, ~item_generator)
			create list_test.make ("EV_LIST", ~list_list_generator, ~list_item_generator)
			create tb_test.make ("EV_TOOL_BAR", ~tb_list_generator, ~tb_item_generator)
			create sb_test.make ("EV_STATUS_BAR", ~sb_list_generator, ~sb_item_generator)
			create mcl_test.make ("EV_MULTI_COLUMN_LIST", ~mcl_list_generator, ~mcl_item_generator)
			hbox_test.execute
			vbox_test.execute
			nb_test.execute
			list_test.execute
			tb_test.execute
			sb_test.execute
			mcl_test.execute
			print (hbox_test.description + "%N")
			print (vbox_test.description + "%N")
			print (nb_test.description + "%N")
			print (list_test.description + "%N")
			print (tb_test.description + "%N")
			print (sb_test.description + "%N")
			print (mcl_test.description + "%N")
			if
				hbox_test.test_successful and
				vbox_test.test_successful and
				nb_test.test_successful and
				list_test.test_successful and
				tb_test.test_successful and
				sb_test.test_successful and
				mcl_test.test_successful
			then
				destroy
			else
				exit_one (1)
			end
		end

	exit_one is
		external
			"C [macro <stdio.h>]"
		alias
			"exit(1)"
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

	list_item_generator: EV_LIST_ITEM is
		do
			create Result
		end

	list_list_generator: EV_LIST is
		do
			create Result
		end

	tb_item_generator: EV_TOOL_BAR_BUTTON is
		do
			create Result
		end

	tb_list_generator: EV_TOOL_BAR is
		do
			create Result
		end

	sb_item_generator: EV_STATUS_BAR_ITEM is
		do
			create Result
		end

	sb_list_generator: EV_STATUS_BAR is
		do
			create Result
		end

	mcl_item_generator: EV_MULTI_COLUMN_LIST_ROW is
		do
			create Result
		end

	mcl_list_generator: EV_MULTI_COLUMN_LIST is
		do
			create Result
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

end -- class TEST_TEST

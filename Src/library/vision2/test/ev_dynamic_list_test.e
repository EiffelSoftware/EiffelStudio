indexing
	description: "Test of tests."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DYNAMIC_LIST_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	make_and_launch is
		do
			default_create
			prepare
			launch
		end

	prepare is
		local
			--hbox_test, vbox_test: EV_LIST_TEST [EV_WIDGET]
		do
			create first_window
			first_window.set_title ("EV_BOX test")
			post_launch_actions.extend (~do_tests)
			--(create {MEMORY}).collection_off
		end

	do_tests is
		local
			hbox_test, vbox_test, sb_test, nb_test, fixed_test : EV_LIST_TEST [EV_WIDGET]
			list_test, tb_test, mcl_test: EV_LIST_TEST [EV_ITEM]
			tree_test, ti_test, menu_test, mb_test: EV_LIST_TEST [EV_ITEM]
			--cb_test: EV_LIST_TEST [EV_ITEM]
		do
			create fixed_test.make ("EV_FIXED", ~fixed_list_generator, ~item_generator)
			create hbox_test.make ("EV_HORIZONTAL_BOX", ~hbox_list_generator, ~item_generator)
			create vbox_test.make ("EV_VERTICAL_BOX", ~vbox_list_generator, ~item_generator)
			create nb_test.make ("EV_NOTEBOOK", ~notebook_list_generator, ~item_generator)
			create list_test.make ("EV_LIST", ~list_list_generator, ~list_item_generator)
			create tb_test.make ("EV_TOOL_BAR", ~tb_list_generator, ~tb_item_generator)
			create mcl_test.make ("EV_MULTI_COLUMN_LIST", ~mcl_list_generator, ~mcl_item_generator)

			create tree_test.make ("EV_TREE", ~tree_generator, ~tree_item_generator)
			create ti_test.make ("EV_TREE_ITEM", ~tree_item_generator, ~tree_item_generator)
			create menu_test.make ("EV_MENU", ~menu_generator, ~menu_item_generator)
			create mb_test.make ("EV_MENU_BAR", ~menu_bar_generator, ~menu_generator)
		--	create cb_test.make ("EV_COMBO_BOX", ~cb_generator, ~list_item_generator)
			fixed_test.execute
			print (fixed_test.description + "%N")
			hbox_test.execute
			print (hbox_test.description + "%N")
			vbox_test.execute
			print (vbox_test.description + "%N")
			nb_test.execute
			print (nb_test.description + "%N")
			list_test.execute
			print (list_test.description + "%N")
			tb_test.execute
			print (tb_test.description + "%N")
			sb_test.execute
			print (sb_test.description + "%N")
			mcl_test.execute
			print (mcl_test.description + "%N")
			tree_test.execute
			print (tree_test.description + "%N")
			ti_test.execute
			print (ti_test.description + "%N")
			menu_test.execute
			print (menu_test.description + "%N")
			mb_test.execute
			print (mb_test.description + "%N")
		--	cb_test.execute
		--	print (cb_test.description + "%N")
			if
				fixed_test.test_successful and
				hbox_test.test_successful and
				vbox_test.test_successful and
				nb_test.test_successful and
				list_test.test_successful and
				tb_test.test_successful and
				sb_test.test_successful and
				mcl_test.test_successful and
				tree_test.test_successful and
				ti_test.test_successful and
				menu_test.test_successful and
				mb_test.test_successful --and
		--		cb_test.test_successful
			then
				destroy
			else
				exit_one
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

	fixed_list_generator: EV_FIXED is
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

	tree_generator: EV_TREE is
		do
			create Result
		end

	tree_item_generator: EV_TREE_ITEM is
		do
			create Result
		end

	menu_generator: EV_MENU is
		do
			create Result
		end

	menu_bar_generator: EV_MENU_BAR is
		do
			create Result
		end

	menu_item_generator: EV_MENU_ITEM is
		do
			create Result
		end

	cb_generator: EV_COMBO_BOX is
		do
			create Result
		end

	first_window: EV_TITLED_WINDOW

end -- class TEST_TEST

indexing
	description: "Test of tests."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXTABLE_TESTS

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		local
			hbox_test, vbox_test: EV_LIST_TEST [EV_WIDGET]
		do
			first_window.set_title ("EV_TEXTABLE test")
			post_launch_actions.extend (~do_tests)
			--(create {MEMORY}).collection_off
		end

	do_tests is
		local
			tests: LINKED_LIST [EV_TEXTABLE_TEST]
			tst: EV_TEXTABLE_TEST
			fail: BOOLEAN
		do
			create tests.make
			create tst.make ("EV_TREE_ITEM", create {EV_TREE_ITEM}, create {EV_TREE})
			tests.extend (tst)
			create tst.make ("EV_STATUS_BAR_ITEM", create {EV_STATUS_BAR_ITEM}, create {EV_STATUS_BAR})
			tests.extend (tst)
			create tst.make ("EV_TOOL_BAR_BUTTON", create {EV_TOOL_BAR_BUTTON}, create {EV_TOOL_BAR})
			tests.extend (tst)
			create tst.make ("EV_TOOL_BAR_TOGGLE_BUTTON", create {EV_TOOL_BAR_TOGGLE_BUTTON}, create {EV_TOOL_BAR})
			tests.extend (tst)
			create tst.make ("EV_TOOL_BAR_RADIO_BUTTON", create {EV_TOOL_BAR_RADIO_BUTTON}, create {EV_TOOL_BAR})
			tests.extend (tst)
			create tst.make ("EV_MENU_ITEM", create {EV_MENU_ITEM}, create {EV_MENU})
			tests.extend (tst)
			create tst.make ("EV_RADIO_MENU_ITEM", create {EV_RADIO_MENU_ITEM}, create {EV_MENU})
			tests.extend (tst)
			create tst.make ("EV_CHECK_MENU_ITEM", create {EV_CHECK_MENU_ITEM}, create {EV_MENU})
			tests.extend (tst)
			create tst.make ("EV_MENU", create {EV_MENU}, create {EV_MENU})
			tests.extend (tst)
			create tst.make ("EV_LIST_ITEM", create {EV_LIST_ITEM}, create {EV_LIST})
			tests.extend (tst)
			create tst.make ("EV_LABEL", create {EV_LABEL}, create {EV_HORIZONTAL_BOX})
			tests.extend (tst)
			create tst.make ("EV_FRAME", create {EV_FRAME}, create {EV_HORIZONTAL_BOX})
			tests.extend (tst)
			create tst.make ("EV_BUTTON", create {EV_BUTTON}, create {EV_HORIZONTAL_BOX})
			tests.extend (tst)
			create tst.make ("EV_RADIO_BUTTON", create {EV_RADIO_BUTTON}, create {EV_HORIZONTAL_BOX})
			tests.extend (tst)
			create tst.make ("EV_TOGGLE_BUTTON", create {EV_TOGGLE_BUTTON}, create {EV_HORIZONTAL_BOX})
			tests.extend (tst)
			create tst.make ("EV_CHECK_BUTTON", create {EV_CHECK_BUTTON}, create {EV_HORIZONTAL_BOX})
			tests.extend (tst)
			create tst.make ("EV_OPTION_BUTTON", create {EV_OPTION_BUTTON}, create {EV_HORIZONTAL_BOX})
			tests.extend (tst)

			from
				tests.start
			until
				tests.after
			loop
				tests.item.execute
				print (tests.item.description "%N")
				if not tests.item.test_successful then
					fail := True
				end
				tests.forth
			end
			if fail then
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

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

end -- class TEXTABLE_TESTS


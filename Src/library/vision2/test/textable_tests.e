indexing
	description: "Test of tests."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXTABLE_TEST

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
		do
			create first_window
			first_window.set_title ("EV_TEXTABLE test")
			post_launch_actions.extend (~do_tests)
			--(create {MEMORY}).collection_off
		end

	do_tests is
		local
			tests: LINKED_LIST [EV_TEST_TEXTABLE]
			tst: EV_TEST_TEXTABLE
			fail: BOOLEAN
			hb: EV_HORIZONTAL_BOX
		do
			create tests.make
			create tst.make_with_item ("EV_TREE_ITEM", create {EV_TREE_ITEM},
				create {EV_TREE})
			--tests.extend (tst)
			--| FIXME IEK Add when tree enable select is fixed.
			create tst.make_with_item ("EV_TOOL_BAR_BUTTON",
				create {EV_TOOL_BAR_BUTTON},
				create {EV_TOOL_BAR})
			tests.extend (tst)
			create tst.make_with_item ("EV_TOOL_BAR_TOGGLE_BUTTON",
				create {EV_TOOL_BAR_TOGGLE_BUTTON}, create {EV_TOOL_BAR})
			tests.extend (tst)
			create tst.make_with_item ("EV_TOOL_BAR_RADIO_BUTTON",
				create {EV_TOOL_BAR_RADIO_BUTTON}, create {EV_TOOL_BAR})
			tests.extend (tst)
			create tst.make_with_item ("EV_MENU_ITEM", create {EV_MENU_ITEM},
				create {EV_MENU})
			tests.extend (tst)
			create tst.make_with_item ("EV_RADIO_MENU_ITEM",
				create {EV_RADIO_MENU_ITEM},
				create {EV_MENU})
			tests.extend (tst)
			create tst.make_with_item ("EV_CHECK_MENU_ITEM",
				create {EV_CHECK_MENU_ITEM},
				create {EV_MENU})
			tests.extend (tst)
			create tst.make_with_item ("EV_MENU", create {EV_MENU},
				create {EV_MENU_BAR})
			tests.extend (tst)
			create tst.make_with_item ("EV_LIST_ITEM", create {EV_LIST_ITEM},
				create {EV_LIST})
			tests.extend (tst)
			create hb
			first_window.extend (hb)
			create tst.make_with_widget ("EV_LABEL", create {EV_LABEL}, hb)
			tests.extend (tst)
			create tst.make_with_widget ("EV_FRAME", create {EV_FRAME}, hb)
			tests.extend (tst)
			create tst.make_with_widget ("EV_BUTTON", create {EV_BUTTON}, hb)
			tests.extend (tst)
			create tst.make_with_widget ("EV_RADIO_BUTTON",
				create {EV_RADIO_BUTTON}, hb)
			tests.extend (tst)
			create tst.make_with_widget ("EV_TOGGLE_BUTTON",
				create {EV_TOGGLE_BUTTON}, hb)
			tests.extend (tst)
			create tst.make_with_widget ("EV_CHECK_BUTTON",
				create {EV_CHECK_BUTTON}, hb)
			tests.extend (tst)
			create tst.make_with_widget ("EV_OPTION_BUTTON",
				create {EV_OPTION_BUTTON}, hb)
			tests.extend (tst)

			from
				tests.start
			until
				tests.after
			loop
				tests.item.execute
				print (tests.item.description + "%N")
				if not tests.item.test_successful then
					fail := True
					print ("Failed%N")
				end
				tests.forth
			end
			if fail then
				exit_one
			else
				destroy
			end
		end

	exit_one is
		external
			"C [macro <stdio.h>]"
		alias
			"exit(1)"
		end

	first_window: EV_TITLED_WINDOW

end -- class EV_TEXTABLE_TEST


indexing
	description: "Test bed application template. To be inherited by any%
                   %application needing a menu-driven framework for TEST_SUITEs and%
                   %TEST_CASEs."
	keywords:    "test"
	revision:    "%%A%%"
	source:	"%%P%%"
	copyright:   "See notice at end of class"

deferred class TEST_APPLICATION

feature -- Template
	test_init is
			-- application-specific initialisation
   		deferred
		end

	test_suites:LINKED_LIST[TEST_SUITE] is
		deferred
		end

feature -- Access
	test_result_dir:STRING is "d:\temp"

feature -- Initialisation
	make is
		local
			suite_nr, test_case_nr, i: INTEGER
			finished_suites, finished_test_cases, all_test_cases:BOOLEAN
			test_cases:LINKED_LIST[TEST_CASE]
			suite_menu, tc_menu:MENU
			tc_menu_title, tc_menu_item:STRING
		do
			-- call the descendant class's own initialisation
			test_init

			io.new_line
			io.put_string("+-------------------------------------+%N")
			io.put_string("|                                     |%N")
			io.put_string("|     DEEP THOUGHT TEST FACILITY      |%N")
			io.put_string("|                                     |%N")
			io.put_string("+-------------------------------------+%N")
			io.new_line

			-- dummy call to force initialisation of once routines
			test_suites.start

			-- set suite menu up
			!!suite_menu.make("TEST SUITES")
			from test_suites.start suite_nr := 0 until test_suites.off loop
				suite_nr := suite_nr + 1
				suite_menu.add_item(test_suites.item.title) 
				test_suites.forth
			end

			from until finished_suites loop
				-- write a menu of test suites to the console
				suite_menu.display
				suite_menu.choose

				if suite_menu.all_selected then
					from test_suites.start until test_suites.off loop
						test_suites.item.do_all
						-- test_suites.item.display_results
						test_suites.item.store_results(test_result_dir)
						test_suites.forth
					end
					finished_suites := True

				elseif suite_menu.quit_selected then
					finished_suites := True

				else
					from 
						finished_test_cases := False
						all_test_cases := False
						test_cases := test_suites.i_th(suite_menu.selection).test_cases
					until 
						finished_test_cases 
					loop
						-- write a menu of test cases to the console with a special
						-- option for "do all", i.e. run all tests and report on results.
						!!tc_menu_title.make(0) tc_menu_title.append(test_suites.i_th(suite_menu.selection).title) tc_menu_title.append(": Test Cases")
						!!tc_menu.make(tc_menu_title)
						from test_cases.start test_case_nr := 0 until test_cases.off loop
							test_case_nr := test_case_nr + 1
							!!tc_menu_item.make(0) tc_menu_item.append(test_cases.item.title)

							-- add the prerequsite test cases
							from 
								i := test_cases.item.prereqs.lower
							until
								i > test_cases.item.prereqs.upper
							loop
								tc_menu_item.append("%T%TPre-req (") tc_menu_item.append_integer(i) tc_menu_item.append("): ") 
								tc_menu_item.append(test_cases.item.prereqs.item(i))
								i := i + 1
							end
							tc_menu.add_item(tc_menu_item)
							test_cases.forth
			  			end
						tc_menu.set_all_item("ALL tests and report results")
						tc_menu.set_quit_item("MAIN MENU")
						tc_menu.display
						tc_menu.choose

						if tc_menu.all_selected then
							test_suites.i_th(suite_menu.selection).do_all
							finished_test_cases := True
						elseif tc_menu.quit_selected then
							finished_test_cases := True
						else
							io.put_string("----------> EXECUTING TC ") io.put_string(test_cases.i_th(tc_menu.selection).title) io.put_string(" -------------%N")
	    						test_cases.i_th(tc_menu.selection).execute
						end
					end
				end
			end

			from test_suites.start until test_suites.off loop
				test_suites.item.finalise
				test_suites.forth
			end

			io.put_string("Test Facility  TERMINATED%N")
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,   modification   and   distribution  |
--         | permitted with this notice  intact.  Please send  |
--         | modifications  and suggestions  to  Deep Thought  |
--         | Informatics, in  the  interests  of  maintenance  |
--         | and improvement.                                  |
--         |                                                   |
--         | Use of this software is on the understanding that |
--         | the  author(s)  accept no  liability of any kind. |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+


indexing
	description: "Eiffel Vision dynamic list test."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_TEST [G]

inherit
	EV_TEST

	EXCEPTIONS
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initalization

	make (a_list: DYNAMIC_LIST [G]; a_name: STRING; an_agent: like item_agent) is
			-- test `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_empty: a_list.empty
			a_name_not_void: a_name /= Void
			an_agent_not_void: an_agent /= Void
		do
			subject_name := a_name
			description := "Test of dynamic list: " + a_name + "."
			list := a_list
			item_agent := an_agent
			create {LINKED_LIST [G]} similar_list.make
		end

feature -- Basic operation

	execute is
			-- Perform testing.
		local
			test_list: LINKED_LIST [TUPLE [STRING, PROCEDURE [ANY, TUPLE []]]]
			s: STRING
			p: PROCEDURE [ANY, TUPLE []]
		do
			description := "Test results of " + subject_name + ":%N"
			test_successful := True

			create test_list.make
			test_list.extend (["extend", ~test_extend])
			test_list.extend (["put", ~test_put])
			test_list.extend (["replace", ~test_replace])
			test_list.extend (["put_left", ~test_put_left])
			test_list.extend (["put_right", ~test_put_right])
			test_list.extend (["put_i_th", ~test_put_i_th])
			test_list.extend (["force", ~test_force])
			test_list.extend (["put_front", ~test_put_front])

			from
				test_list.start
			until
				test_list.off
			loop
				s ?= test_list.item.entry (1)
				p ?= test_list.item.entry (2)
				empty_and_test (p, s)
				fill_start_and_test (p, s)
				fill_go_middle_and_test (p, s)
				fill_finish_and_test (p, s)
				fill_go_before_and_test (p, s)
				fill_go_after_and_test (p, s)
				test_list.forth
			end
		rescue
			test_successful := False
			if assertion_violation then
				description.append ("%N*** assertion failed: " + tag_name + " ***%N")
			else
				description.append ("%N" + meaning (exception) + "%N")
			end
		end

	empty_and_test (test_agent: PROCEDURE [ANY, TUPLE []]; name: STRING) is
		do
			list.wipe_out
			similar_list.wipe_out
			check
				testcase_correct: list.empty and then similar_list.empty
			end
			description.append ("Testing feature `" + name + "' with state `empty'...")
			test_agent.call ([])
			append_result
		end

	fill_start_and_test (test_agent: PROCEDURE [ANY, TUPLE []]; name: STRING) is
		do
			fill_lists
			list.start
			similar_list.start
			check
				testcase_correct: list.isfirst and then similar_list.isfirst
			end
			description.append ("Testing feature `" + name + "' with state `isfirst'...")
			test_agent.call ([])
			append_result
		end

	fill_go_middle_and_test (test_agent: PROCEDURE [ANY, TUPLE []]; name: STRING) is
		do
			fill_lists
			list.go_i_th (Testsize)
			similar_list.go_i_th (Testsize)
			check
				testcase_correct: not list.off and then not similar_list.off
			end
			description.append ("Testing feature `" + name + "' with cursor somewhere in middle...")
			test_agent.call ([])
			append_result
		end

	fill_finish_and_test (test_agent: PROCEDURE [ANY, TUPLE []]; name: STRING) is
		do
			fill_lists
			list.finish
			similar_list.finish
			check
				testcase_correct: list.islast and then similar_list.islast
			end
			description.append ("Testing feature `" + name + "' with state `islast'...")
			test_agent.call ([])
			append_result
		end

	fill_go_before_and_test (test_agent: PROCEDURE [ANY, TUPLE []]; name: STRING) is
		do
			fill_lists
			list.go_i_th (0)
			similar_list.go_i_th (0)
			check
				testcase_correct: list.before and then similar_list.before
			end
			description.append ("Testing feature `" + name + "' with state `before'...")
			test_agent.call ([])
			append_result
		end

	fill_go_after_and_test (test_agent: PROCEDURE [ANY, TUPLE []]; name: STRING) is
		do
			fill_lists
			list.go_i_th (list.count + 1)
			similar_list.go_i_th (similar_list.count + 1)
			check
				testcase_correct: list.after and then similar_list.after
			end
			description.append ("Testing feature `" + name + "' with state `after'...")
			test_agent.call ([])
			append_result
		end

feature -- Access

	description: STRING
			-- Description of the test, its results and other (ir)relevant information.

	subject_name: STRING
			-- The classname of the DYNAMIC_LIST.

	new_item is
			-- Retreive a new item from the outside.
		do
			last_item := item_agent.item ([])
		end

	last_item: G
			-- Last retreived item.

feature {NONE} -- Implementation

	item_agent: FUNCTION [ANY, TUPLE [], G]

	list: DYNAMIC_LIST [G]
			-- The list to perform the tests on.

	similar_list: DYNAMIC_LIST [G]
			-- A list from the base library that does the same.

	item_text (i: G): STRING is
		local
			b: EV_TEXTABLE
		do
			b ?= i
			if b /= Void then
				Result := b.text
			end
			if Result = Void then
				Result := "Void"
			end
		end

	fill_lists is
		local
			n: INTEGER
		do
			list.wipe_out
			similar_list.wipe_out
			from
				n := Testsize * 2
			until
				n = 1
			loop
				new_item
				list.extend (last_item)
				similar_list.extend (last_item)
				n := n - 1
			end
		end

	avoid_cond: BOOLEAN is
		do
			--description.append ("Your list's item: " + item_text (list.item) + "; LINKED_LIST: " + item_text (similar_list.item) + "%N")
			Result := True
		end

	append_result is
		require
			avoid_cond
		do
			if list.count /= similar_list.count then
				description.append (" `count' incorrect.%N")
				test_successful := False
			elseif list.empty /= similar_list.empty then 
				description.append (" `empty' incorrect.%N")
				test_successful := False
			elseif not similar_list.empty and then list.first /= similar_list.first then 
				description.append (" `first' incorrect.%N")
				test_successful := False
			elseif list.has (last_item) /= similar_list.has (last_item) then 
				description.append (" `has' incorrect.%N")
				test_successful := False
			elseif list.after /= similar_list.after then 
				description.append (" `after' incorrect.%N")
				description.append ("Your list's after: " + list.after.out + "; LINKED_LIST: " + similar_list.after.out + ".%N")
				test_successful := False
			elseif list.before /= similar_list.before then 
				description.append (" `before' incorrect.%N")
				test_successful := False
			elseif list.off /= similar_list.off then 
				description.append (" `off' incorrect.%N")
				test_successful := False
			elseif similar_list.valid_index (1) and then list.i_th (1) /= similar_list.i_th (1) then 
				description.append (" `i_th' incorrect.%N")
				test_successful := False
			elseif list.index /= similar_list.index then
				description.append (" index incorrect.%N")
				description.append ("Your list's index: " + list.index.out + "; LINKED_LIST: " + similar_list.index.out + ".%N")
				test_successful := False
			elseif list.index_of (last_item, 1) /= similar_list.index_of (last_item, 1) then 
				description.append (" `index_of' incorrect.%N")
				test_successful := False
			elseif (not similar_list.off) and then list.item /= similar_list.item then 
				description.append (" `item' incorrect.%N")
				description.append ("Your list's item: " + item_text (list.item) + "; LINKED_LIST: " + item_text (similar_list.item) + "%N")
				test_successful := False
			elseif not similar_list.empty and then list.last /= similar_list.last then 
				description.append (" `last' incorrect.%N")
				test_successful := False
			elseif list.sequential_occurrences (last_item) /= similar_list.sequential_occurrences (last_item) then 
				description.append (" `sequential_occurrences' incorrect.%N")
				test_successful := False
			elseif list.occurrences (last_item) /= similar_list.occurrences (last_item) then 
				description.append (" `occurrences' incorrect.%N")
				test_successful := False
			elseif list.empty /= similar_list.empty then 
				description.append (" `empty' incorrect.%N")
				test_successful := False
			elseif list.exhausted /= similar_list.exhausted then 
				description.append (" `exhausted' incorrect.%N")
				test_successful := False
			elseif list.full /= similar_list.full then 
				description.append (" `full' incorrect.%N")
				test_successful := False
			elseif list.isfirst /= similar_list.isfirst then 
				description.append (" `isfirst' incorrect.%N")
				test_successful := False
			elseif list.islast /= similar_list.islast then 
				description.append (" `islast' incorrect.%N")
				test_successful := False
			elseif not items_equal then 
				description.append (" items incorrect.%N")
				test_successful := False
			else
				description.append (" OK%N")
			end
		end

	items_equal: BOOLEAN is
			-- Are `list' and `similar_list' equal?
		require
			count_equal: list.count = similar_list.count
		do
			from
				list.start
				similar_list.start
				Result := True
			until
				list.after or else not Result
			loop
				if list.item /= similar_list.item then
					Result := False
				end
				list.forth
				similar_list.forth
			end
		end

	Testsize: INTEGER is 3
			-- Order of test.

	test_extend is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				if similar_list.extendible then
					list.extend (last_item)
					similar_list.extend (last_item)
				end
				n := n - 1
			end
		end

	test_put is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				if similar_list.extendible then
					list.extend (last_item)
					similar_list.extend (last_item)
				end
				n := n - 1
			end
		end

	test_replace is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				if similar_list.writable then
					list.replace (last_item)
					similar_list.replace (last_item)
				end
				n := n - 1
			end
		end

	test_put_front is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				list.put_front (last_item)
				similar_list.put_front (last_item)
				n := n - 1
			end
		end

	test_put_i_th is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				if similar_list.valid_index (n) then
					list.put_i_th (last_item, n)
					similar_list.put_i_th (last_item, n)
				end
				n := n - 1
			end
		end

	test_put_left is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				if similar_list.extendible and then not similar_list.before then
					list.put_left (last_item)
					similar_list.put_left (last_item)
				end
				n := n - 1
			end
		end

	test_put_right is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				if similar_list.extendible and then not similar_list.after then
					list.put_right (last_item)
					similar_list.put_right (last_item)
				end
				n := n - 1
			end
		end

	test_force is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n = 1
			loop
				new_item
				if similar_list.extendible then
					list.force (last_item)
					similar_list.force (last_item)
				end
				n := n - 1
			end
		end

invariant
	list_not_void: list /= Void
	description_not_void: description /= Void

end -- class EV_LIST_TEST

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/03/01 23:00:55  brendel
--| Added check if testcase assumption is correct.
--|
--| Revision 1.6  2000/03/01 19:16:56  brendel
--| Improved test sequence.
--|
--| Revision 1.2  2000/03/01 16:18:17  brendel
--| Added tests for all single-item-add features.
--|
--| Revision 1.1  2000/03/01 02:23:16  brendel
--| Initial test of DYNAMIC_LISTS.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------



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

	make (a_name: STRING; list_creator: like list_agent;
			item_creator: like item_agent) is
			-- test `a_list'.
		require
			a_name_not_void: a_name /= Void
			item_creator_not_void: item_creator /= Void
			list_creator_not_void: list_creator /= Void
		do
			subject_name := a_name
			description := "Test of dynamic list: " + a_name + "."
			list_agent := list_creator
			item_agent := item_creator
			create {LINKED_LIST [G]} similar_list.make
			list := list_agent.item ([])
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
		--	test_list.extend (["extend", ~test_extend])
		--	test_list.extend (["put", ~test_put])
		--	test_list.extend (["replace", ~test_replace])
			test_list.extend (["put_left", ~test_put_left])
		--	test_list.extend (["put_right", ~test_put_right])
		--	test_list.extend (["put_i_th", ~test_put_i_th])
		--	test_list.extend (["force", ~test_force])
		--	test_list.extend (["put_front", ~test_put_front])
		--	test_list.extend (["prune", ~test_prune])
		--	test_list.extend (["prune_all", ~test_prune_all])
		--	test_list.extend (["remove", ~test_remove])
		--	test_list.extend (["remove_left", ~test_remove_left])
		--	test_list.extend (["remove_right", ~test_remove_right])
		--	test_list.extend (["append", ~test_append])
		--	test_list.extend (["fill", ~test_fill])
		--	test_list.extend (["append", ~test_append])
			test_list.extend (["merge_left", ~test_merge_left])
		--	test_list.extend (["merge_right", ~test_merge_right])

			append_result ("-", "initial")

			from
				test_list.start
			until
				test_list.off
			loop
				s ?= test_list.item.entry (1)
				p ?= test_list.item.entry (2)
				description.append ("`" + s + "', ")
				empty_and_test (p, s)
				fill_start_and_test (p, s)
				fill_go_middle_and_test (p, s)
				fill_finish_and_test (p, s)
				fill_go_before_and_test (p, s)
				fill_go_after_and_test (p, s)
				test_list.forth
			end
			if test_successful then
				description.append ("working correctly.")
			end
		rescue
			test_successful := False
			if assertion_violation then
				description.append ("%N*** assertion failed: " +
					tag_name + " ***%N")
			else
				description.append ("%N" + meaning (exception) + "%N")
			end
		end

	empty_and_test (test_agent: PROCEDURE [ANY, TUPLE []]; name: STRING) is
			-- Empty `list' and perform the tests.
		do
			list.wipe_out
			similar_list.wipe_out
			check
				testcase_correct: list.empty and then similar_list.empty
			end
			test_agent.call ([])
			append_result (name, "empty")
		end

	fill_start_and_test (test_agent: PROCEDURE [ANY, TUPLE []];
			name: STRING) is
		do
			fill_lists
			list.start
			similar_list.start
			check
				testcase_correct: list.isfirst and then similar_list.isfirst
			end
			test_agent.call ([])
			append_result (name, "isfirst")
		end

	fill_go_middle_and_test (test_agent: PROCEDURE [ANY, TUPLE []];
			name: STRING) is
		do
			fill_lists
			list.go_i_th (Testsize)
			similar_list.go_i_th (Testsize)
			check
				testcase_correct: not list.off and then not similar_list.off
			end
			test_agent.call ([])
			append_result (name, "not off")
		end

	fill_finish_and_test (test_agent: PROCEDURE [ANY, TUPLE []];
			name: STRING) is
		do
			fill_lists
			list.finish
			similar_list.finish
			check
				testcase_correct: list.islast and then similar_list.islast
			end
			test_agent.call ([])
			append_result (name, "islast")
		end

	fill_go_before_and_test (test_agent: PROCEDURE [ANY, TUPLE []];
			name: STRING) is
		do
			fill_lists
			list.go_i_th (0)
			similar_list.go_i_th (0)
			check
				testcase_correct: list.before and then similar_list.before
			end
			test_agent.call ([])
			append_result (name, "before")
		end

	fill_go_after_and_test (test_agent: PROCEDURE [ANY, TUPLE []];
			name: STRING) is
		do
			fill_lists
			list.go_i_th (list.count + 1)
			similar_list.go_i_th (similar_list.count + 1)
			check
				testcase_correct: list.after and then similar_list.after
			end
			test_agent.call ([])
			append_result (name, "after")
		end

feature -- Access

	description: STRING
			-- Description of the test, its results and other
			-- (ir)relevant information.

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

	list_agent: FUNCTION [ANY, TUPLE [], like list]

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
				n < 1
			loop
				new_item
				list.extend (last_item)
				similar_list.extend (last_item)
				n := n - 1
			end
		end

	append_result (feature_name, test_state: STRING) is
			-- Append a message if test with `feature_name' in
			-- `test_state' failed.
		do
			if error_message /= Void then
				description.append ("Testing feature `" + feature_name +
					"' with state `" + test_state + "'...")
				description.append (error_message + "%N")
				test_successful := False
			end
		end

	error_message: STRING is
		do
			if list.count /= similar_list.count then
				Result := "`count' incorrect."
			elseif list.empty /= similar_list.empty then 
				Result := "`empty' incorrect."
			elseif not similar_list.empty and then
					list.first /= similar_list.first then 
				Result := "`first' incorrect."
			elseif list.has (last_item) /= similar_list.has (last_item) then 
				Result := "`has' incorrect."
			elseif list.after /= similar_list.after then 
				Result := "`after' incorrect."
				description.append ("Your list's after: " + list.after.out + "; LINKED_LIST: " + similar_list.after.out + ".%N")
			elseif list.before /= similar_list.before then 
				Result := "`before' incorrect."
			elseif list.off /= similar_list.off then 
				Result := "`off' incorrect."
			elseif similar_list.valid_index (1)
					and then list.i_th (1) /= similar_list.i_th (1) then 
				Result := "`i_th' incorrect."
			elseif list.index /= similar_list.index then
				Result := "`index' incorrect.%N" +
					"Your list's index: " + list.index.out +
					"; LINKED_LIST: " + similar_list.index.out + "."
			elseif list.index_of (last_item, 1) /= similar_list.index_of (
					last_item, 1) then 
				Result := "`index_of' incorrect."
			elseif (not similar_list.off)
					and then list.item /=similar_list.item then 
				Result := "`item' incorrect."
				description.append ("Your list's item: " + item_text (list.item) + "; LINKED_LIST: " + item_text (similar_list.item) + "%N")
			elseif not similar_list.empty
					and then list.last /= similar_list.last then 
				Result := "`last' incorrect."
			elseif list.sequential_occurrences (last_item) /=
					similar_list.sequential_occurrences (last_item) then 
				Result := "`sequential_occurrences' incorrect."
			elseif list.occurrences (last_item) /=
					similar_list.occurrences (last_item) then 
				Result := "`occurrences' incorrect."
			elseif list.empty /= similar_list.empty then 
				Result := "`empty' incorrect."
			elseif list.exhausted /= similar_list.exhausted then 
				Result := "`exhausted' incorrect."
			elseif list.full /= similar_list.full then 
				Result := "`full' incorrect."
			elseif list.isfirst /= similar_list.isfirst then 
				Result := "`isfirst' incorrect."
			elseif list.islast /= similar_list.islast then 
				Result := "`islast' incorrect."
			elseif not items_equal then 
				Result := "items incorrect."
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
				n < 1
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
				n < 1
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
				n < 1
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
				n < 1
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
				n < 1
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
				n < 1
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
				n < 1
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
				n < 1
			loop
				new_item
				if similar_list.extendible then
					list.force (last_item)
					similar_list.force (last_item)
				end
				n := n - 1
			end
		end

	test_prune is
		local
			n: INTEGER
			existing_item: G
		do
			from
				n := Testsize
			until
				n < 1
			loop
				if similar_list.prunable and then not similar_list.empty then
					if similar_list.readable then
						existing_item := similar_list.item
					else
						existing_item := similar_list.first
					end
					list.prune (existing_item)
					similar_list.prune (existing_item)
				end
				n := n - 1
			end
		end

	test_prune_all is
		local
			n: INTEGER
			existing_item: G
		do
			from
				n := Testsize
			until
				n < 1
			loop
				if similar_list.prunable and then not similar_list.empty then
					if similar_list.readable then
						existing_item := similar_list.item
					else
						existing_item := similar_list.first
					end
					list.prune_all (existing_item)
					similar_list.prune_all (existing_item)
				end
				n := n - 1
			end
		end

	test_remove is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n < 1
			loop
				if similar_list.prunable and then similar_list.writable then
					list.remove
					similar_list.remove
				end
				n := n - 1
			end
		end

	test_remove_left is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n < 1
			loop
				if similar_list.index > 1 then
					list.remove_left
					similar_list.remove_left
				end
				n := n - 1
			end
		end

	test_remove_right is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n < 1
			loop
				if similar_list.index < similar_list.count then
					list.remove_right
					similar_list.remove_right
				end
				n := n - 1
			end
		end

	test_append is
		local
			n: INTEGER
			s: LINKED_LIST [G]
		do
			from
				n := Testsize
				create s.make
			until
				n < 1
			loop
				new_item
				s.extend (last_item)
				n := n - 1
			end
			list.append (s)
			similar_list.append (s)
		end

	test_fill is
		local
			n: INTEGER
			s: LINKED_LIST [G]
		do
			from
				n := Testsize
				create s.make
			until
				n < 1
			loop
				new_item
				s.extend (last_item)
				n := n - 1
			end
			list.fill (s)
			similar_list.fill (s)
		end

	test_merge_left is
		local
			n: INTEGER
			sl: LINKED_LIST [G]
			l: DYNAMIC_LIST [G]
		do
			from
				n := Testsize
				create sl.make
				l := list_agent.item ([])
			until
				n < 1
			loop
				new_item
				l.extend (last_item)
				sl.extend (last_item)
				n := n - 1
			end
			if similar_list.extendible and then not similar_list.off then
				similar_list.merge_left (sl)
				list.merge_left (l)
			end
		end

	test_merge_right is
		local
			n: INTEGER
			sl: LINKED_LIST [G]
			l: DYNAMIC_LIST [G]
		do
			from
				n := Testsize
				create sl.make
				l := list_agent.item ([])
			until
				n < 1
			loop
				new_item
				l.extend (last_item)
				sl.extend (last_item)
				n := n - 1
			end
			if similar_list.extendible and then not similar_list.off then
				similar_list.merge_right (sl)
				list.merge_right (l)
			end
		end

	test_swap is
		local
			n: INTEGER
		do
			from
				n := Testsize
			until
				n < 1
			loop
				if not similar_list.off
						and then similar_list.valid_index (n) then
					list.swap (n)
					similar_list.swap (n)
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
--| Revision 1.18  2000/03/03 20:03:29  brendel
--| Better output to description.
--|
--| Revision 1.17  2000/03/03 18:54:11  brendel
--| Formatted for 80 columns.
--| Does not display anything for succeeded tests to avoid huge description.
--|
--| Revision 1.16  2000/03/02 19:54:31  brendel
--| Added 1 comment.
--|
--| Revision 1.14  2000/03/02 18:05:12  brendel
--| Fixed precondition on `make'.
--|
--| Revision 1.13  2000/03/02 17:46:57  brendel
--| Added tests for `merge_left', `merge_right' and `swap'.
--|
--| Revision 1.11  2000/03/02 01:35:27  brendel
--| Added tests for remove-features.
--|
--| Revision 1.10  2000/03/01 23:11:56  brendel
--| Added check for initial state.
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



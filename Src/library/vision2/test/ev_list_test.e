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
			name := a_name
			description := "Test of dynamic list: " + name + "."
			list := a_list
			item_agent := an_agent
			create {LINKED_LIST [G]} similar_list.make
		end

feature -- Basic operation

	execute is
			-- Perform testing.
		do
			description := "Test results of " + name + ":%N"
			test_successful := True

			description.append ("Testing feature `extend'...")
			test_extend
			append_result

			description.append ("Testing feature `put'...")
			test_put
			append_result

			description.append ("Testing feature `replace'...")
			test_replace
			append_result

			description.append ("Testing feature `put_left'...")
			test_put_left
			append_result

			description.append ("Testing feature `put_right'...")
			test_put_right
			append_result

			description.append ("Testing feature `put_i_th'...")
			test_put_i_th
			append_result

			description.append ("Testing feature `force'...")
			test_force
			append_result

			description.append ("Testing feature `put_front'...")
			test_put_front
			append_result
		rescue
			test_successful := False
			if assertion_violation then
				description.append ("%N*** assertion failed: " + tag_name + " ***%N")
			else
				description.append ("%N" + meaning (exception) + "%N")
			end
		end

feature -- Access

	description: STRING
			-- Description of the test, its results and other (ir)relevant information.

	name: STRING
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

	append_result is
		do
			if list.count /= similar_list.count then
				description.append (" `count' incorrect.%N")
				test_successful := False
			elseif not items_equal then 
				description.append (" items incorrect.%N")
				test_successful := False
			elseif list.first /= similar_list.first then 
				description.append (" `first' incorrect.%N")
				test_successful := False
			elseif list.has (last_item) /= similar_list.has (last_item) then 
				description.append (" `has' incorrect.%N")
				test_successful := False
			elseif similar_list.valid_index (1) implies list.i_th (1) /= similar_list.i_th (1) then 
				description.append (" `i_th' incorrect.%N")
				test_successful := False
			elseif list.index /= similar_list.index then
				description.append (" index incorrect.%N")
				description.append ("Your list's index: " + list.index.out + "; LINKED_LIST: " + similar_list.index.out + ".%N")
				test_successful := False
			elseif list.index_of (last_item, 1) /= similar_list.index_of (last_item, 1) then 
				description.append (" `index_of' incorrect.%N")
				test_successful := False
			elseif not similar_list.off implies list.item /= similar_list.item then 
				description.append (" `item' incorrect.%N")
				test_successful := False
			elseif not similar_list.empty implies list.last /= similar_list.last then 
				description.append (" `last' incorrect.%N")
				test_successful := False
			elseif list.sequential_occurrences (last_item) /= similar_list.sequential_occurrences (last_item) then 
				description.append (" `sequential_occurrences' incorrect.%N")
				test_successful := False
			elseif list.occurrences (last_item) /= similar_list.occurrences (last_item) then 
				description.append (" `occurrences' incorrect.%N")
				test_successful := False
			elseif list.after /= similar_list.after then 
				description.append (" `after' incorrect.%N")
				test_successful := False
			elseif list.before /= similar_list.before then 
				description.append (" `before' incorrect.%N")
				test_successful := False
			elseif list.empty /= similar_list.empty then 
				description.append (" `before' incorrect.%N")
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
			elseif list.off /= similar_list.off then 
				description.append (" `off' incorrect.%N")
				test_successful := False
			elseif list.off /= similar_list.off then 
				description.append (" `off' incorrect.%N")
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

	Magnitude: INTEGER is 3
			-- Order of test.

	test_extend is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := Magnitude
			until
				n = 1
			loop
				new_item
				list.extend (last_item)
				similar_list.extend (last_item)
				n := n - 1
			end
		end

	test_put is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := Magnitude
			until
				n = 1
			loop
				new_item
				list.extend (last_item)
				similar_list.extend (last_item)
				n := n - 1
			end
		end

	test_replace is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := Magnitude
			until
				n = 1
			loop
				new_item
				list.replace (last_item)
				similar_list.replace (last_item)
				n := n - 1
			end
		end

	test_put_front is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := Magnitude
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
			list.start
			similar_list.start
			from
				n := Magnitude
			until
				n = 1
			loop
				new_item
				list.put_i_th (last_item, n)
				similar_list.put_i_th (last_item, n)
				n := n - 1
			end
		end

	test_put_left is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := Magnitude
			until
				n = 1
			loop
				new_item
				list.put_left (last_item)
				similar_list.put_left (last_item)
				n := n - 1
			end
		end

	test_put_right is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := Magnitude
			until
				n = 1
			loop
				new_item
				list.put_right (last_item)
				similar_list.put_right (last_item)
				n := n - 1
			end
		end

	test_force is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := Magnitude
			until
				n = 1
			loop
				new_item
				list.force (last_item)
				similar_list.force (last_item)
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
--| Revision 1.3  2000/03/01 16:44:00  brendel
--| Added test of all relevant attributes.
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



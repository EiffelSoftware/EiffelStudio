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
				description.append (" size incorrect.%N")
				test_successful := False
			elseif list.index /= similar_list.index then
				description.append (" index incorrect.%N")
				description.append ("Your list's index: " + list.index.out + "; LINKED_LIST: " + similar_list.index.out + ".%N")
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

	test_extend is
		local
			n: INTEGER
		do
			list.start
			similar_list.start
			from
				n := 10
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
				n := 10
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
				n := 10
			until
				n = 1
			loop
				new_item
				list.replace (last_item)
				similar_list.replace (last_item)
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
--| Revision 1.1  2000/03/01 02:23:16  brendel
--| Initial test of DYNAMIC_LISTS.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------



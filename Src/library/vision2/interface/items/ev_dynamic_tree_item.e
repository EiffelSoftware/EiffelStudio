indexing
	description:
		"Dynamically expandable tree item."
	status: "See notice at end of file"
	keywords: "tree, item, dynamic"
	date: "11/4/1999"
	revision: "$Revision$"

class
	EV_DYNAMIC_TREE_ITEM

inherit
	EV_TREE_NODE
		redefine
			implementation
		end
		
creation
	default_create,
	make_with_text,
	make_with_function

feature {NONE} -- Initialization

	make_with_function (a_subtree_function: like subtree_function) is
			-- Create with `a_subtree_function'.
		do
			default_create
			set_subtree_function (a_subtree_function)
		end

feature -- Access

	item: EV_TREE_NODE is
			-- Item at current position
		local
			linear: LINEAR [EV_TREE_NODE]
			chain: CHAIN [EV_TREE_NODE]
			cs: CURSOR_STRUCTURE [EV_TREE_NODE]
			c: CURSOR
			i: INTEGER
		do
			check
				subtree_function_not_void: subtree_function /= void 
			end
			subtree_function_call
			linear := subtree_function.last_result
			chain ?= linear
			if chain /= Void then
				Result := chain.i_th (index)
			else
				cs ?= linear
				if cs /= Void then
					c := cs.cursor
				end
				from
					linear.start
					i := 1
				variant
					index - i
				until
					i = index
				loop
					linear.forth
					i := i + 1
				end
				if cs /= Void then
					cs.go_to (c)
				end
				Result := linear.item
			end
		end

	subtree_function: FUNCTION [ANY, TUPLE [], LINEAR [EV_TREE_NODE]]
			-- Tree items contained.

	set_subtree_function (a_subtree_function: like subtree_function) is
			-- Assign `a_subtree_function' to `subtree_function'.
		require
			not_destroyed: not is_destroyed
		do
			if a_subtree_function /= Void then
				expand_actions.extend (~fill_from_subtree_function)
				implementation.extend (create {EV_TREE_ITEM})
				set_subtree_function_timeout (default_subtree_function_timeout)
			end
			subtree_function := a_subtree_function
		end

	subtree_function_timeout: INTEGER
			-- Time in milliseconds, after `subtree_function'.call, when
			-- `subtree_function'.last_result is considered to have expired.
			-- There is no guarantee that `subtree_function' will be recalled
			-- after this timeout, but Vision will not call it twice within
			-- one timeout period.
			-- Default is 1 second.

	default_subtree_function_timeout: INTEGER is 1000
			-- 1 second.

	set_subtree_function_timeout (a_timeout: like subtree_function_timeout) is
			-- Assign `a_timeout' to `subtree_function_timeout'.
		require
			not_destroyed: not is_destroyed
		do
			subtree_function_timeout := a_timeout
		end

	subtree_function_call is
			-- Call `subtree_function' if it has not been called in the last
			-- `subtree_function_timeout' milliseconds.
		require
			not_destroyed: not is_destroyed
		local
			now: INTEGER
		do
			now := time_msec
			check
				linear_time: now >= last_subtree_function_call_time
			end
			if
				now - last_subtree_function_call_time
				>= subtree_function_timeout
				or
				last_subtree_function_call_time = 0
			then
				subtree_function.call ([])
				last_subtree_function_call_time := now
			end
		end

	index: INTEGER
			-- Index of current position.

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		local
			linear: LINEAR [EV_TREE_NODE]
			finite: FINITE [EV_TREE_NODE]
			cs: CURSOR_STRUCTURE [EV_TREE_NODE]
			c: CURSOR
			i: INTEGER
		do
			if subtree_function /= Void then
				subtree_function_call
				linear := subtree_function.last_result
				finite ?= linear
				if finite /= Void then
					Result := index = finite.count + 1
				else
					cs ?= linear
					if cs /= Void then
						c := cs.cursor
					end
					from
						linear.start
						i := 1
					variant
						index - i
					until
						i = index or linear.after
					loop
						linear.forth
						i := i + 1
					end
					if cs /= Void then
						cs.go_to (c)
					end
					Result := linear.after
				end
			end
		end

	is_empty: BOOLEAN is
			-- Is there no element?
		do
			Result := True
			if subtree_function /= Void then
				subtree_function_call
				if subtree_function.last_result /= Void then
					Result := subtree_function.last_result.is_empty
				end
			end
		end

feature -- Cursor movement

	start is
			-- Move to first position if any.
		do
			index := 1
		end
	
	finish is
			-- Move to last position.
		local
			linear: LINEAR [EV_TREE_NODE]
			finite: FINITE [EV_TREE_NODE]
			cs: CURSOR_STRUCTURE [EV_TREE_NODE]
			c: CURSOR
			i: INTEGER
		do
			if
				subtree_function /= void
			then
				subtree_function_call
				linear := subtree_function.last_result
				finite ?= linear
				if finite /= Void then
					index := finite.count
				else
					cs ?= linear
					if cs /= Void then
						c := cs.cursor
					end
					from
						linear.start
						i := 1
					until
						linear.after
					loop
						linear.forth
						i := i + 1
					end
					if cs /= Void then
						cs.go_to (c)
					end
				end
			end
		end
	
	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		do
			index := index + 1
		end

feature -- Contract support

	is_expandable: BOOLEAN is
			-- Is `Current' able to expand or collapse?
		do
			if subtree_function /= Void then
				Result := True	
			end
		end

feature {EV_ANY_I} -- Implementation
		
	implementation: EV_TREE_NODE_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TREE_NODE_IMP} implementation.make (Current)
		end

	last_subtree_function_call_time: INTEGER
			-- Time in milliseconds at which `subtree_function' was last called.

	fill_from_subtree_function is
			-- Put elements from `subtree_function' into tree.
		local
			linear: LINEAR [EV_TREE_NODE]
			cs: CURSOR_STRUCTURE [EV_TREE_NODE]
			c: CURSOR
		do
			from until implementation.count = 1 loop
				implementation.start
				implementation.remove
			end
			if subtree_function /= Void then
				subtree_function_call
				linear := subtree_function.last_result
				cs ?= linear
				if cs /= Void then
					c := cs.cursor
				end
				from
					linear.start
				until
					linear.after
				loop
					implementation.extend (linear.item)
					linear.forth
				end
				if cs /= Void then
					cs.go_to (c)
				end
				implementation.start
				implementation.remove
			else
				implementation.extend (create {EV_TREE_ITEM})
				implementation.start
				implementation.remove
			end
		end

	time_msec: INTEGER is
		external
			"C (): unsigned long | %"load_pixmap.h%""
		end

end -- class EV_DYNAMIC_TREE_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


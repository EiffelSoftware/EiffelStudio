indexing
	description:
		"[
			Dynamically expandable tree item.
		]"
	status: "See notice at end of file"
	keywords: "tree, item, dynamic"
	date: "11/4/1999"
	revision: "$Revision$"

class
	EV_DYNAMIC_TREE_ITEM

inherit
	
	EV_TREE_NODE
		export
			{EV_DYNAMIC_TREE_ITEM} sequential_occurrences, fill, is_inserted, dl_force,
			writable, first, index_set, infix "@", isfirst, islast, last, put, valid_cursor,
			valid_index, prunable, prune_all, before, is_equal, append, back, count,
			cursor, extend, force, full, go_i_th, go_to, i_th, index_of, merge_left, merge_right,
			move, prune, put_front, put_i_th, put_left, put_right, remove, remove_left,
			remove_right, replace, retrieve_item_by_data, retrieve_items_by_data, same, swap,
			wipe_out, item_by_data, find_item_recursively_by_data, has_recursively,
			recursive_do_all, retrieve_item_recursively_by_data, retrieve_items_recursively_by_data
			{ANY}
			readable, extendible
		undefine
			forth, finish, start, is_empty, index, after, item
		redefine
			implementation,
			parent_of_items_is_current,
			count
		end
		
create
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
				subtree_function_not_void: subtree_function /= Void 
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
				Result := linear.item
				if cs /= Void then
					cs.go_to (c)
				end
			end
		end

	subtree_function: FUNCTION [ANY, TUPLE, LINEAR [EV_TREE_NODE]]
			-- Function be be executed to fill `Current' with items of
			-- type EV_TREE_NODE.

	set_subtree_function (a_subtree_function: like subtree_function) is
			-- Assign `a_subtree_function' to `subtree_function'.
		require
			not_destroyed: not is_destroyed
			not_void: a_subtree_function /= Void
			valid_operands: a_subtree_function.valid_operands (Void)
		do
			if subtree_function /= Void then
				remove_subtree_function
			end
			if a_subtree_function /= Void then
				expand_actions.extend (agent fill_from_subtree_function)
				implementation.extend (create {EV_TREE_ITEM})
				set_subtree_function_timeout (default_subtree_function_timeout)
			end
			subtree_function := a_subtree_function
		end
		
	remove_subtree_function is
			-- Assign `Void' to `subtree_function'. Ensure `Current'
			-- is no longer expandable.
		do
				-- We reset all attributes.
			subtree_function := Void
			expand_actions.wipe_out
			implementation.start
			implementation.remove
			last_subtree_function_call_time := 0
			subtree_function_timeout := 0
		end

	subtree_function_timeout: INTEGER
			-- Time in milliseconds, after `subtree_function'.call, when
			-- `subtree_function'.last_result is considered to have expired.
			-- There is no guarantee that `subtree_function' will be recalled
			-- after this timeout, but Vision will not call it twice within
			-- one timeout period.
			-- Default is 1 second.

	default_subtree_function_timeout: INTEGER is 1000
			-- 1000 milliseconds = 1 second.

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
			time_msec ($now)
			check
				linear_time: now >= last_subtree_function_call_time
			end
			if
				now - last_subtree_function_call_time
				>= subtree_function_timeout
				or
				last_subtree_function_call_time = 0
			then
				subtree_function.call (Void)
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
						i = index or linear.off
					loop
						linear.forth
						i := i + 1
					end
					Result := linear.after
					if cs /= Void then
						cs.go_to (c)
					end
				end
			else
				Result := Precursor {EV_TREE_NODE}
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
		
	count: INTEGER is
			-- Number of elements in `Current'.
		local
			items: linear [EV_TREE_NODE]
		do
			if subtree_function /= Void then
				subtree_function_call
				if subtree_function.last_result /= Void then
					items := subtree_function.last_result
					from
						items.start
					until
						items.off
					loop
						Result := Result + 1
						items.forth
					end
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
				subtree_function /= Void
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
						linear.off
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
			Result := parent_tree /= Void and subtree_function /= Void
		end
		
feature {NONE} -- Contract support
		
	parent_of_items_is_current: BOOLEAN is
			-- Do all items have parent `Current'?
		do
			Result := True
			-- As `Current' is implemented completely as an interface,
			-- it is not possible to correctly check this without
			-- the invariant `parent_of_items_is_current' failing, as
			-- `fill_from_subtree_function' is executed too late,
			-- during the `expand_actions'.
		end

feature {EV_ANY, EV_ANY_I} -- Implementation
		
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
				if linear /= Void then
					cs ?= linear
					if cs /= Void then
						c := cs.cursor
					end
					from
						linear.start
					until
						linear.off
					loop
						implementation.extend (linear.item)
						linear.forth
					end
					if cs /= Void then
						cs.go_to (c)
					end
				end
				implementation.start
				implementation.remove
			else
				implementation.extend (create {EV_TREE_ITEM})
				implementation.start
				implementation.remove
			end
		end

	time_msec (now: TYPED_POINTER [INTEGER]) is
		external
			"C inline use <sys/types.h>, <sys/timeb.h>"
		alias
			"[
				{
					struct timeb tb;
					static time_t beginning = 0;
					if (!beginning) {
						beginning = time (NULL);
					}
					ftime (&tb);
					*$now = (EIF_INTEGER) (((tb.time - beginning) * 1000) + tb.millitm);
				}
			]"
		end

end -- class EV_DYNAMIC_TREE_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


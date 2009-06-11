note
	description:
		"[
			Dynamically expandable tree item.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tree, item, dynamic"
	date: "11/4/1999"
	revision: "$Revision$"

class
	EV_DYNAMIC_TREE_ITEM

inherit

	EV_TREE_NODE
		export
			{EV_DYNAMIC_TREE_ITEM} fill, dl_force, dl_replace, put, writable, prunable, prune_all, append,
			extend, force, merge_left, merge_right, move, prune, put_front, put_i_th, put_left,
			put_right, remove, remove_left, remove_right, replace, swap, wipe_out
		redefine
			implementation,
			parent_of_items_is_current
		end

	REFACTORING_HELPER
		undefine
			default_create, is_equal, copy
		end

create
	default_create,
	make_with_text,
	make_with_function

feature {NONE} -- Initialization

	make_with_function (a_subtree_function: like subtree_function)
			-- Create with `a_subtree_function'.
		do
			default_create
			set_subtree_function (a_subtree_function)
		end

feature -- Access

	subtree_function: detachable FUNCTION [ANY, TUPLE, LINEAR [EV_TREE_NODE]]
			-- Function be be executed to fill `Current' with items of
			-- type EV_TREE_NODE.

	set_subtree_function (a_subtree_function: like subtree_function)
			-- Assign `a_subtree_function' to `subtree_function'.
		require
			not_destroyed: not is_destroyed
			not_void: a_subtree_function /= Void
			valid_operands: a_subtree_function.valid_operands (Void)
		do
			if subtree_function /= Void then
				remove_subtree_function
			end
			expand_actions.extend (agent fill_from_subtree_function)
			ensure_expandable
			set_subtree_function_timeout (default_subtree_function_timeout)
			subtree_function := a_subtree_function
		end

	remove_subtree_function
			-- Assign `Void' to `subtree_function'. Ensure `Current'
			-- is no longer expandable.
		do
				-- We reset all attributes.
			subtree_function := Void
			expand_actions.wipe_out
			remove_expandable
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

	default_subtree_function_timeout: INTEGER = 1000
			-- 1000 milliseconds = 1 second.

	set_subtree_function_timeout (a_timeout: like subtree_function_timeout)
			-- Assign `a_timeout' to `subtree_function_timeout'.
		require
			not_destroyed: not is_destroyed
		do
			subtree_function_timeout := a_timeout
		end

	subtree_function_call
			-- Call `subtree_function' if it has not been called in the last
			-- `subtree_function_timeout' milliseconds.
		require
			not_destroyed: not is_destroyed
		local
			now: INTEGER
			l_subtree_function: like subtree_function
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
				l_subtree_function := subtree_function
				check l_subtree_function /= Void end
				l_subtree_function.call (Void)
				last_subtree_function_call_time := now
			end
		end

feature -- Contract support

	is_expandable: BOOLEAN
			-- Is `Current' able to expand or collapse?
		do
			Result := parent_tree /= Void and subtree_function /= Void
		end

feature {NONE} -- Contract support

	parent_of_items_is_current: BOOLEAN
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

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TREE_NODE_IMP} implementation.make
		end

	last_subtree_function_call_time: INTEGER
			-- Time in milliseconds at which `subtree_function' was last called.

	fill_from_subtree_function
			-- Put elements from `subtree_function' into tree.
		local
			linear: detachable LINEAR [EV_TREE_NODE]
			cs: detachable CURSOR_STRUCTURE [EV_TREE_NODE]
			c: detachable CURSOR
			l_subtree_function: like subtree_function
		do
			from until implementation.count = 0 loop
				implementation.start
				implementation.remove
			end
			subtree_function_call
			l_subtree_function := subtree_function
			check l_subtree_function /= Void end
			linear := l_subtree_function.last_result
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
					check c /= Void end
					cs.go_to (c)
				end
			end
			remove_expandable
		end

	time_msec (now: TYPED_POINTER [INTEGER])
		external
			"C inline use <sys/types.h>, <time.h>, <sys/timeb.h>"
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

	ensure_expandable
			-- Ensure `Current' is displayed as expandable.
		require
			is_empty: is_empty
		do
			implementation.ensure_expandable
		ensure
			is_empty: is_empty
		end

	remove_expandable
			-- Ensure `Current' is no longer displayed as expandable.
		do
			implementation.remove_expandable
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DYNAMIC_TREE_ITEM












--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Stacks with no physical size limit,
-- implemented as linked lists

indexing

	names: linked_stack, dispenser, linked_list;
	representation: linked;
	access: fixed, lifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_STACK [G] inherit

	STACK [G]
		undefine
			replace, search, has, empty, search_equal,
			index_of, remove_item, sequential_representation
		select
			put, item
		end;

	LINKED_LIST [G]
		rename
			item as ll_item
		export
			{NONE} all;
			readable, writable, extensible, contractable, make, wipe_out
		undefine
			readable, writable, contractable, fill,
			append, sequential_representation, put
		redefine
			add, remove, duplicate
		end

creation

	make

feature -- Access

	item: G is
			-- Item at the first position
		require else
			Not_empty: not empty
		do
			Result := first_element.item
		end;

feature -- Insertion

	add (v: like item) is
			-- Push `v' onto `Current'.
		do
			add_front (v)
		end;

feature -- Deletion

	remove is
			-- Remove top item.
		do
			remove_right
		end;

feature -- Transformation

	sequential_representation: ARRAY_SEQUENCE [G] is
			-- Sequential representation of `Current'.
			-- This feature enables you to manipulate each
			-- item of `Current' regardless of its
			-- actual structure.
			-- First element will be the top of the stack.
		local
			temp: like Current;
		do
			temp := duplicate (count);
			from
				!! Result.make (count);
			until
				temp.count = 0
			loop
				Result.add (temp.item);
				temp.remove;
			end;
				-- The reason for redefining
				-- `sequential_representation' here is that the
				-- cursor of `Current' must not be manipulated
				-- by clients in order not to invalidate the
				-- `before' invariant clause and a new `item'
				-- has been redefined and selected.
		end;

    duplicate (n: INTEGER): like Current is
            -- Return a stack with the `n' latest items pushed
            -- on `Current'. If `n' is greater than `count', it
            -- duplicate `Current'
		require else
			positive_argument: n > 0
		local
			counter: INTEGER
        do
            finish;
            from
                !! Result.make;
            until
                off or counter >= n
            loop
                Result.add (ll_item);
                back;
				counter := counter + 1;
            end;
			start;
            back;
        end;

invariant

	is_always_before: before

end

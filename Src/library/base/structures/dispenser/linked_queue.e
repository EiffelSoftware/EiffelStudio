--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Queues with no physical size limit,
-- implemented as linked lists

indexing

	names: linked_queue, dispenser, linked_list;
	representation: linked;
	access: fixed, fifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_QUEUE [G] inherit

	QUEUE [G]
		undefine
			search, has, empty, index_of, search_equal
		redefine
			sequential_representation
		end;

	LINKED_LIST [G]
		rename
			add as ll_add,
			item as ll_item
		export
			{NONE} all;
			writable, extensible, make, wipe_out,
			contractable, readable
		undefine
			put, fill, remove, append, remove_item,
			readable, writable, contractable
		redefine
			duplicate, sequential_representation
		select
			add, item
		end

creation

	make

feature -- Access

	item: G is
			-- Oldest item
		do
			Result := first
		end;

feature -- Insertion

	add (v: G) is
			-- Add item `v' to `Current'.
		do
			if empty then
				ll_add (v)
			else
				add_right (v)
			end;
			forth
		ensure then
	--		(old empty) implies (item = v);
		end;

feature -- Deletion

	remove is
			-- Remove oldest item.
		do
			first_element := first_element.right;
			if count = 1 then
				active := Void;
				before := true
			end;
			count := count - 1
		end;

feature -- Transformation

	sequential_representation: ARRAY_SEQUENCE [G] is
			-- Sequential representation of `Current'.
			-- This feature enables you to manipulate each
			-- item of `Current' regardless of its
			-- actual structure.
		local
			temp: like Current;
		do
			temp := duplicate (count);
			from
				!! Result.make (count)
			until
				temp.count = 0
			loop
				Result.put (temp.item);
				temp.remove
			end;

				-- The reason for redefining
				-- `sequential_representation' here is that the
				-- cursor of `Current' must not be manipulated
				-- by clients in order not to invalidate the
				-- `islast' invariant clause and a new `item' has
				-- been redefined and selected.
		end;

	duplicate (n: INTEGER): like Current is
			-- Return a queue with the `n' latest items inserted
			-- in `Current'. If `n' is greater than `count', it
			-- duplicate `Current'
		require else
			positive_argument: n > 0
		do
			start;
			from
				!! Result.make;
				if n < count then
					move (count - n)
				end
			until
				off
			loop
				Result.add (ll_item);
				forth;
			end;
			back
		end;

invariant

	is_always_empty_orlast: empty or else islast

end

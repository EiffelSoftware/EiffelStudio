-- Lists of a given number of stones. stones are added to the end 
-- and older stones are thrown away.

class

	STONE_HISTORY

inherit

	TWO_WAY_LIST [STONE]
		rename
			make as twl_make,
			extend as twl_extend
		export
			{NONE} all;
			{ANY} item, forth, back, isfirst, islast, wipe_out, empty;
			{ANY} after, before, index, go_i_th, start, finish
		end

creation

	make

feature -- Initialization

	make (nb: INTEGER) is
			-- Make an history of at most `nb' items.
		require
			positive_nb: nb > 0
		do
			twl_make;
			capacity := nb
		ensure
			capacity_set: capacity = nb
		end;

feature -- Element change

	extend (v: like item) is
			-- Add `v' to `Current'. Throw away the older item
			-- if the capacity has been reached.
			-- Do not insert `v' if it was the last inserted item.
			-- Move the cursor to the last inserted stone.
		do
			if v /= Void and (empty or else not equal (v, last)) then
				twl_extend (v);
				if count > capacity then
					start; remove
				end;
				finish
			end
		end

feature {NONE} -- Measurement

	capacity: INTEGER;
			-- Maximum number of items

feature -- Synchronization

	synchronize is
			-- Synchronize held stones. Reset the cursor position to the 
			-- last inserted stone. Some of the stones may become Void 
			-- (not valid anymore) and are therefore removed from the history.
		local
			new_stone: STONE
		do
			from start until after loop
				new_stone := item.synchronized_stone;
				if new_stone /= Void then
					put (new_stone)
					forth
				else
					remove
				end;
			end;
			finish
		end;
	
invariant

	positive_capacity: capacity > 0;
	bounded_count: count <= capacity

end -- class STONE_HISTORY

indexing

	description: 
		"Lists of a given number of stones. Stones are added %
		%to the end and older stones are thrown away.";
	date: "$Date$";
	revision: "$Revision $"

class

	STONE_HISTORY

inherit

	TWO_WAY_LIST [STONE]
		rename
			extend as twl_extend
		export
			{NONE} all;
			{ANY} item, forth, back, isfirst, islast, wipe_out, empty;
			{ANY} after, before, index, go_i_th, start, finish, make
		end;

	SHARED_BENCH_RESOURCES;

	INTERFACE_W

creation

	make

feature -- Element change

	extend (v: like item) is
			-- Add `v' to `Current'. Throw away the older item
			-- if the capacity has been reached.
			-- Do not insert `v' if it was the last inserted item.
			-- Move the cursor to the last inserted stone.
		do
			if v /= Void and
					(empty or else not equal (v, last) or else not equal (v.signature, item.signature)) then
				twl_extend (v);
				if count > capacity then
					start; remove
				end;
				finish
			end
		end

feature {NONE} -- Measurement

	capacity: INTEGER is
			-- Maximum number of items
		once
			Result := resources.get_integer (r_History_size, 10);
			if Result < 1 or Result > 100 then
					-- Just in case the user specified some weird values.
				Result := 10
			end
		end;

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

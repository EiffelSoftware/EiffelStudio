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
			extend as twl_extend,
			make as twl_make
		export
			{NONE} all;
			{ANY} item, forth, back, isfirst, islast, wipe_out, empty, go_to;
			{ANY} after, before, index, go_i_th, start, finish, has, cursor
		end;
	TWO_WAY_LIST [STONE]
		rename
			extend as twl_extend
		export
			{NONE} all;
			{ANY} item, forth, back, isfirst, islast, wipe_out, empty, go_to;
			{ANY} after, before, index, go_i_th, start, finish, make, has, cursor
		redefine
			make
		select
			make
		end;
	EB_CONSTANTS;
	RESOURCE_USER
		redefine
			update_integer_resource
		end;
	INTERFACE_W

creation

	make

feature -- Initialization

	make is
			-- Initialze Current
		do
			twl_make;
			System_resources.add_user (Current)
		end

feature -- Resource Update

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with `new_res', if the value of
			-- `new_res' is applicable.
			-- Also, update the interface.
		do
			if old_res = System_resources.history_size then
				if new_res.actual_value >= 1 and new_res.actual_value <= 100 then
					old_res.update_with (new_res);
					rearrange_history
				end
			end
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to `Current'. Throw away the older item
			-- if the capacity has been reached.
			-- Do not insert `v' if it was the last inserted item.
			-- Move the cursor to the last inserted stone.
		do
			if
				v /= Void and
				(empty or else
				not v.same_as (last) or else
				not equal (v.signature, item.signature))
			then
				if not empty and then not islast then
					from
					until
						islast
					loop
						remove_right
					end
				end;
				twl_extend (v);
				if count > capacity then
					start; 
					remove
				end;
				finish
			end
		end

feature {NONE} -- Measurement

	capacity: INTEGER is
			-- Maximum number of items
		do
			Result := System_resources.history_size.actual_value;
			if Result < 1 or Result > 100 then
					-- Just in case the user specified some weird values.
				Result := 10
			end
		end;

feature {NONE} -- Resizing

	rearrange_history is
			-- Rearrange the history according to the resource value.
		do
			from
				start
			until
				count <= capacity 
			loop
				remove;
				start
			end				
		end

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

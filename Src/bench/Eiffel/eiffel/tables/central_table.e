-- Description of a table used by the run-time in workbench mode

class CENTRAL_TABLE [T->CALL_UNIT] 

inherit

	SEARCH_TABLE [T]
		rename
			put as search_table_put
		end;

	SEARCH_TABLE [T]
		redefine
			put
		select
			put
		end

creation

	init
	
feature

	melted_list: LINKED_LIST [T];
			-- List of melted unit

	last_unit: T;
			-- Last unit evaluated by `put'

	init is
			-- Initialization
		do
			!!melted_list.make;
			!!useless_ids.make;
			make (Chunk);
		end;

	Chunk: INTEGER is 500;
			-- Table chunk


	put (t: T) is
			-- Insert `t' in the table if not already present.
		do
			last_unit := item (t);
			if (last_unit = Void) then
				counter := counter + 1;
debug ("REFREEZING")
	io.error.putstring ("New item at position ");
	io.error.putint (counter);
	io.error.new_line;
end;
				search_table_put (t);
				t.set_index (counter);
				last_unit := t;
			else
debug ("REFREEZING")
	io.error.putstring ("Item already in table%NNew type: ");
	io.error.putstring (t.generator);
	io.error.new_line;
	io.error.putstring (last_unit.generator);
	io.error.new_line;
end;
			end;
		end;

	mark_melted (t: T) is
			-- Insert `t' in `melted_list'.
		do
			melted_list.add_front (t);
		end;

	freeze is
			-- Wipe out `melted_list'.
		do
			melted_list.wipe_out;
		end;

feature {CENTRAL_TABLE,  SYSTEM_I} -- Shake the table

	counter: INTEGER;
			-- Number of valid items in the table

	shake is
			-- Reorganize the table during a refreezing
		local
			u: T;
			unit_index: INTEGER;
			new_index: INTEGER;
			max_index: INTEGER;
		do
				-- First find the invalid ids
				-- for the frozen or melted units
				-- The precompiled units are kept anyway
				-- (`melt_all' can make some units unvalid but they
				-- MUST be kept in the table)
debug ("REFREEZING")
	io.error.putstring ("SHAKE (");
	io.error.putstring (generator);
	io.error.putstring (")%N");
	io.error.putstring ("Frozen level: ");
	io.error.putint (frozen_level);
	io.error.new_line;
	io.error.putstring ("Precomp level: ");
	io.error.putint (precomp_level);
	io.error.new_line;
	display_useless_ids;
end;
			from
				start
			until
				after
			loop
				u := item_for_iteration;
				unit_index := u.index;
				if
					unit_index > precomp_level
				and then
					not u.is_valid
				then
					remove (u);
					useless_ids.add (unit_index);
				end;
				forth
			end;
				-- Reorganize the table: the melted unit are put in the
				-- holes in the frozen part or just moved closer to the
				-- frozen part if there is no room left in the frozen
				-- part
			from
				start
			until
				after
			loop
				u := item_for_iteration;
				unit_index := u.index;
					-- Only the melted units are moved
				if unit_index > frozen_level and then
					not useless_ids.empty and then
					unit_index > useless_ids.first
				then
						-- Moving the unit
					new_index := useless_ids.first;
debug ("REFREEZING")
	io.error.putstring ("Moving ");
	io.error.putint (unit_index);
	io.error.putstring (" to ");
	io.error.putint (new_index);
	io.error.new_line;
end;
					useless_ids.remove_all_occurrences (new_index);
					useless_ids.add (unit_index);
					u.set_index (new_index);
					if new_index > max_index then
						max_index := new_index
					end;
				elseif unit_index > max_index then
						-- the unit is not moved
					max_index := unit_index
				end;
				forth
			end;

			if max_index > frozen_level then
				frozen_level := max_index
			end;

				-- clean then useless_ids:
				-- remove the ids > new frozen_level
			from
				useless_ids.start
			until
				useless_ids.after
			loop
				if useless_ids.item > frozen_level then
					useless_ids.remove
				else
					useless_ids.forth
				end;
			end;

				-- Reset the value of counter
			counter := frozen_level;
debug ("REFREEZING")
	display_useless_ids;
	io.error.putstring ("Frozen level: ");
	io.error.putint (counter);
	io.error.new_line;
end;
		end;

feature {NONE} -- Keep track of the holes in the table

	useless_ids: SORTED_SET [INTEGER];
			-- Id corresponding to unvalid units

	display_useless_ids is
		do
			io.error.putstring ("Useless ids: %N");
			from
				useless_ids.start
			until
				useless_ids.after
			loop
				io.error.putint (useless_ids.item);
				io.error.new_line;
				useless_ids.forth
			end;
		end;
				
feature -- Re_freezing

	frozen_level: INTEGER;

	precomp_level: INTEGER;

	set_precomp_level is
			-- Set the value of `precomp_level' to `frozen_level'
		do
			precomp_level := frozen_level;
		end;

end

-- Description of a table used by the run-time in workbench mode

deferred class CENTRAL_TABLE [T->CALL_UNIT] 

inherit
	SEARCH_TABLE [T]
		rename
			make as search_table_make
		redefine
			put
		end

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
			useless_ids.compare_objects;
			search_table_make (Chunk);
		end;

	Chunk: INTEGER is 500;
			-- Table chunk


	put (t: T) is
			-- Insert `t' in the table if not already present.
		do
			last_unit := item (t);
			if (last_unit = Void) then
				{SEARCH_TABLE} Precursor (t);
				t.set_index (counter.next_id);
				last_unit := t;
debug ("REFREEZING")
	io.error.putstring ("New item at position ");
	io.error.putint (counter.total_count);
	io.error.new_line;
end;
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
			melted_list.put_front (t);
		end;

	freeze is
			-- Wipe out `melted_list'.
		do
			melted_list.wipe_out;
		end;

feature {CENTRAL_TABLE,  SYSTEM_I} -- Shake the table

	counter: COMPILER_COUNTER is
			-- Counter of valid items in the table
		deferred
		ensure
			counter_not_void: Result /= Void
		end

	shake is
			-- Reorganize the table during a refreezing
		local
			u: T;
			unit_index: COMPILER_ID;
			new_index: COMPILER_ID;
			max_index: INTEGER;
			frozen_index: INTEGER
		do
			frozen_index := frozen_level;
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
	display_useless_ids;
end;
			from
				start
			until
				after
			loop
				u := item_for_iteration;
				unit_index := u.index;
				if not unit_index.is_precompiled and then not u.is_valid then
					remove (u);
					useless_ids.extend (unit_index)
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
				if 
					unit_index.id > frozen_index and then
					not useless_ids.empty and then
					unit_index > useless_ids.first
				then
						-- Moving the unit
					new_index := useless_ids.first;
debug ("REFREEZING")
	io.error.putstring ("Moving ");
	unit_index.trace;
	io.error.putstring (" to ");
	new_index.trace;
	io.error.new_line;
end;
					useless_ids.prune_all (new_index);
					useless_ids.extend (unit_index);
					u.set_index (new_index);
					if new_index.id > max_index then
						max_index := new_index.id
					end;
				elseif unit_index.id > max_index then
						-- the unit is not moved
					max_index := unit_index.id
				end;
				forth
			end;

			if max_index > frozen_index then
				frozen_index := max_index
			end;

				-- clean then useless_ids:
				-- remove the ids > new frozen_level
			from
				useless_ids.start
			until
				useless_ids.after
			loop
				if useless_ids.item.id > frozen_index then
					useless_ids.remove
				else
					useless_ids.forth
				end;
			end;

			set_frozen_level (frozen_index)
				-- Reset the value of counter
			counter.set_value (frozen_index)
debug ("REFREEZING")
	display_useless_ids;
	io.error.putstring ("Frozen level: ");
	io.error.putint (frozen_level);
	io.error.new_line;
end;
		end;

feature {NONE} -- Keep track of the holes in the table

	useless_ids: TWO_WAY_SORTED_SET [COMPILER_ID];
			-- Id corresponding to unvalid units

	display_useless_ids is
		do
			io.error.putstring ("Useless ids: %N");
			from
				useless_ids.start
			until
				useless_ids.after
			loop
				useless_ids.item.trace;
				io.error.new_line;
				useless_ids.forth
			end;
		end;
				
feature -- Re_freezing

	frozen_level: INTEGER is
			-- Melted/Frozen limit
		deferred
		end

	set_frozen_level (level: INTEGER) is
			-- Set `frozen_level' to `level'.
		deferred
		ensure
			frozen_level: frozen_level = level
		end

feature -- Merging

	append (other: like Current) is
			-- Append  `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			counter.append (other.counter);
			from other.start until other.after loop
				force (other.item_for_iteration);
				other.forth
			end
		end

end

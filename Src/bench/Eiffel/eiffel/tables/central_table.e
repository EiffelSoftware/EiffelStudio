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
			make (Chunk);
		end;

	Chunk: INTEGER is 500;
			-- Table chunk


	put (t: T) is
			-- Insert `t' in the table if not already present.
		do
			last_unit := item (t);
			if (last_unit = Void) then
				search_table_put (t);
				t.set_index (count);
				last_unit := t;
			end;
		end;

	mark_melted (t: T) is
			-- Insert `t' in `melted_list'.
		do
			melted_list.start;
			melted_list.put_right (t);
		end;

	freeze is
			-- Wipe out `melted_list'.
		do
			melted_list.wipe_out;
		end;

end

indexing

	description:
		"Undoable command that removes a handle.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_HANDLE

inherit

	DESTROY

creation

	make

feature -- Initialization

	make (the_links: like links; a_handle: like handle) is
		require
			valid_links: the_links /= void;
			links_not_empty: not the_links.empty;
			handle_not_void: a_handle /= void
		local
			cl: CLI_SUP_DATA;
			link: RELATION_DATA;
			cell2: CELL2 [INTEGER, INTEGER];
		do
			links := the_links;
			handle := a_handle;
			!! old_positions.make_filled (links.count);
			!! old_handle_nbrs.make_filled (links.count);
			from
				links.start;
				old_handle_nbrs.start;
				old_positions.start
			until
				links.after
			loop
				link := links.item;
				old_positions.replace (link.break_points.index_of (handle, 1));
				!! cell2.make (0, 0);
				if link.is_client then
					cl ?= link;
					if not cl.label.empty then
						cell2.put1 (cl.label.from_handle_nbr);
					end;
					if cl.is_reverse_link and then not cl.reverse_label.empty then
						cell2.put2 (cl.reverse_label.from_handle_nbr);
					end;
				end;
				old_handle_nbrs.replace (cell2);
				old_handle_nbrs.forth;
				links.forth;
				old_positions.forth
			end;
		ensure
			valid_links: links /= Void;
			valid_handle: handle /= Void;
			valid_old_positions: old_positions /= Void;
			equal_count_for_lists: links.count = old_positions.count
		end;

feature -- Properties

	name: STRING is "Destroy handle"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		local
			item: RELATION_DATA;
			bkpt_pos: INTEGER;
			reverse_c: INTEGER;
			cl: CLI_SUP_DATA;
			cell2: CELL2 [INTEGER, INTEGER];
		do
			from
				links.start;
				old_positions.start;
				old_handle_nbrs.start
			until
				links.after
			loop
				item := links.item;
				bkpt_pos := old_positions.item;
				cell2 := old_handle_nbrs.item;
				item.break_points.go_i_th (bkpt_pos);
				check
					item.break_points.item = handle
				end;
				if item.is_client then
					cl ?= item;
					if cell2.item1 /= 0 then
							-- Has label (add one to position since
							-- break points does not start from source linkable).
						if bkpt_pos + 1 <= cell2.item1 then		
							cl.label.decrement_handle_nbr
						end
					end
					if cell2.item2 /= 0 then
							-- Has reverse label (add one to position since
							-- break points does not start from source linkable).
							-- Test is different from above since bkpt_pos is
							-- from the other direction.
						if bkpt_pos + 1 <= cell2.item2 then		
							cl.reverse_label.decrement_handle_nbr
						end
					end
				end	
				item.break_points.remove;
				links.forth;
				old_handle_nbrs.forth;
				old_positions.forth
			end;
			handle.set_shared (handle.shared-links.count);
			from
				links.start
			until
				links.after
			loop
				workareas.change_data (links.item);
				links.forth
			end;
		end;

	update is
		do
			workareas.refresh;
			System.set_is_modified
		end;

	undo is
			-- Cancel effect of executing the command.
		local
			item: RELATION_DATA;
			cell2: CELL2 [INTEGER, INTEGER]
		do
			from
				links.start;
				old_positions.start;
				old_handle_nbrs.start
			until
				links.after
			loop
				item := links.item;
				cell2 := old_handle_nbrs.item;
				set_handle_nbrs (item, cell2.item1, cell2.item2);
				item.break_points.go_i_th (old_positions.item-1);
				item.break_points.put_right (handle);
				links.forth;
				old_positions.forth;
				old_handle_nbrs.forth
			end;
			handle.set_shared (handle.shared+links.count);
			from
				links.start
			until
				links.after
			loop
				workareas.change_data (links.item);
				links.forth
			end;
		end

feature {NONE} -- Implementation

	links: LINKED_LIST [RELATION_DATA];
			-- Link of handle

	handle: HANDLE_DATA;
			-- Handle destroyed

	old_positions: FIXED_LIST [INTEGER]
			-- Old position of handle

	old_handle_nbrs: FIXED_LIST [CELL2 [INTEGER, INTEGER]]
			-- Old position of handle

feature {NONE} -- Implementation

	set_handle_nbrs (link: RELATION_DATA; nbr, reverse_nbr: INTEGER) is
			-- Set the handle numbers to link label
			-- and reverse label.
		local
			cl: CLI_SUP_DATA
		do
			if link.is_client then
				cl ?= link;
				if nbr /= 0 then
					cl.label.set_from_handle_nbr (nbr)
				end;
				if reverse_nbr /= 0  then
					cl.reverse_label.set_from_handle_nbr (reverse_nbr)
				end
			end
		end;

end

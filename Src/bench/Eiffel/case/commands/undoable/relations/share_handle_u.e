indexing

	description: 
		"Undoable command that adds a shared handle to links.";
	date: "$Date$";
	revision: "$Revision $"

class SHARE_HANDLE_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (to_share, to_merge: like new_handle; old_links: LINKED_LIST [RELATION_DATA]) is
			-- Merge `to_share' with `to_merge' using the links that has
			-- `to_merge' handle.
		require
			valid_to_shar: to_share /= void;
			valid_to_merge: to_merge /= void;
			share_not_eq_merge: to_share /= to_merge;
			valid_links: old_links /= Void and then not old_links.empty
		do
			set_watch_cursor;
			record;
			new_handle := to_share;
			old_handle := to_merge;
			links := old_links;
			--!! links.make;
			--add_links_who_has (data.visible_links);
			check
				links.count = old_handle.shared
			end;
			redo;
			restore_cursor;
		end

feature -- Property

	name: STRING is "Share handle"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			from
				links.start
			until
				links.after
			loop
				links.item.break_points.put_i_th (new_handle,
					links.item.break_points.index_of (old_handle, 1));
				links.forth
			end;
			new_handle.set_shared (new_handle.shared+links.count);
			old_handle.set_shared (old_handle.shared-links.count);
			from
				links.start
			until
				links.after
			loop
				workareas.change_data (links.item);
				links.forth
			end;
			workareas.refresh;
			System.set_is_modified
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			from
				links.start
			until
				links.after
			loop
				links.item.break_points.put_i_th (old_handle,
					links.item.break_points.index_of (new_handle, 1));
				links.forth
			end;
			new_handle.set_shared (new_handle.shared-links.count);
			old_handle.set_shared (old_handle.shared+links.count);
			from
				links.start
			until
				links.after
			loop
				workareas.change_data (links.item);
				links.forth
			end;
			workareas.refresh;
			System.set_is_modified
		end
	
feature {NONE} -- Implementation

	links: LINKED_LIST [RELATION_DATA];
			-- List of links who have `new_handle'

	new_handle: HANDLE_DATA;
			-- Handle destroyed

	old_handle: like new_handle;
			-- Old position of handle

	add_links_who_has (list: LINKED_LIST [RELATION_DATA]) is
			-- Add in links all links in `list' who have `old_handle'.
		require
			list /= void;
		local
			item: RELATION_DATA
		do
			from
				list.start
			until
				list.after
			loop
				item := list.item;
				if item.break_points.has (old_handle) then
					if not links.has (item) then
						links.extend (item)
					end
				end;
				list.forth
			end
		end

end -- class SHARE_HANDLE_U

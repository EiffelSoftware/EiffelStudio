indexing

	description:
		"Undoable command that removes all handles from a link.";
	date: "$Date$";
	revision: "$Revision $"

class REMOVE_HANDLES_U

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (a_link: like link) is
		require
			valid_a_link: a_link /= Void
		local
			cl: CLI_SUP_DATA
		do
			link := a_link;
			!! old_handles.make;
			if a_link.is_client then
				cl ?= a_link;
				old_from_handle_nbr := cl.label.from_handle_nbr;
				if cl.is_reverse_link then
					old_reverse_from_handle_nbr := cl.reverse_label.from_handle_nbr;
				end;
			end;
			old_handles.append (link.break_points);
			record;
			redo
		end;

feature -- Property

	name: STRING is
		do
			Result := "Remove all handles"
		end;

feature -- Update

	redo is
		local
			item: HANDLE_DATA
		do
			set_handle_nbrs (1, 1); 
			link.break_points.wipe_out;
			from
				old_handles.start
			until
				old_handles.after
			loop
				item := old_handles.item;
				item.set_shared (item.shared - 1);
				old_handles.forth;
			end;
			update;
		end;

	undo is
		local
			item: HANDLE_DATA
		do
			from
				old_handles.start
			until
				old_handles.after
			loop
				item := old_handles.item;
				item.set_shared (item.shared + 1);
				link.break_points.extend (item);
				old_handles.forth;
			end;
			set_handle_nbrs (old_from_handle_nbr, old_reverse_from_handle_nbr);
			update;
		end;

	update is
		do
			workareas.change_data (link);
			workareas.refresh;
			System.set_is_modified
		end -- update

feature {NONE} -- Implementation

	link: RELATION_DATA;
			-- Link which became shared or unshared

	old_handles: LINKED_LIST [HANDLE_DATA];

	old_from_handle_nbr: INTEGER;
			-- Old handle from number

	old_reverse_from_handle_nbr: INTEGER;
			-- Old reverse handle from number

	set_handle_nbrs (nbr, reverse_nbr: INTEGER) is
			-- Set the handle numbers to link label
			-- and reverse label.
		local
			cl: CLI_SUP_DATA
		do
			if link.is_client then
				cl ?= link;
				cl.label.set_from_handle_nbr (nbr)
				if cl.is_reverse_link then	
					cl.reverse_label.set_from_handle_nbr (reverse_nbr)
				end
			end
		end;

end -- class REMOVE_HANDLES_U

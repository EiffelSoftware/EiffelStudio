indexing

	description: 
		"Undoable command which adds a reverse link.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_REVERSE_LINK_U 

inherit

	UNDOABLE_EFC

creation

	make, make_with_link

feature -- Initialization

	make (a_link : CLI_SUP_DATA; is_aggregation: BOOLEAN) is
			-- add a reverse link to 'link'
		require
			has_link : a_link /= Void;
		do
			set_watch_cursor;
			if a_link.supplier.client_link_of (a_link.client) = Void then
					-- this question means: is the reverse
					-- of `a_link' already in the system?
				record;
				if is_aggregation then
					if a_link.is_compressed then
						!COMP_CLI_SUP_DATA! other_link.make_aggreg
								(a_link.supplier, a_link.client)
					else
						!! other_link.make_aggreg (a_link.supplier, a_link.client)
					end
				else
					if a_link.is_compressed then
						!COMP_CLI_SUP_DATA! other_link.make_ref
								(a_link.supplier, a_link.client)
					else
						!! other_link.make_ref (a_link.supplier, a_link.client)
					end
				end;
				is_new_link := True;
				link := a_link;
				if other_link.label.from_handle_nbr > link.break_points.count + 1 then
					old_from_handle_nbr := other_link.label.from_handle_nbr;
					new_from_handle_nbr := link.label.from_handle_nbr
				end;
				redo;
			end;
			restore_cursor;
		ensure
			link_correctly_set : link = a_link
		end -- make

	make_with_link (a_link: CLI_SUP_DATA; other_l: like a_link) is
			-- add a reverse link to 'link' with `other_link'.
		require
			has_link: a_link /= Void;
			has_other_link: other_l /= Void;
			valid_links: a_link.supplier = other_l.client and then	
					a_link.client = other_l.supplier
		do
			set_watch_cursor;
			record;
			other_link := other_l;
			link := a_link;
			redo;
			restore_cursor;
		ensure
			link_correctly_set : link = a_link
		end -- make

feature -- Property

	name: STRING is 
		do
			Result := "Add reverse link"
		end;

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			if is_new_link then
				other_link.put_in_system;
			else
				if new_from_handle_nbr /= 0 then
					other_link.label.set_from_handle_nbr (new_from_handle_nbr)
				end;
				if other_link.is_aggregation then
					workareas.destroy_aggreg (other_link)
				else
					workareas.destroy_reference (other_link)
				end
			end;
			link.add_reverse_link (other_link);
			workareas.add_reverse_link (link);
			update;
		end; -- redo

	update is
		local
			class_d: CLASS_DATA
		do
			class_d ?= link.client
			if class_d /= Void then
				class_d.update_display (link.supplier)
			end;
			class_d ?= link.supplier
			if class_d /= Void then
				class_d.update_display (link.client);
			end;
			link.update_editor;
			System.set_is_modified;
			workareas.refresh;
		end; -- update

	undo is
			-- Cancel effect of executing the command
		local
			editor: EC_RELATION_WINDOW
		do
			link.remove_reverse_link;
			workareas.remove_reverse_link (link);
			if is_new_link then
				other_link.remove_from_system;
			else
				if old_from_handle_nbr /= 0 then
					other_link.label.set_from_handle_nbr (old_from_handle_nbr)
				end;
				if other_link.is_aggregation then
					workareas.new_aggreg (other_link)
				else
					workareas.new_reference (other_link)
				end
			end;
			editor := link.editor;
			if editor /= Void then
					-- Redit the link
				--if editor.reverse_side then
				--	editor.set_entity (other_link)
				--else
				--	editor.set_entity (link)
				--end;
			end;
			update;
		end; -- undo

feature {NONE}

	other_link, link: CLI_SUP_DATA;

	is_new_link: BOOLEAN;

	old_from_handle_nbr, new_from_handle_nbr: INTEGER
			-- Old and new from handle nbr

end -- class ADD_REVERSE_LINK_U

indexing

	description: 
		"Undoable command that adds links to a compressed link.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_TO_COMPRESSED_LINK_U

inherit

	UNDOABLE_EFC

creation

	make, make_without_record

feature -- Initialization

	make (a_list: like relation_list; comp_l: like compressed_link) is
			-- Create a new cluster
		require
			valid_a_list: a_list /= void;
			valid_comp_l: comp_l /= void;
		do
			from
				a_list.start
			until
				a_list.after
			loop
				if a_list.item.is_in_compressed_link or else 
					comp_l.has_link (a_list.item)
				then
					a_list.remove
				else
					a_list.forth
				end;
			end;
			if not a_list.empty then
				relation_list := a_list;
				compressed_link := comp_l
				set_watch_cursor;
				is_recorded := True;
				record;
				redo;
				restore_cursor;
			end;
		end

	make_without_record (a_list: like relation_list; comp_l: like
				compressed_link) is
		require
			valid_a_list: a_list /= void;
			valid_comp_l: comp_l /= void;
		do
			relation_list := a_list;
			compressed_link := comp_l;
		end;

feature -- Property

	name: STRING is 
		do
			Result := "Add to compressed link"
		end

feature -- Update

	is_recorded: BOOLEAN;

	update is
		do
			workareas.refresh;
			update_link_editor (compressed_link);
			System.set_is_modified
		end; -- update

	update_link_editor (rel_data: RELATION_DATA) is
		do
			rel_data.update_editor;
			if rel_data.is_in_compressed_link then
				update_link_editor (rel_data.find_compressed_link)
			end;
		end;

	redo is
			-- Re-execute command (after it was undone).
		local
			cli_sup: CLI_SUP_DATA;
			inh: INHERIT_DATA;
			link: RELATION_DATA
		do
			from
				relation_list.start
			until
				relation_list.after
			loop
				link := relation_list.item;
				if not (link.is_in_compressed_link and then
						  not (link.f_rom.parent_cluster.is_icon or else link.t_o.parent_cluster.is_icon)) then
					inh ?= link;
					if inh /= Void then
						workareas.destroy_inherit (inh)
					else
						cli_sup ?= link;
						if cli_sup.is_aggregation then
							workareas.destroy_aggreg (cli_sup)
						else
							workareas.destroy_reference (cli_sup)
						end	
					end
					if not compressed_link.has_link (link) then
						compressed_link.add_relation (link.key);
					end
					relation_list.forth
				end
			end;
			if is_recorded then
				update
			end
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		local
			link: RELATION_DATA
		do
			from
				relation_list.start
			until
				relation_list.after
			loop
				link := relation_list.item;
				if link.is_in_compressed_link and then
					(not (link.f_rom.parent_cluster.is_icon or else link.t_o.parent_cluster.is_icon)) then
					compressed_link.remove_relation (link);
					workareas.change_data (link);
				end;
				relation_list.forth
			end
			if is_recorded then
				update
			end
		end; -- undo

feature {NONE} -- Implementation

	relation_list: LINKED_LIST [RELATION_DATA];
			-- New link

	compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY];

end -- class ADD_TO_COMPRESSED_LINK_U

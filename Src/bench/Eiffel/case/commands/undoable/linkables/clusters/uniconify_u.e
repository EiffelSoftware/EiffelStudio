indexing

	description: 
		"Undoable command to deiconify a cluster.";
	date: "$Date$";
	revision: "$Revision $"


class UNICONIFY_U

inherit

	ICONIZATION

creation

	make

feature -- Initialization

	make (a_cluster: CLUSTER_DATA; workarea_data: CLUSTER_DATA) is
			-- Iconify a cluster.
		require
			a_cluster /= void;
			a_cluster.is_icon
		local
			rel_data: RELATION_DATA;
			system_def_links: like links;
			comp_data: COMP_LINK_DATA [RELATION_DATA_KEY];
			cluster_data: CLUSTER_DATA
		do
		--	Windows.set_watch_cursor;
			cluster := a_cluster;
			!! remove_commands.make;
			!! links.make;
			system_def_links := cluster.extern_inherit_links;
			system_def_links.append (cluster.extern_client_links);
				-- Need this for visible_descendant_of
			cluster.set_icon (False);
			from
				system_def_links.start
			until
				system_def_links.after
			loop
				rel_data := system_def_links.item;
				if rel_data.is_compressed then
					comp_data ?= rel_data;
					formulate_lists (comp_data, workarea_data);
				elseif rel_data.is_system_defined then
					links.put_front (rel_data);
				end;
				system_def_links.forth
			end;
			!! enlarge_cluster.make (cluster, 0, 0);
				-- Need this for visible_descendant_of
				-- and for enlarge_cluster
			cluster.set_icon (True);
			record;
			redo;
		--	Windows.restore_cursor;
		ensure
			cluster_correctly_set : cluster = a_cluster
		end -- make

	formulate_lists (comp_data: COMP_LINK_DATA [RELATION_DATA_KEY];
				workarea_data: CLUSTER_DATA) is
		require
			valid_comp_data: comp_data /= Void
		local
			rel_data: RELATION_DATA;
			rel_list: like links;
			comp_data1: like comp_data;
			remove_from_comp_link_u: REMOVE_FROM_COMP_LINK_U;
			all_defined: BOOLEAN
		do
			all_defined := True;
			!! rel_list.make;
			from
				comp_data.start
			until
				comp_data.after
			loop
				rel_data := comp_data.item.data;
				if rel_data /= Void then
					if rel_data.t_o.visible_descendant_of
							(workarea_data) and then
						rel_data.f_rom.visible_descendant_of
							(workarea_data)
					then
						if rel_data.is_system_defined then
							comp_data1 ?= rel_data;
							if comp_data1 = Void or else
								comp_data1.all_visible_to (workarea_data) 
							then
								rel_list.put_front (rel_data);
							end
						end;
					else
						all_defined := False
					end;
				end;
				comp_data.forth
			end;
			if not rel_list.empty then
				!! remove_from_comp_link_u.make_without_record 
					(rel_list, comp_data);
				remove_commands.put_front (remove_from_comp_link_u)
			end;
			links.append (rel_list);
			if all_defined then
				if comp_data.is_system_defined and then
					not links.has (comp_data) and then
					comp_data.all_visible_to (workarea_data) 
				then
					links.put_front (comp_data)
				end
			end;
			from
				comp_data.start
			until
				comp_data.after
			loop
				comp_data1 ?= comp_data.item.data;
				if comp_data1 /= Void then
					formulate_lists (comp_data1, workarea_data);
				end;
				comp_data.forth
			end;
		end;

feature -- Property

	name: STRING is "Deiconify cluster"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		local
			rel_data: RELATION_DATA
		do
			from
				remove_commands.start
			until
				remove_commands.after
			loop
				remove_commands.item.redo;
				remove_commands.forth
			end;
			from
				links.start
			until
				links.after
			loop
				links.item.update_system_defined (false);
				links.forth
			end;
			deiconize;
			enlarge_cluster.redo;
			graphicals_update;
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		do
			from
				links.start
			until
				links.after
			loop
				links.item.update_system_defined (True);
				links.forth
			end;
			iconize;
			from
				remove_commands.start
			until
				remove_commands.after
			loop
				remove_commands.item.undo;
				remove_commands.forth
			end;
			enlarge_cluster.undo;
			graphicals_update;
		end -- undo

feature {NONE} -- Implementation

	links: LINKED_LIST [RELATION_DATA];

	remove_commands: LINKED_LIST [REMOVE_FROM_COMP_LINK_U];

	enlarge_cluster: ENLARGE_CLUSTER;

end -- UNICONIFY_U

indexing

	description: 
		"Undoable command to destroy a cluster data.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_CLUSTER

inherit

	DESTROY
		redefine
			data, free_data
		end;
	ONCES

creation

	make, make_subcluster

feature {DESTROY_ENTITIES_U} -- Implementation

	update is
		do
--			Workareas.refresh;
--			Workareas.update_cluster_chart (data, data.stone_type);
--			Windows.update_cluster_info_in_windows (data, True);
--			System.set_is_modified
		end;

	redo is
			-- Re-execute command (after it was undone).
		do
			from
				old_inherit.start
			until
				old_inherit.after
			loop
				if old_inherit.item.is_in_system then
					old_inherit.item.remove_from_system
				end;
				old_inherit.forth
			end;
			from
				old_cli_sup.start
			until
				old_cli_sup.after
			loop
				if old_cli_sup.item.is_in_system then
					old_cli_sup.item.remove_from_system
				end;
				old_cli_sup.forth
			end;
			from
				destroy_list.start
			until
				destroy_list.after
			loop
				destroy_list.item.redo;
				destroy_list.forth;
			end;
			data.remove_from_system;
			workareas.destroy_cluster (data);
			data.clear_editor;
			if not not_top then
				update;
			end;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data.put_in_cluster (cluster_parent);
			workareas.new_cluster (data);
				-- at this point skip the 'destroy cluster' commands
			from
				destroy_list.start
			until
				destroy_list.after
			loop
				destroy_list.item.undo;
				destroy_list.forth;
			end;
			from
				old_inherit.start
			until
				old_inherit.after
			loop
				if not old_inherit.item.is_in_system then
					old_inherit.item.put_in_system;
					workareas.new_inherit (old_inherit.item)
				end;
				old_inherit.forth
			end;
			from
				old_cli_sup.start
			until
				old_cli_sup.after
			loop
				if not old_cli_sup.item.is_in_system then
					old_cli_sup.item.put_in_system;
					if old_cli_sup.item.is_aggregation then
						workareas.new_aggregation (old_cli_sup.item)
					else
						workareas.new_reference (old_cli_sup.item)
					end
				end;
				old_cli_sup.forth
			end
			if not not_top then
				update;
			end;
		end;

	free_data is
		do
			if not data.is_in_system then
				from
					destroy_list.start
				until
					destroy_list.after
				loop
					destroy_list.item.free_data;
					destroy_list.forth
				end
			end
		end;

feature {NONE} -- Implementation

	data: CLUSTER_DATA;
			-- Cluster destroyed

	old_inherit: LINKED_LIST [INHERIT_DATA];
			-- Old inherit links destroyed with `old_class'

	old_cli_sup: LINKED_LIST [CLI_SUP_DATA];
			-- Old client/supplier links destroyed with `old_class'

	cluster_parent: CLUSTER_DATA
			-- Cluster in which the class is created

	destroy_list: LINKED_LIST [DESTROY]

feature {NONE} -- Implementation

	name: STRING is "Destroy cluster";

	make (a_cluster: like data) is
			-- Create a new class
		require
			has_cluster: a_cluster /= void
		local
			cl: LINKED_LIST [ CLASS_DATA ]
			clus: LINKED_LIST [ CLUSTER_DATA ]
			ds: DESTROY_CLUSTER;
			dc: DESTROY_CLASS;
		do
			cluster_parent := a_cluster.parent_cluster;
			data := a_cluster;
			old_inherit := data.recursive_inherit_links;
			old_cli_sup := data.recursive_cli_sup_links
			!! destroy_list.make;
			clus := data.clusters;
			from
				clus.start
			until
				clus.after
			loop
				-- pascalf, let's put a bit a recurisvity 
				-- indeed, this algorithm was false => forget the classes after level 1
				--ds ?= clus.item.stone.destroy_subcluster_command;
				!! ds.make ( clus.item )
				--
				destroy_list.extend (ds);
				clus.forth
			end;
			cl := data.classes;
			from
				cl.start
			until
				cl.after
			loop
				dc ?= cl.item.stone.destroy_subclass_command;
				destroy_list.extend (dc);
				cl.forth
			end;
		ensure
			correctly_set: data = a_cluster
		end;

	make_subcluster (a_data: like data)  is
		require
			valid_a_data: a_data /= Void
		do
			cluster_parent := a_data.parent_cluster;
			data := a_data;
			!! destroy_list.make;
			!! old_inherit.make;
			!! old_cli_sup.make;
			not_top := True;
		ensure
			correctly_set: data = a_data
		end;

feature {NONE}

	not_top: BOOLEAN;
		-- is `data' not the cluster that actually was removed?

invariant

	has_inherit_links_list: old_inherit /= void;
	has_cli_sup_links_list: old_cli_sup /= void;
	has_parent: cluster_parent /= void

end -- class DESTROY_CLUSTER

indexing

	description: 
		"Undoable command for class data destruction.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_CLASS

inherit

	DESTROY
		redefine
			data, free_data
		end

	ONCES

	SHARED_FILE_SERVER

creation

	make, make_subclass

feature -- Initialization

	make (a_class: like data) is
			-- Create a new class
		require
			has_class: a_class /= void
		do
			cluster_parent := a_class.parent_cluster;
			data := a_class;
			old_inherit := data.recursive_inherit_links
			old_cli_sup := data.recursive_cli_sup_links
		ensure
			correctly_set: data = a_class
		end

	make_subclass (a_class: like data) is
			-- Create a new class
		require
			has_class: a_class /= void
		do
			cluster_parent := a_class.parent_cluster;
			data := a_class;
			!! old_inherit.make; 
			!! old_cli_sup.make;
		ensure
			correctly_set: data = a_class
		end

feature -- Property

	name: STRING is "Destroy class";

feature {DESTROY_ENTITIES_U} -- Implementation

	free_data is
		do
			if not data.is_in_system then
				Class_content_server.undo_remove_class_data (data);
				data.remove_class_content_from_disk
			end
		end;

	update is
		do
--			data.update_display (data);
--			Workareas.refresh;
--			Workareas.update_cluster_chart (data.parent_cluster, data.stone_type);
--			Windows.update_class_info_in_windows (data);
--			System.set_is_modified
		end;

	redo is
			-- Re-execute command (after it was undone).
		local
			heir: CLASS_DATA
		do
			from
				old_inherit.start
			until
				old_inherit.after
			loop
				if old_inherit.item.is_in_system then
					heir ?= old_inherit.item.heir;
					old_inherit.item.remove_from_system;
					if heir /= Void then
						heir.update_display (data);
					end;
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
			-- pascalf, to avoid to loose the name of the class
				if	system.hyper_system_classes	/= void
				then
					System.hyper_system_classes.force(data.name, data.id )
				end
			--
			data.remove_from_system;
			workareas.destroy_class (data);
			Class_content_server.remove_class_data (data)
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data.put_in_cluster (cluster_parent);
			workareas.new_class (data);
			from
				old_inherit.start
			until
				old_inherit.after
			loop
				if not old_inherit.item.is_in_system 
				then
					if	old_inherit.item.heir	/= void	and
						old_inherit.item.parent	/= void
					then
						if old_inherit.item.heir.is_in_system and
						old_inherit.item.parent.is_in_system
						then
							old_inherit.item.put_in_system;
							workareas.new_inherit (old_inherit.item)
						end
					end
				end;
				old_inherit.forth
			end;
			from
				old_cli_sup.start
			until
				old_cli_sup.after
			loop
				if not old_cli_sup.item.is_in_system then
					if old_cli_sup.item.client.is_in_system and
					old_cli_sup.item.supplier.is_in_system
					then
						old_cli_sup.item.put_in_system;
						if old_cli_sup.item.is_aggregation then
							workareas.new_aggregation (old_cli_sup.item)
						else
							workareas.new_reference (old_cli_sup.item)
						end
					end
				end;
				old_cli_sup.forth
			end;
			--Class_content_server.undo_remove_class_data (data)
			--data.set_is_modified;
		end

feature {NONE} -- Private data

	data: CLASS_DATA;
			-- Class destroyed

	old_inherit: LINKED_LIST [INHERIT_DATA];
			-- Old inherit links destroyed with `old_class'

	old_cli_sup: LINKED_LIST [CLI_SUP_DATA];
			-- Old client/supplier links destroyed with `old_class'

	cluster_parent: CLUSTER_DATA
			-- Cluster in which the class is created

invariant

	has_inherit_links_list: old_inherit /= void;
	has_cli_sup_links_list: old_cli_sup /= void;
	has_parent: cluster_parent /= void

end -- class DESTROY_CLASS

indexing

	description: 
		"Abstract class for adding linkable data.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ADD_ENTITY 

inherit

	MOVE
		undefine
			redo, undo
		end;

feature {NONE} -- Implementation

	cluster_parent: CLUSTER_DATA;
			-- Cluster in which the cluster is created

	graphicals_update is
		do
			--windows.set_watch_cursor;
			--windows.system_window.update_page (entity.stone_type);
			--workarea.refresh;
			System.set_is_modified;
			--windows.restore_cursor;
		end; -- graphicals_update

	move_figure is
		do
			entity.put_in_cluster (cluster_parent)
		end; -- move_figure

	unmove_figure is
		local
			a_linkable : LINKABLE_DATA
		do
			a_linkable ?= entity;
			a_linkable.remove_from_system
		end -- unmove_figure

end -- class ADD_ENTITY

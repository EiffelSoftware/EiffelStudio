indexing

	description: 
		"Undoable command for adding class data.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_CLASS_U 

inherit

	ADD_ENTITY
		redefine
			free_data
		end;
	SHARED_FILE_SERVER

creation

	make

feature -- Initialization

	make (cluster: like cluster_parent; a_class: like entity; w: like workarea) is
			-- Create a new class.
		require
			has_a_cluster_parent: cluster /= void;
			class_exists: a_class /= void
		do
			record;
			cluster_parent := cluster;
			entity := a_class;
			workarea := w
			redo
		end -- make

feature -- Properties

	workarea: WORKAREA

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			move_figure
			observer_management.update_observer (system)
			--workarea.new_class (entity)
			Class_content_server.undo_remove_class_data (entity)   
			update
		end

	undo is
			-- Cancel effect of executing the command
		do
			unmove_figure
			Class_content_server.remove_class_data (entity)   
			workareas.destroy_class (entity)
			update
		end

	update is
		do
			graphicals_update;
			Workareas.update_cluster_chart (entity.parent_cluster, entity.stone_type);
			--Windows.update_class_info_in_windows (entity);
		end;

	free_data is
		do
			if not entity.is_in_system then
				Class_content_server.undo_remove_class_data (entity);    
				entity.remove_class_content_from_disk
			end
		end;

feature {NONE} -- Property

	entity : CLASS_DATA;

	name: STRING is "New class"

end -- class ADD_CLASS_U

indexing

	description: 
		"Command to rurn an oblique relation into an right angle relation";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_SET_ANGLE_COM

inherit

	WORKAREA_MOVE_COM

creation

	make

feature -- Execution

	execute_button_motion (notused: NONE; motnot_data: EV_MOTION_EVENT_DATA) is
--			-- Called when the mouse is moved.
--		local
--			is_selected: BOOLEAN
		do
--			is_selected := relation.active_triangles.item (arrow).contains_xy
--				(motnot_data.relative_x, motnot_data.relative_y);
--			if is_selected /= arrow_selected then
--				arrow_selected := is_selected;
--				if arrow_selected then
--					relation.active_triangles.item (arrow).select_it
--				else
--					relation.active_triangles.item (arrow).unselect
--				end
--			end
--		ensure then
--			has_relation: relation /= void
		end; 
--
	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
--		local
--			direction: BOOLEAN;
--			new_x, new_y: INTEGER;
--			parent_group: GRAPH_GROUP;
--			new_handle: HANDLE_DATA;
--			new_handle_undoable: ADD_HANDLE_U
		do
	--		if arrow_selected then
	--			relation.active_triangles.item (arrow).unselect;
	--			direction := (arrow = 1) xor (
	--				(relation.final.x-relation.start.x)*
	--				(relation.final.y-relation.start.y) < 0);
	--			if direction then
	--				new_x := relation.to_form.center.x;
	--				new_y := relation.from_form.center.y
	--			else
	--				new_x := relation.from_form.center.x;
	--				new_y := relation.to_form.center.y
	--			end;
	--			parent_group := workarea.cluster_at (new_x, new_y);
	--			if parent_group = void then
	--				parent_group := workarea
	--			end;
	--			!!new_handle;
	--			new_handle.set_x (new_x-parent_group.local_x);
	--			new_handle.set_y (new_y-parent_group.local_y);
	--			new_handle.put_in_cluster (parent_group.data);
	--			!! new_handle_undoable.make (relation, 0, new_handle,
	--						butrel_data.relative_x, butrel_data.relative_y)
	--		end;
	--		workarea.remove_button_motion_action (1, Current, void);
	--		workarea.remove_button_release_action (1, Current, void);
	--		if Environment.is_motif then
	--			Windows.restore_cursor;
	--		else
	--			workarea.ungrab
	--		end;
	--		relation := void
		ensure then
			has_no_relation: relation = void
		end 

feature {NONE} -- Properties

	relation: GRAPH_RELATION;
			-- Relation in which we add a handle

	arrow: INTEGER;
			-- Arrow selected to do the right angle (1 or 2)

	arrow_selected: BOOLEAN;
			-- Is an arrow selected ?

	relation_selected : BOOLEAN
			-- Is 'relation' selected ?

feature {WORKAREA_SELECT_COM} -- Setting

	set_relation (new_relation: like relation) is
			-- Set relation in which we add a handle.
		require
			new_relation_exists: new_relation /= void
		do
			relation := new_relation
		ensure
			correctly_set: relation = new_relation
		end; -- set_relation

	set_arrow (no: like arrow) is
			-- Set arrow value.
		require
			no_1_or_2: (no = 1) or (no = 2)
		do
			arrow := no;
			arrow_selected := true
		ensure
			correctly_set: arrow = no;
			arrow_selected: arrow_selected
		end -- set_arrow

end -- class WORKAREA_SET_ANGLE_COM

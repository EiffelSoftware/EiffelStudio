indexing

	description: 
		"Specify undoable actions used to move several figures.";
	date: "$Date$";
	revision: "$Revision $"

deferred class MULTIPLE_MOVE_U 

inherit

	MOVE_U;
	CONSTANTS

feature -- Update

	redo is
		do
			move_figures;
			graphical_update
		end; -- redo

	undo is
		do
			unmove_figures;
			graphical_update;
		end -- undo

feature {NONE} -- Implemention property

	movables_list: SORTED_TWO_WAY_LIST [MOVABLE_U];
			-- List of figures moved

	must_update_system_comp: BOOLEAN;

feature {NONE} -- Implemention 

	move_figures is
			-- move all figures of 'movables_list'
		do
			from
				movables_list.start
			until
				movables_list.off
			loop
				movables_list.item.redo;
				movables_list.forth
			end
		end; -- move_figures

	unmove_figures is
			-- Cancel effect of moving the figures of 'movables_list'
		do
			from
				movables_list.start
			until
				movables_list.off
			loop
				movables_list.item.undo;
				movables_list.forth
			end
		end; -- unmove_list

	graphical_update is
		do
			workareas.refresh;
			--workareas.update_cluster_chart (Void, Stone_types.class_type);
			if must_update_system_comp then
				--windows.system_window.update_page (Stone_types.class_type);
			end;
			System.set_is_modified
		end -- graphicals_update


invariant

	has_list : movables_list /= Void;
	list_not_empty : not movables_list.empty


end -- class MULTIPLE_MOVE_U

indexing
	description: "Add a figure in the application editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class APP_ADD_FIGURE

inherit
	APP_COMMAND

	APP_FIND_FIGURE

feature -- Access

	undo is 
		local
			sel_figure: STATE_CIRCLE
			transitions: TRANSITION
		do 
			transitions := application_editor.transitions
			sel_figure := application_editor.selected_figure
			figures.start
			figures.search (figure)
			if not figures.after then
				figures.remove
			end
			transitions.remove_element (figure.data)
			if sel_figure = figure then
					-- currently selected
				application_editor.set_selected (application_editor.initial_state_circle)
			end
			undo_executed := True
			perform_update_display
		end

	execute (arg: EV_ARGUMENT2 [EV_POINT, BUILD_STATE]; ev_data: EV_EVENT_DATA) is
			-- Add a state to the application if the state_stone
			-- is not used by an existing circle. Create a circle 
			-- and perform the specific_work. 
		local
			transitions: TRANSITION
		do
			transitions := application_editor.transitions
			point := arg.first
			find_figure (arg.second) 
			if figures.after then 
				create figure.make 
				figure.init 
				figure.set_data (arg.second)
				do_specific_work
				update_history
			end
		end

feature {NONE} -- Implementation

	do_specific_work is
			-- Add figure to the figures and draw it, and 
			-- update the transitions with the figures data. 
		local
			transitions: TRANSITION
		do
			transitions := application_editor.transitions
			transitions.init_element (figure.data) 
			figures.append (figure) 
			figure.set_center (point) 
			perform_update_display
		end

	update_display is
		do
			if undo_executed then
				application_editor.draw_figures
				undo_executed := False
			else
				figure.draw 
			end
			application_editor.display_states 
			application_editor.display_transitions
		end

	name: STRING is
		do
			Result := Command_names.app_add_state_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if figure /= Void and then figure.label /= Void then
				Result.append (figure.label)
			end
		end

feature {NONE} -- Private attributes

	point: EV_POINT
			-- Point where figure was removed

	figure: STATE_CIRCLE
			-- Circle added 

	undo_executed: BOOLEAN
			-- Was undo execute ?

	figures: APP_FIGURES is
		do
			Result := application_editor.figures
		end

end -- class APP_ADD_FIGURE



deferred class APP_ADD_FIGURE 

inherit

	APP_COMMAND
	
feature {NONE}

	x, y: INTEGER;
			-- Point where figure was removed;

	figure: STATE_CIRCLE;
			-- Circle added 

	undo_executed: BOOLEAN;
			-- Was undo execute ?

	
feature 

	set_initial_point is
			-- Set the default initial point of placing the figure.
		do
			x := 50;
			y := 50;
		end;

	undo is 
		local
			figures: APP_FIGURES;
			sel_figure: STATE_CIRCLE;
			transitions: TRANSITION
		do 
			figures := application_editor.figures;
			transitions := application_editor.transitions;
			sel_figure := application_editor.selected_figure;
			figures.start;
			figures.search (figure);
			if not figures.after then
				figures.remove
			end;
			transitions.remove_element (figure.data);
			if 			-- currently selected
				sel_figure = figure
			then
				application_editor.set_selected (application_editor.initial_state_circle)
			end;
			undo_executed := True;
			perform_update_display;
		end; -- undo

	
feature {NONE}

	do_specific_work is
			-- Add figure to the figures and draw it, and 
			-- update the transitions with the figures data. 
		local
			figures: APP_FIGURES;
			transitions: TRANSITION;
			point: COORD_XY_FIG
		do
			figures := application_editor.figures;
			transitions := application_editor.transitions;
			transitions.init_element (figure.data); 
			figures.append (figure); 
			!!point;
			point.set (x, y);
			figure.set_center (point); 
			perform_update_display;
		end;

	update_display is
		do
			if undo_executed then
				application_editor.draw_figures;
				undo_executed := false
			else
				figure.draw; 
			end;
			application_editor.display_states; 
			application_editor.display_transitions;
		end;

	worked_on: STRING is
		do
			!!Result.make (0);
			-- added by samik
			if figure /= Void then
				Result.append (figure.label);
			else 
				Result.append ("Figure is Void")
			end
			--end of samik
		end; -- worked_on

end 

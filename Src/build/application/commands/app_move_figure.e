
class APP_MOVE_FIGURE 

inherit 

	APP_SHARED
		export
			{NONE} all
		end;
	APP_COMMAND
		redefine
			redo	
		end;
	APP_CMD_NAMES
		rename
			App_move_figure_cmd_name as c_name
		export
			{NONE} all
		end
	
feature 

	redo is 
		do
			undo;
			perform_update_display
		end;

	undo is
		local
			temp_x, temp_y: INTEGER;
			point: COORD_XY_FIG
		do
			temp_x := figure.center.x;
			temp_y := figure.center.y;
			!!point;
			point.set (old_x, old_y);
			figure.set_center (point);
			old_x := temp_x;
			old_y := temp_y;
			perform_update_display
		end; -- undo
	
feature {NONE}

	old_x, old_y: INTEGER;

	figure: STATE_CIRCLE;

	work (a_figure: STATE_CIRCLE) is
			-- Record the movement of a figure. 
		local
			moved: BOOLEAN;
			o_of_b: BOOLEAN
		do 
			figure := a_figure;
			old_x := figure.center.x;
			old_y := figure.center.y;
			update_history
		end; -- work

	do_specific_work is
			-- Do nothing.
		do
		end; -- specific_work

	update_display is
		local
			lines: APP_LINES
		do
			lines := application_editor.lines;
			lines.update (figure);
			application_editor.draw_figures
		end; -- update_display

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (figure.label);
		end; -- worked_on

end

indexing
	description: "Undoable command to move a figure in the application editor."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class APP_MOVE_FIGURE 

inherit 
	APP_COMMAND
		redefine
			redo	
		end

	SHARED_APPLICATION

feature -- Access

	execute (arg: EV_ARGUMENT1 [STATE_CIRCLE]; ev_data: EV_EVENT_DATA) is
			-- Record the movement of a figure. 
		do 
			figure := arg.first
			old_x := figure.center.x
			old_y := figure.center.y
			update_history
		end

	redo is 
		do
			undo
			perform_update_display
		end

	undo is
		local
			temp_x, temp_y: INTEGER
			point: EV_POINT
		do
			temp_x := figure.center.x
			temp_y := figure.center.y
			create point.set (old_x, old_y)
			figure.set_center (point)
			old_x := temp_x
			old_y := temp_y
			perform_update_display
		end
	
feature {NONE} -- Implemantation

	old_x, old_y: INTEGER

	figure: STATE_CIRCLE

	name: STRING is
		do
			Result := Command_names.app_move_figure_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if figure /= Void then
				Result.append (figure.label)
			end
		end

	do_specific_work is
			-- Do nothing.
		do
		end

	update_display is
		local
			lines: APP_LINES
		do
			lines := application_editor.lines
			lines.update (figure)
			application_editor.draw_figures
		end

end -- class APP_MOVE_FIGURE


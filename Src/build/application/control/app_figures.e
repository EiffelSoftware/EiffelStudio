indexing
	description: "List of state circles."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class APP_FIGURES 

inherit
	EB_DRAWING_BOX [STATE_CIRCLE] 
		rename
			element as figure,
			selected_element as selected_figure,
			point as previous_point
		redefine
			make, select_figure, execute
		end

	SHARED_APPLICATION

	CONSTANTS

	WINDOWS

creation
	make

feature {NONE} -- Creation

	make (a_drawing: APP_DR_AREA) is
			-- Set `drawing_area' to a_drawing and set 'world' to `a_world' 
			-- Use `editor' for the move_command.
		do
			Precursor (a_drawing)
			set_find_mode
			add_callbacks
		end

	add_callbacks is
		local
			cmd: EV_ROUTINE_COMMAND
		do
			drawing_area.add_button_press_command (1, Current, Void)
			create cmd.make (~execute_move)
			drawing_area.add_motion_notify_command (cmd, Void)
			create cmd.make (~execute_release)
			drawing_area.add_button_release_command (1, cmd, Void)
		end 

feature -- Selecting and moving a figure 

	out_of_bounds: BOOLEAN	
			-- Is the moving_figure out of the drawing_area?

	set_selected (c: STATE_CIRCLE) is
			-- Set selected_figure to `c'
		do
			selected_figure := c
		end

	select_figure (lx, ly: INTEGER) is
			-- Select the figure. Set movable_figure to figure 
			-- (i.e. application or state_circle) found. 
			-- If found and it is an application don't do anything more, 
			-- else select or deselect a circle.
		do
			Precursor (lx, ly)
			find (lx, ly)
			if found then
				movable_figure := figure
			end
			if not found and then selected_figure /= Void then
				selected_figure.deselect
				selected_figure := Void
			else
				movable_figure := selected_figure
			end
		end 


feature {NONE} -- Movement of a figure 

	moving_figure: EV_CLOSED_FIGURE
			-- Figure being moved around the drawing_area

	movable_figure: STATE_CIRCLE
			-- Figure that is able to be moved 

	moved: BOOLEAN
			-- Has any figure been moved ?

	move_figure (pt: EV_POINT) is
			 	-- Move figure to new position according to
				-- mouse position `pt'.
		local
			v: EV_VECTOR
		do
			if not moved then
				moving_figure := movable_figure.moving_figure
				moving_figure.attach_drawing (drawing_area)
				moving_figure.draw
				moved := True
			end
			if pt.x < 0 or else pt.y < 0 or else
				(pt.x > drawing_area.width) or else
				(pt.y > drawing_area.height)
			then
				out_of_bounds := True
			else
				out_of_bounds := False
				v := pt - previous_point
				moving_figure.draw
				moving_figure.translate (v)
				moving_figure.draw
				previous_point := pt
			end
		end

feature {APP_FIGURES} -- Commands 

	execute (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Press the button.
		do 
			Precursor (arg, ev_data)
			if found then
				movable_figure := figure
--				drawing_area.grab (Cursors.move_cursor)
			end
		end 

	execute_move (arg: EV_ARGUMENT; ev_data: EV_MOTION_EVENT_DATA) is
			-- Move the selected figure.
		local
			pt: EV_POINT
		do
			if ev_data.first_button_pressed and then found then
				create pt.set (ev_data.x, ev_data.y)
				move_figure (pt)
			end
		end

	execute_release (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Release the button.
		local
			temp: STATE_CIRCLE
			lines: APP_LINES
			move_cmd: APP_MOVE_FIGURE
			st: EV_ARGUMENT1 [like movable_figure]
			v: EV_VECTOR
		do
			if out_of_bounds then
				moving_figure.draw
				moving_figure := Void
				out_of_bounds := False
				moved := False
			elseif moved then
					-- Figure was moved
				create move_cmd
				create st.make (movable_figure)
				move_cmd.execute (st, Void)

				v := moving_figure.center - movable_figure.center
				movable_figure.translate (v)

				temp := movable_figure
				start
				search (movable_figure)
				if not after then
					remove
				end
				movable_figure := temp
				append (movable_figure)
				moving_figure := Void
				lines := App_editor.lines
				lines.update (movable_figure)
				App_editor.draw_figures
				moved := False
			end
			if found then
--				App_editor.ungrab
			end
		end

end -- class APP_FIGURES


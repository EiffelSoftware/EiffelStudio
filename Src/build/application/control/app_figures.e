
class APP_FIGURES 

inherit

	EB_DRAWING_BOX [STATE_CIRCLE] 
		rename
			make as box_make, 
			select_figure as old_select,
			element as figure,
			selected_element as selected_figure,
			point as previous_point,
			Second as move_action,
			Third as release_action,
			Fourth as set_stone
		redefine
			execute
		select
			set_stone, release_action,
			move_action, previous_point, figure
		end;
	EB_DRAWING_BOX [STATE_CIRCLE]
		rename
			make as box_make,
			selected_element as selected_figure
		redefine
			select_figure, execute
		select
			select_figure
		end;
	SHARED_APPLICATION;
	CONSTANTS;
	WINDOWS

creation

	make

feature {NONE} -- Creation

	make (a_drawing: APP_DR_AREA) is
			-- Set `drawing_area' to a_drawing and set 'world' to `a_world' 
			-- Use `editor' for the move_command.
		do
			box_make (a_drawing);
			!!move_command;
			set_find_mode
		end;

feature

	add_callbacks is
		do
			drawing_area.add_button_press_action (1, Current, select_action);
			drawing_area.add_button_motion_action (1, Current, move_action);
			drawing_area.add_button_release_action (1, Current, release_action);
		end; 

feature -- Selecting and moving a figure 

	out_of_bounds: BOOLEAN;	
			-- Is the moving_figure out of the drawing_area?

	set_selected (c: STATE_CIRCLE) is
			-- Set selected_figure to `c'
		do
			selected_figure := c
		end; -- set_selected_figure

	select_figure is
			-- Select the figure. Set movable_figure to figure 
			-- (i.e. application or state_circle) found. 
			-- If found and it is an application don't do anything more, 
			-- else select or deselect a circle.
		do
			old_select;
			find;
			if
				found
			then
				movable_figure := figure;
			end;
			if
				not found and (selected_figure /= Void)
			then
				selected_figure.deselect;
				selected_figure := Void
			else
				movable_figure := selected_figure
			end;
		end; 


feature {NONE} -- Movement of a figure 

	move_command: APP_MOVE_FIGURE;
			-- Command executed when figure is moved

	moving_figure: CLOSED_FIG;
			-- Figure being moved around the drawing_area

	movable_figure: STATE_CIRCLE;
			-- Figure that is able to be moved 

	moved: BOOLEAN;
			-- Has any figure been moved ?

	move_figure is
			 	-- Move figure to new position according to mouse position.
		local
			lpoint, curr_p, prev_p: COORD_XY_FIG;
			lx1, ly1, byX, byY: INTEGER;
		do
			curr_p := current_point;
			prev_p := previous_point;
			if not moved then
				moving_figure := movable_figure.moving_figure;
				moving_figure.attach_drawing (drawing_area);
				moving_figure.draw;
				moved := true
			end;
			lx1 := curr_p.x;
			ly1 := curr_p.y;
			if lx1 < 0 or ly1 < 0 or
				(lx1 > drawing_area.width) or
				(ly1 > drawing_area.height)
			then
				out_of_bounds := true;
			else
				out_of_bounds := false;
				byX := curr_p.x - prev_p.x;
				byY := curr_p.y - prev_p.y;
				moving_figure.draw;
				moving_figure.xytranslate (byX, byY);
				moving_figure.draw;
				previous_point := curr_p;
			end;
		end; -- move_figure

feature {NONE} -- Execute 

	execute (argument: ANY) is
			-- Execute the command.
		local
			temp: STATE_CIRCLE;
			x0, x1, y0, y1: INTEGER;
			lines: APP_LINES;
			state: BUILD_STATE;
			cloned_move: APP_MOVE_FIGURE
		do 
			if argument = move_action then
				if found then
					move_figure
				end;
			elseif argument = release_action then
				if out_of_bounds then
					moving_figure.draw;
					moving_figure := Void;
					out_of_bounds := false;
					moved := false;
				elseif moved then
						-- Figure was moved
					cloned_move := clone (move_command);
					cloned_move.execute (movable_figure);
					x0 := moving_figure.center.x;
					y0 := moving_figure.center.y;
					x1 := movable_figure.center.x;
					y1 := movable_figure.center.y;
					movable_figure.xytranslate ((x0-x1), (y0-y1));
					temp := movable_figure;
					start;
					search (movable_figure);
					if not after then
						remove
					end;
					movable_figure := temp;
					append (movable_figure);
					moving_figure := Void;
					lines := App_editor.lines;
					lines.update (movable_figure);
					App_editor.draw_figures;
					moved := false
				end;
				if found then
					App_editor.ungrab
				end;
			elseif
				argument = select_action
			then
				find;
				if found then
					movable_figure := figure;
					drawing_area.grab (Cursors.move_cursor);
				end;
			end;
		end; 

end 

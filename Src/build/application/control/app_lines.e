
class APP_LINES 

inherit

	DRAWING_BOX [STATE_LINE] 
		rename
			make as box_make, 
			selected_element as selected_line,
			select_figure as old_select,
			element as line, 
			append as drawing_list_append,
			remove as drawing_list_remove,
			execute as old_execute,
			Second as set_stone_action
		export
			{NONE} all;
			{ANY} current_point, set_offset, offset, after,
				draw, empty, off, found, mark, start, 
				offright, line, forth, finish, remove_selected, 
				find, position, set_select_mode, set_find_mode, 
				go, prune_all, drawing_list_append, 
				enable_drawing, disable_drawing, search, wipe_out
		redefine
			has
		select
			line, set_stone_action
		end;
	DRAWING_BOX [STATE_LINE]
		rename
			make as box_make,
			selected_element as selected_line
		export
			{NONE} all;
		redefine
			remove, has, append, select_figure, execute
		select
			remove, append, select_figure, execute
		end;
	TRANS_STONE
		export
			{NONE} all
		redefine
			transportable
		end;
	REMOVABLE
		export
			{NONE} all
		end
	
creation

	make

feature

	make (a_drawing: DRAWING_AREA) is
			-- Create a app_lines with `a_drawing' as drawing_area,
			-- `a_world' as world.
		do
			box_make (a_drawing);
			drawing_area.add_button_press_action (1, Current, select_action);
			drawing_area.add_button_press_action (3, Current, set_stone_action);
			initialize_transport;
		end; 

feature {NONE} -- Removable

	remove_yourself is
		local
			cut_line_command: APP_CUT_LINE;
		do
			!!cut_line_command;
			cut_line_command.execute (original_stone)
		end;

feature {NONE} -- Stone

	transportable: BOOLEAN;

	original_stone: TRANS_STONE;

	label: STRING is
		do
		end;

	symbol: PIXMAP is
		do
		end;

	source: WIDGET is
		do
			Result := drawing_area
		end;
	
feature 

	changed: BOOLEAN;
			-- Has any figure been changed (i,e. selected
			-- or deselected) ?

	append (l: like selected_line) is
			-- Append `l' to `Current'. If `l' already exists (i.e. 
			-- its source and destination are defined by another line) 
			-- set found to true. If found, do not add to the list. Set 
			-- bi_direction of lines if there are lines going in both directions. 
		do
			from
				found := false;
				start
			until
				after or found
			loop
				if
					l.source = line.destination and
					l.destination = line.source
				then
					l.set_bi_directional (True);
					line.set_bi_directional (True);
					line.calculate;
				end;
				if
					l.source = line.source and
					l.destination = line.destination
				then
					found := true
				else
					forth
				end;
			end;
			if
				not found
			then
				drawing_list_append (l);
			end;
		end;


	deselect_selected_line is
		do
			selected_line.deselect;
			selected_line := Void;
			found := false;
		end;

	has (l: like line): BOOLEAN is
			-- Does a line with figures sources and dest as
			-- its connection points ?
		do
			from
				start
			until
				after or else (Result = True)
			loop
				if
					l.source = line.source and
					l.destination = line.destination
				then
					Result := True
				else
					forth
				end;
			end;
		end; 

	remove is
			-- Remove the current line in Current. If line is bi_directional
			-- find the other line and reset flag.
		local
			a_line: STATE_LINE;
			line_found: BOOLEAN;
			pos: INTEGER
		do
			if
				line.bi_directional
			then
				line.set_bi_directional (False);
				a_line := line;
				pos := index; --mark
				from
					start
				until	
					after or line_found
				loop
					if
						a_line.source = line.destination
						and a_line.destination = line.source
					then
						line.set_bi_directional (False);
						line.calculate;
						line_found := true
					else
						forth
					end
				end;
				go_i_th (pos) -- return
			end;
			drawing_list_remove;
		end; 

	select_figure is
			-- Callback routine when a figure is selected.
			-- (By default do nothing). 
		do
		end; -- select_figure

	update (figure: APP_FIGURE) is
			-- Update the points (i.e. recalculate) for the
			-- lines that has `figure' as the source or
			-- destination.
		do
			from
				start
			until
				after
			loop
				if
					line.source = figure or
					(line.destination = figure)
				then
					line.calculate
				end;
				forth
			end;
		end; -- update

feature {NONE} -- Execute

	set_original_stone is
			-- Find line (with mouse pointer) and if found set original_stone
			-- to found line and set transportable to true.
		do
			find;
			if
				found 
			then
				original_stone := line.original_stone;
				transportable := true
			else
				transportable := false
			end;
		end; -- set_original_stone

	execute (argument: ANY) is
		do
			if
				argument = set_stone_action
			then
				set_original_stone
			else
				old_execute (argument);
				if
					argument = select_action
				then
					if
						off
					then
						changed := false
					end
				end
			end;
		end; 

end 


class APP_LINES 

inherit

	EB_DRAWING_BOX [STATE_LINE] 
		rename
			make as box_make, 
			selected_element as selected_line,
			select_figure as old_select,
			element as line, 
			append as drawing_list_append,
			remove as drawing_list_remove,
			Second as set_stone_action
		redefine
			has
		select
			line, set_stone_action
		end;
	EB_DRAWING_BOX [STATE_LINE]
		rename
			make as box_make,
			selected_element as selected_line
		redefine
			remove, has, append, select_figure
		select
			remove, append, select_figure
		end;
	
creation

	make

feature {NONE}

	make (a_drawing: DRAWING_AREA) is
			-- Create a app_lines with `a_drawing' as drawing_area,
			-- `a_world' as world.
		do
			box_make (a_drawing);
		end; 

feature 

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
				if line.source = figure or
					(line.destination = figure)
				then
					line.calculate
				end;
				forth
			end;
		end; -- update

end


class EB_DRAWING_BOX [T -> FIGURE] 

inherit

	COMMAND;
	COMMAND_ARGS
			rename 
				first as select_action
			end
	TWO_WAY_LIST [T]
		rename 
			make as twl_make,
			item as element,
			append as twl_append
		end;

creation

	make

feature -- Creation

	make (a_drawing: DRAWING_AREA) is
			-- Initialize world, drawing_area and mode is select_mode
			-- by default. Set current_drawing_area to 'a_drawing1'.
		require
			not_void_drawing: not (a_drawing = Void);
		do
			twl_make;
			drawing_area := a_drawing;
			set_select_mode
		end;

feature

	enable_drawing is 
			-- Enable the drawing of Current
		do 
			drawing_disabled := False 
		end;

	disable_drawing is 
			-- Disable the drawing of Current
		do 
			drawing_disabled := True
		end;

	found: BOOLEAN;
			-- Was the element found? 

	mode: INTEGER;
			-- Current mode 
	
	find_mode: INTEGER is unique;
			-- Find mode of Current 

	offset: COORD_XY_FIG;
			-- Offset of the top left corner of `drawing_area'

	select_mode: INTEGER is unique;
			-- Select mode of Current

	selected_element: T;
			-- Selected element from `drawing_area'

	point: COORD_XY_FIG;
			-- Point of selection
	
	append (elmt: T) is
			-- Append elmt to `Current'. 
		require
			valid_elmt: elmt /= Void
		do
			finish;
			put_right (elmt);
			if not drawing_area.destroyed then
				elmt.attach_drawing (drawing_area);
			end
		end; -- append

	current_point: POINT is
			-- Current point at mouse cursor position 
		local
			x0, y0: INTEGER
		do
			x0 := drawing_area.screen.x - drawing_area.real_x;
			y0 := drawing_area.screen.y - drawing_area.real_y;
			!!Result.make;
			Result.set (x0, y0);
		end; -- current_point

	attach_to_drawing_area is
			-- Attach figures to `drawing_area'.
		do
			if not drawing_disabled then
				from
					start
				until
					after
				loop
					element.attach_drawing (drawing_area);
					forth
				end;
			end;
		end; -- draw

	draw is
			-- Draw the all elements in Current.
		do
			if not drawing_disabled then
				from
					start
				until
					after
				loop
					element.draw;
					forth
				end;
			end;
		end; -- draw

	remove_selected is
			-- Remove selected_element from Current.
		do
			if selected_element /= Void then
				remove_selected_element;
				selected_element := Void;
				found := false;
			end;
		end;

	set_find_mode is
			-- Finds element in Current.
		do
			mode := find_mode;
		ensure
			mode = find_mode
		end; -- set_find_mode

	set_select_mode is
			-- Finds and selects element in Current.
		do
			mode := select_mode;
		ensure
			mode = select_mode
		end; -- set_select_mode

	find is
			-- Finds element using the mouse position on screen. If located, sets 
			-- found to true and move cursor position to element. Otherwise, 
			-- the cursor position is offleft.
		local
			eltm_found: BOOLEAN
		do
			found := false;
			point := current_point;
			from
				finish	
			until
				before
				or found
			loop
				if element.contains (point) then
					found := true;
				else
					back	
				end;
			end;
		end; -- find

feature {NONE}
	
	drawing_disabled: BOOLEAN;
	
	drawing_area: DRAWING_AREA;
			-- Area where figures are drawn

	select_figure is
			-- Selects element using the mouse position on screen. 
			-- If found, assign selected_element to element. 
			-- Otherwise, the cursor position is offleft. The previous
			--  selected_figure (i.e. the selected_figure before 
			-- this is routine is invoked) is deselected and the 
			-- (new) selected_element is selected. If 
			-- previous selected_figure is equal to the 
			-- selected_figure then do nothing.
		local
			prev_elmt: like selected_element;
		do
			if selected_element /= Void	then	
				prev_elmt := selected_element;
			end;
			find;
			if found then
				selected_element := element;
				if prev_elmt /= selected_element then
					if prev_elmt /= Void then
						prev_elmt.deselect
					end;
					selected_element.select_figure
				end;
			end;
			finish
		end; -- select_figure

	remove_selected_element is
			-- Remove 'selected_element' from Current.
		local
			elmt_found: BOOLEAN
		do
			start;
			search (selected_element);
			if not after then
				remove
			end	
		end; 

feature {NONE}

	execute (argument: ANY) is
			-- Execute the command
		do
			if argument = select_action then
				if not empty then
					if mode = select_mode then
						select_figure
					elseif mode = find_mode then
						find
					else
						-- should never happen
					end;
				else
					found := false
				end;
			end;
		end; -- execute

end -- class EB_DRAWING_BOX

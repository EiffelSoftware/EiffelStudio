indexing
	description: "EiffelBuild drawing manager."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class EB_DRAWING_BOX [T -> EV_FIGURE] 

inherit
	EV_COMMAND

	TWO_WAY_LIST [T]
		rename 
			make as twl_make,
			item as element,
			append as twl_append
		end

creation
	make

feature {NONE} -- Initialization

	make (a_drawing: EV_DRAWING_AREA) is
			-- Initialize world, drawing_area and mode is select_mode
			-- by default. Set current_drawing_area to 'a_drawing1'.
		require
			not_void_drawing: not (a_drawing = Void)
		do
			twl_make
			drawing_area := a_drawing
			set_select_mode
		end

feature -- Access

	drawing_area: EV_DRAWING_AREA
			-- Area where figures are drawn

	found: BOOLEAN
			-- Was the element found? 

	mode: INTEGER
			-- Current mode 

	find_mode: INTEGER is unique
			-- Find mode of Current 

	offset: EV_POINT
			-- Offset of the top left corner of `drawing_area'

	select_mode: INTEGER is unique
			-- Select mode of Current

	selected_element: T
			-- Selected element from `drawing_area'

	point: EV_POINT
			-- Point of selection

	append (elmt: T) is
			-- Append elmt to `Current'. 
		require
			drawing_area_exists: not drawing_area.destroyed
			valid_elmt: elmt /= Void
		do
			finish
			put_right (elmt)
			elmt.attach_drawing (drawing_area)
		end

	draw is
			-- Draw the all elements in Current.
		do
			from
				start
			until
				after
			loop
				element.draw
				forth
			end
		end

	remove_selected is
			-- Remove selected_element from Current.
		do
			if selected_element /= Void then
				remove_selected_element
				selected_element := Void
				found := false
			end
		end

	set_find_mode is
			-- Finds element in Current.
		do
			mode := find_mode
		ensure
			mode = find_mode
		end

	set_select_mode is
			-- Finds and selects element in Current.
		do
			mode := select_mode
		ensure
			mode = select_mode
		end

	find (lx, ly: INTEGER) is
			-- Finds element at position (`lx', `ly'). If located, sets 
			-- found to true and move cursor position to element. Otherwise, 
			-- the cursor position is offleft.
		local
			eltm_found: BOOLEAN
		do
			found := False
			create point.set (lx, ly)
			from
				finish	
			until
				before or found
			loop
				if element.contains (point) then
					found := True
				else
					back	
				end
			end
		end

feature {NONE} -- Implementation

	select_figure (lx, ly: INTEGER) is
			-- Selects element using the mouse position `pt'. 
			-- If found, assign selected_element to element. 
			-- Otherwise, the cursor position is offleft. The previous
			--  selected_figure (i.e. the selected_figure before 
			-- this is routine is invoked) is deselected and the 
			-- (new) selected_element is selected. If 
			-- previous selected_figure is equal to the 
			-- selected_figure then do nothing.
		local
			prev_elmt: like selected_element
		do
			if selected_element /= Void	then
				prev_elmt := selected_element
			end
			find (lx, ly)
			if found then
				selected_element := element
				if prev_elmt /= selected_element then
					if prev_elmt /= Void then
						prev_elmt.deselect
					end
					selected_element.select_figure
				end
			end
			finish
		end

	remove_selected_element is
			-- Remove 'selected_element' from Current.
		local
			elmt_found: BOOLEAN
		do
			start
			search (selected_element)
			if not after then
				remove
			end	
		end 

feature {NONE} -- Command

	execute (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Execute the command
		do
			if not empty then
				if mode = select_mode then
					select_figure (ev_data.x, ev_data.y)
				elseif mode = find_mode then
					find (ev_data.x, ev_data.y)
				end
			else
				found := False
			end
		end

end -- class EB_DRAWING_BOX


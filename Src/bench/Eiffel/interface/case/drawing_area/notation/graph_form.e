indexing

	description: 
		"Factorization of graphical figures characteristics.";
	date: "$Date$";
	revision: "$Revision $"

deferred class GRAPH_FORM 

inherit

	COMPARABLE
		rename
			min as comp_min, max as comp_max
		end

	ONCES
		undefine
			is_equal
		end
	CONSTANTS
		undefine
			is_equal
		end

feature -- Properties

	data: DATA
			-- Data associated with Current graphical figure

	stone: STONE is
			-- Stone associated with Current
		deferred
		end

	order: INTEGER is
			-- Precedence of 'Current' as graphical entity
		deferred
		end -- order

feature -- Graphical specifications

	selected: BOOLEAN
			-- Is this figure selected ?

	workarea: WORKAREA
			-- Workarea on which the figure is displayed

	closure: EC_CLOSURE is 
			-- graphical form's closure.
		deferred
		ensure
			not_void: closure /= Void
		end

	origin: EC_COORD_XY is
			-- Origin the graphical form.
		deferred
		end -- origin

feature -- Setting

	attach_workarea (a_workarea: WORKAREA) is
			-- Attach a workarea to the figure.
		require
			a_workarea_exists: a_workarea /= Void
		deferred
		ensure
			a_workarea = workarea
		end

	set_unselected is
			-- Set selected to False
		do
			selected := False;
		ensure
			not_selected: not selected
		end

	set_color is
			-- Set color for graphical figure.
		deferred
		end

feature -- Access

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'.
		deferred
		end

feature -- Removal

	destroy_without_clip_update is
			-- Destroy the graphical information in the analysis window
			-- but do not update the refresh area.
		deferred
		end -- destroy

feature -- Update

	build is
			-- Put the differents elements according to the current position.
		deferred
		end -- build

	update_without_erase is
			-- Update its shape but do not erase it.
		do
			update_form;
		end 

	update is
			-- Erase the figure, update its shape but do not redraw it.
			-- Also update the clip area to include both the erased
			-- graph figure and the new graph figure to be
			-- drawn for the drawing handler.
		do
			erase
			update_form
			update_clip_area
		end

feature -- Output

	draw_in (clip_closure: EC_CLOSURE) is
			-- Draw the graphical representation in the analysis window
			-- if in clear area `clip'.
		require
			valid_clip: clip_closure /= Void;
		do
			--if clip_closure.intersects (closure) then
			

				draw
			--end;
		end; -- draw

	destroy is
			-- Destroy the graphical representation in the analysis window.
		do
			erase;
			destroy_without_clip_update;
		end; -- destroy

	draw_border is
			-- Draw the border of figure
		deferred
		end

	erase is
			-- Erase the graphical representation from the analysis window.
		do
			update_clip_area
			erase_drawing
		end

	update_clip_area is
			-- Merge Current closure area into the workarea `to_refresh'
			-- clip area.
		do
			workarea.to_refresh.merge (closure)
		ensure
			merged: workarea.to_refresh.includes (closure)
		end

	partial_draw is
		do
			draw
		end;

	select_it is
			-- Set `selected' to true.
			-- Add this figure in `workarea.selected_figures'.
			-- Draw this figure.
		require
			not_selected: not selected
			not_in_selected_list: not workarea.selected_figures.has (Current)	
		do
			selected := true
			workarea.selected_figures.add_form (Current)
			update_clip_area
		ensure then
			selected: selected
			in_selected_list: workarea.selected_figures.has (Current)	
		end

	unselect is
			-- Set `selected' to false.
			-- Remove this figure in `workarea.selected_figures'.
			-- Draw this figure.
		require
			selected: selected
			in_selected_list: workarea.selected_figures.has (Current)	
		do
			erase;
			selected := false;
			workarea.selected_figures.start;
			workarea.selected_figures.prune (Current);
			update_clip_area;
		ensure
			not_selected: not selected
			not_in_selected_list: not workarea.selected_figures.has (Current)	
		end

	invert_skeleton (painter: PATCH_PAINTER; origin_x, origin_y: INTEGER) is
			-- Invert the class's skeleton.
			-- Draw on `painter' as if the origin is at
			-- (`origin_x', `origin_y').
		deferred
		end

feature -- Comparison

	infix "<" (other : like Current): BOOLEAN is
			-- Is 'Current' less than 'other' ?
		do
			Result := order < other.order
		end

feature {NONE} -- Implementation

	draw is
			-- Draw the graphical representation in the analysis window
		deferred
		end; -- draw

	recompute_closure is
			-- Recalculate form's closure.
		deferred
		end -- recompute_closure

	update_form is
			-- Update the content of the graphical form
			-- according to data.
		deferred
		end; -- update_form

	erase_drawing is
			-- Erase Current drawing.
		deferred
		end;

invariant

	valid_data: data /= Void

end -- class GRAPH_FORM

indexing

	description: 
		"It's merely a more or less complicated figure%
		%to draw entities' representations.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EC_FIGURE

inherit

	BASIC_ROUTINES

feature -- Properties

	origin: EC_COORD_XY is
			-- Origin of figure (used by `self_rotate' and `self_scale')
		deferred
		end; -- origin

	drawing: EV_DRAWABLE;
			-- Drawing area in which the figure will be drawn

	path: EC_PATH;
			-- Type of path
			-- Void if the figure's path should'nt be draw.

	closure: EC_CLOSURE
			-- figure's closure

feature -- Setting

	set_path (a_path: like path) is
			-- Set path to 'a_path'.
		do
			path := a_path
		ensure
			path = a_path
		end; -- set_path

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a drawing area to the figure
		do
		--	drawing := a_drawing.implementation
			drawing := a_drawing
		ensure
		--	drawing = a_drawing.implementation
		end; -- attach_drawing

feature -- Access

	contains (p: EC_COORD_XY): BOOLEAN is
			-- Is p in figure?
		require
			points_exists : p /= Void
		deferred
		end; -- contains

	is_surimposable (other: like Current): BOOLEAN is
		do
		end -- is_surimposable

feature -- Output

	draw is
			-- Draw the figure in `drawing'.
		require
			has_drawing: drawing /= void
		deferred
		end; -- draw

	erase is
			-- Erase current figure
		require
			has_drawing: drawing /= void
		deferred
		end; -- erase

feature -- Update

	recompute_closure is
			-- Recalculate figure's closure.
		deferred
		end -- recompute_closure

feature {EC_FIGURE} -- Implementation

	attach_drawing_imp (a_drawing_imp: like drawing) is
			-- Attach a drawing area to the figure
		do
			drawing := a_drawing_imp
		end -- attach_drawing_imp

end -- class EC_FIGURE

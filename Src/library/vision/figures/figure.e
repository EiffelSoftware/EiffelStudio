--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- FIGURE: Figures implementation for X.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class FIGURE

inherit

	BASIC_ROUTINES;

	GEOMETRIC_OP

feature

	attach_drawing (a_drawing: DRAWING) is
			-- Attach a drawing to the figure
		do
			drawing := a_drawing.implementation
		ensure
			drawing = a_drawing.implementation
		end;

feature {WORLD, FIGURE}

	attach_drawing_imp (a_drawing_imp: DRAWING_I) is
			-- Attach a drawing to the figure
		do
			drawing := a_drawing_imp
		end;

feature

	draw is
			-- Draw the figure in `drawing'.
		require
			a_drawing_attached: not (drawing = Void)
		deferred
		end;

	drawing: DRAWING_I;
			-- Drawing in which the figure will be drawn

	deselect is
			-- Do nothing by default
		 do
		 end;

	select_figure is
			-- Do nothing by default
		 do
		 end;

end

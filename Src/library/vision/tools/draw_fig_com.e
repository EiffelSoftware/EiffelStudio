indexing

	description: "Command to refresh a figure or a world";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	DRAW_FIG_COM 

inherit

	COMMAND
		redefine
			context_data_useful
		end

feature -- Status report

	context_data_useful: BOOLEAN is True;
			-- This command need a context data

feature -- Basic operations

	execute (argument: ANY) is
			-- Draw a figure.
		local
			figure: FIGURE;
			world: WORLD;
			expose_data: EXPOSE_DATA;
			drawing: DRAWING;
			drawing_area: DRAWING_AREA;
			draw_b: DRAW_B
		do
			expose_data ?= context_data;
			drawing_area ?= expose_data.widget;
			if (drawing_area = Void) then
				draw_b ?= expose_data.widget;
				drawing := draw_b
			else
				drawing := drawing_area
			end;
			check
				drawing_not_void: drawing /= Void
			end;
			drawing.set_clip (expose_data.clip);
			world ?= argument;
			if (world = Void) then
				figure ?= argument;
				figure.draw
			else
				world.draw
			end;
			drawing.set_no_clip
		end;

end -- DRAW_FIG_COM



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


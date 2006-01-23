indexing

	description: "Command to refresh a figure or a world"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- DRAW_FIG_COM


indexing

	description:
		"Widget: Scrolled window with drawing area.%
		%Special area to draw.%
		%Implementation of this class has changed, however interface is kept.%
		%Explicit access to drawing_area features can be achieved through%
		%working_area attribute.";		

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DRAWING_BOX 

inherit

	SCROLLED_W
		rename
			make as scrolled_w_make,
			make_unmanaged as scrolled_w_make_unmanaged
		end

creation

	make, make_unmanaged

feature {NONE}

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a drawing box with `a_name' as identifier,
			-- `a_parent' as parent.
		local 
			drawing_area: DRAWING_AREA
		do
			scrolled_w_make (a_name, a_parent);
			!!drawing_area.make (a_name, Current);
			!!world.make;
			world.attach_drawing (drawing_area);
			set_working_area (drawing_area);
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged drawing box with `a_name' as identifier,
			-- `a_parent' as parent.
		local 
			drawing_area: DRAWING_AREA
		do
			scrolled_w_make_unmanaged (a_name, a_parent);
			!!drawing_area.make (a_name, Current);
			set_working_area (drawing_area);
			!!world.make;
			world.attach_drawing (drawing_area);
		end;


feature

	world: WORLD;
			-- World for figures

	set_world (a_world: WORLD) is
			-- Set `a_world' to world.
		local
			drawing_area: DRAWING_AREA
		do
			world := a_world;
			drawing_area ?= working_area;
			check 
				drawing_area /= void 
			end
			world.attach_drawing (drawing_area);
		end;

	add_figure (a_figure: FIGURE) is
			-- Add `a_figure' to world.
		do
			world.add (a_figure);
		end;

	remove_figure (a_figure: FIGURE) is
			-- Remove `a_figure' from world.
		do
			world.start;
			world.search (a_figure);
			if not world.after then
				world.remove (a_figure);
			end;
		end;
		
	current_point: COORD_XY_FIG is
			-- Current point on screen
		local
			x0, y0: INTEGER;
		do
			x0 := screen.x - working_area.real_x;
			y0 := screen.y - working_area.real_y;
			!!Result;
			Result.set (x0, y0);
		end;

feature		-- Keeping interface from previous implementation
	
	set_drawing_area_size (new_width: INTEGER; new_height: INTEGER) is
		do
			working_area.set_size (new_width, new_height)
		end

	drawing_area_width: INTEGER is
		do
			Result := working_area.width 
		end
		
	drawing_area_heigth: INTEGER is
		do
			Result := working_area.height
		end
		
	drawing_area_set_foreground_color (new_color: COLOR) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.set_foreground_color (new_color)
		end	
		
	drawing_area_foreground_color: COLOR is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			Result := drawing_area.foreground_color
		end	
			
	drawing_area_set_background_color (new_color: COLOR) is
		do
			working_area.set_background_color (new_color)
		end	

	drawing_area_set_background_pixmap (a_pixmap: PIXMAP) is
		do
			working_area.set_background_pixmap (a_pixmap)
		end	
		
	old_real_x: INTEGER is
		do
			Result := working_area.real_x
		end
	
	old_real_y: INTEGER is
		do
			Result := working_area.real_y
		end

feature		--Interface to drawing area features

	-- from DRAWING_AREA
	add_input_action (a_command: COMMAND; argument: ANY) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.add_input_action (a_command, argument)
		end
	
	add_resize_action (a_command: COMMAND; argument: ANY) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.add_resize_action (a_command, argument)
		end
		
	remove_input_action (a_command: COMMAND; argument: ANY) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.remove_input_action (a_command, argument)
		end
			
	remove_resize_action (a_command: COMMAND; argument: ANY) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.remove_resize_action (a_command, argument)
		end
		
	--from DRAWING		
	add_expose_action (a_command: COMMAND; argument: ANY) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.add_expose_action (a_command, argument)
		end

	remove_expose_action (a_command: COMMAND; argument: ANY) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.remove_expose_action (a_command, argument)
		end		
			
	clear is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.clear
		end	
	
	set_clip (a_clip: CLIP) is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.set_clip (a_clip)
		end	
		
	set_no_clip is
		local
			drawing_area: DRAWING_AREA
		do
			drawing_area ?= working_area
			check 
				drawing_area /= void 
			end
			drawing_area.set_no_clip
		end	

end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

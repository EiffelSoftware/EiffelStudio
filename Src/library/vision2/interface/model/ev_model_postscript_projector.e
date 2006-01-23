indexing
	description:
		"Projection to Postscript files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "projector, events, postscript"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_POSTSCRIPT_PROJECTOR

inherit
	EV_MODEL_PROJECTOR

	EV_MODEL_DRAWER
		redefine
			drawable,
			draw_grid,
			offset_x,
			offset_y
		end

	EV_MODEL_PROJECTION_ROUTINES
	
	EV_POSTSCRIPT_PAGE_CONSTANTS

create
	make_with_filename

feature {NONE} -- Initialization

	make_with_filename (a_world: EV_MODEL_WORLD; a_filename: FILE_NAME) is
			-- Create with `a_world' and `a_filename'.
		require
			a_world_not_void: a_world /= Void
			a_filename_not_void: a_filename /= Void
		do
			create draw_routines.make (0, 20)
			make_with_world (a_world)
			register_basic_figures
			create filename.make
			filename.set_file_name (a_filename)
			create drawable
			drawable.set_margins (default_left_margin, default_bottom_margin)
			drawable.set_page_size (Letter, False)
		end
		
feature -- Access

	offset_x: INTEGER
	
	offset_y: INTEGER
		
feature -- Basic operations

	project is
			-- Make standard projection of world on device.
		local
			bbox: EV_RECTANGLE
			wx, wy: INTEGER
		do
			if not is_projecting then
				is_projecting := True
				drawable.clear
				world.invalidate
				bbox := world.bounding_box
				wx := bbox.left
				wy := bbox.top
				offset_x := -wx
				offset_y := -wy
				drawable.set_size (bbox.right - wx, bbox.bottom - wy)
				-- Full projection.
				if world.grid_visible then
					draw_grid
				end
				if world.is_show_requested then
					project_figure_group_full (world)
				end
				drawable.save_to_named_file (filename)
			end
			is_projecting := False
		end

feature {NONE} -- Implementation

	filename: FILE_NAME

	drawable: EV_POSTSCRIPT_DRAWABLE
			-- Drawable used to draw the figures.
			
	draw_grid is
			-- Draw grid on canvas.
		do
			drawable.add_postscript_line ("%%Drawing PS Grid")
			drawable.add_postscript_line ("gsave")
			drawable.add_postscript_line ("1 setlinewidth")
			drawable.add_postscript_line ("[] 0 setdash")
			drawable.add_postscript_line ("1 1 scale")
			drawable.add_postscript_line (Default_colors.Grey.out + " setrgbcolor")
			drawable.add_postscript_line ("/draw_grid_point")
			drawable.add_postscript_line ("{moveto 1 0 rlineto stroke} def")
			
			drawable.add_postscript_line ("/grid_x_increase")
			drawable.add_postscript_line ("{grid_x_pos " + world.grid_x.out + " add /grid_x_pos exch def} def")
			
			drawable.add_postscript_line ("/grid_y_decrease")
			drawable.add_postscript_line ("{grid_y_pos " + world.grid_y.out + " sub /grid_y_pos exch def} def")
			
			drawable.add_postscript_line ("/draw_grid_line")
			drawable.add_postscript_line ("{/grid_x_pos 0 def")
			drawable.add_postscript_line ("{grid_x_pos " + drawable.width.out + " le {grid_x_pos grid_y_pos draw_grid_point grid_x_increase}{exit} ifelse}loop} def")
			
			drawable.add_postscript_line ("/draw_grid")
			drawable.add_postscript_line ("{/grid_y_pos 0 def")
			drawable.add_postscript_line ("{grid_y_pos " + (-drawable.height).out + " ge {draw_grid_line grid_y_decrease}{exit} ifelse}loop} def")
			
			drawable.add_postscript_line ("draw_grid")
			drawable.add_postscript_line ("grestore")
		end

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




end -- class EV_MODEL_POSTSCRIPT_PROJECTOR


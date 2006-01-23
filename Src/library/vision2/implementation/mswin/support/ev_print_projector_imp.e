indexing
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_PROJECTOR_IMP

inherit
	WEL_PRINTER_DC

	EV_PRINT_PROJECTOR_I

	EV_PROJECTOR

	EV_FIGURE_DRAWER

	EV_PROJECTION_ROUTINES

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create with `a_world' and `a_filename'.
		do
			base_make (an_interface)
			if interface.context.printer_context /= Default_pointer then
				create print_dc.make_by_pointer (interface.context.printer_context)
			else
				-- Create a print dc of the default printer
				-- Set DC with info from context.
				create {WEL_DEFAULT_PRINTER_DC} print_dc.make
			end
			create a_printer.make_with_context (print_dc)
			drawable := a_printer
	
			create draw_routines.make (0, 20)
			make_with_world (interface.world)
			register_basic_figures
		end

	initialize is
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

	destroy is
			-- Destroy `Current'.
		do
			if print_dc /= Void then
				print_dc.unselect_all
				print_dc.dispose
			end
		end

feature -- Access

	project is
			-- Make a standard projection of the world on the device.
		local
			clip_rect: EV_RECTANGLE
			mm_constants: WEL_MM_CONSTANTS
			logical_x, logical_y: INTEGER
		do
			create mm_constants
			if not is_projecting then
				is_projecting := True

				-- Init printer ready for drawing

				a_printer.start_document
				drawable.set_background_color (world.background_color)
				create clip_rect.make (0, 0, drawable.width, drawable.height)

				drawable.clear_rectangle (clip_rect.left, clip_rect.top, clip_rect.right, clip_rect.bottom)
				print_dc.set_map_mode (mm_constants.mm_anisotropic)

				logical_x := print_dc.device_caps (logical_pixels_x)
				logical_y := print_dc.device_caps (logical_pixels_y)
				set_dc_extents (pixels_per_inch, pixels_per_inch, logical_x, logical_y) 
				if world.grid_enabled and world.grid_visible then
					draw_grid
				end
				if world.is_show_requested then
					project_figure_group (world, clip_rect)
				end
				
					-- End drawing and print document.
				a_printer.end_document

				world.validate
			end
			is_projecting := False
		end

feature {NONE} -- Implementation

	pixels_per_inch: INTEGER is 72

	print_dc: WEL_PRINTER_DC

	a_printer: EV_PRINTER
			-- Drawable used for printing.
			
	greatest_common_denometer (value1, value2: INTEGER): INTEGER is
			-- `Result' is greatest common denometer of `value1' and `value2'
		local
			l_value1, l_value2: INTEGER
		do
			l_value1 := value1
			l_value2 := value2
			from
			until
				l_value1 = l_value2
			loop
				if l_value1 > l_value2 then
					l_value1 := l_value1 - l_value2
				else
					l_value2 := l_value2 - l_value1
				end
			end
			Result := l_value1
		end
	
	set_dc_extents (wx, wy, vx, vy: INTEGER) is
			-- Set extents of `print_dc' to correctly print `wx', `wy' pixels per inch,
			-- on a printer with resolution `vx', `vy'.
		require
			values_positive: wx > 0 and wy > 0 and vx > 0 and vy > 0
		local
			gx, gy: INTEGER
		do
			gx := greatest_common_denometer (wx.abs, vx.abs)
			gy := greatest_common_denometer (wy.abs, vy.abs)
			print_dc.set_window_extent ((wx/gx).rounded, (wy/gy).rounded)
			print_dc.set_viewport_extent ((vx/gx).rounded, (vy/gy).rounded)
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




end -- class EV_PRINT_PROJECTOR


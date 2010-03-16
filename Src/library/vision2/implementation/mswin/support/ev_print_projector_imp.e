note
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
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_world: EV_FIGURE_WORLD; a_context: EV_PRINT_CONTEXT)
		do
			if a_context.printer_context /= Default_pointer then
				create dc.make_by_pointer (a_context.printer_context)
			else
				-- Create a print dc of the default printer
				-- Set DC with info from context.
				create {WEL_DEFAULT_PRINTER_DC} dc.make
			end
			create a_printer.make_with_context (dc)
			drawable := a_printer
			make_with_world (a_world)
			make
		end

	old_make (an_interface: like interface)
			-- Create with `a_world' and `a_filename'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create draw_routines.make (0, 20)
			register_basic_figures
			set_is_initialized (True)
		end

	destroy
			-- Destroy `Current'.
		do
			dc.unselect_all
			dc.dispose
		end

feature -- Access

	project
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
				dc.set_map_mode (mm_constants.mm_anisotropic)

				logical_x := dc.device_caps (logical_pixels_x)
				logical_y := dc.device_caps (logical_pixels_y)
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

	pixels_per_inch: INTEGER = 72

	dc: WEL_PRINTER_DC

	a_printer: EV_PRINTER
			-- Drawable used for printing.

	greatest_common_denometer (value1, value2: INTEGER): INTEGER
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

	set_dc_extents (wx, wy, vx, vy: INTEGER)
			-- Set extents of `dc' to correctly print `wx', `wy' pixels per inch,
			-- on a printer with resolution `vx', `vy'.
		require
			values_positive: wx > 0 and wy > 0 and vx > 0 and vy > 0
		local
			gx, gy: INTEGER
		do
			gx := greatest_common_denometer (wx.abs, vx.abs)
			gy := greatest_common_denometer (wy.abs, vy.abs)
			dc.set_window_extent ((wx/gx).rounded, (wy/gy).rounded)
			dc.set_viewport_extent ((vx/gx).rounded, (vy/gy).rounded)
		end

note
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






indexing
	description:
		"Projection to a Printer."
	status: "See notice at end of class"
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
				--create print_dc.make
				-- Create a print dc of the default printer
				-- Set DC with info from context.
			end
			create a_printer.make_with_context (print_dc)
			drawable := a_printer
	
			create draw_routines.make (0, 20)
			make_with_world (interface.world)		register_basic_figures
		end

	initialize is
		do
			is_initialized := True
		end

	destroy is
		do
		end

feature -- Access

	project is
			-- Make a standard projection of the world on the device.
		local
			clip_rect: EV_RECTANGLE
			mm_constants: WEL_MM_CONSTANTS
			hor_size: INTEGER
		do
			create mm_constants
			if not is_projecting then
				is_projecting := True

				-- Init printer ready for drawing

				a_printer.start_document
				drawable.set_background_color (world.background_color)
				create clip_rect.make (0, 0, drawable.width, drawable.height)

				drawable.clear_rectangle (clip_rect.left, clip_rect.top, clip_rect.right, clip_rect.bottom)
				print_dc.set_map_mode (mm_constants.Mm_isotropic)

				hor_size := ((print_dc.device_caps (horizontal_size) / 25) * print_dc.device_caps (logical_pixels_x)).rounded
				print_dc.set_viewport_extent (hor_size * 5, hor_size * 5)
		
				if world.grid_enabled and world.grid_visible then
					draw_grid
				end
				if world.is_show_requested then
					project_figure_group (world, clip_rect)
				end
				--if world.points_visible then
				--	project_rel_point (world.point)
				--end

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

end -- class EV_PRINT_PROJECTOR

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


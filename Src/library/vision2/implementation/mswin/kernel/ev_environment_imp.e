indexing
	description:
		"Eiffel Vision Environment. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_I
	
	WEL_SYSTEM_PARAMETERS_INFO
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Initialize `Current' with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- No extra initialization needed.
		do
			is_initialized := True
		end
		
feature {NONE} -- Implementation

	supported_image_formats: LINEAR [STRING] is
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, XPM, ICO
		local
			res: ARRAYED_LIST [STRING]
		do
			create res.make (3)
			res.extend ("BMP")
			res.extend ("PNG")
			res.extend ("ICO")
			res.compare_objects
			Result := res
		end
		
	fonts: LINEAR [EV_FONT] is
			-- All fonts available on current platform.
		local
			res: ARRAYED_LIST [EV_FONT]
			a_font: EV_FONT
			font_imp: EV_FONT_IMP
			all_fonts: ARRAYED_LIST [STRING]
			wel_font: WEL_FONT
		do
			create res.make (20)
			all_fonts ?= font_enumerator.font_faces
			from
				all_fonts.start
			until
				all_fonts.off
			loop
				create a_font
				a_font.preferred_families.extend (all_fonts.item)
				res.extend (a_font)
				all_fonts.forth
			end
			Result ?= res
		end	
		
	mouse_wheel_scroll_lines: INTEGER is
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		do
			Result := get_wheel_scroll_lines
		end
		
	has_printer: BOOLEAN is
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		local
			default_printer: WEL_DEFAULT_PRINTER_DC
		do
			create default_printer.make
			Result := default_printer.exists
		end
		
	Font_enumerator: EV_WEL_FONT_ENUMERATOR_IMP is
			-- Enumerate Installed fonts
		once
			create Result
		end

end -- class EV_ENVIRONMENT_IMP

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


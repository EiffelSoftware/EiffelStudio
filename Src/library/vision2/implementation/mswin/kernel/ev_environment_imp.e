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
			set_is_initialized (True)
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
		
	font_families: LINEAR [STRING] is
			-- All font families available on current platform.
		local
			res: ARRAYED_LIST [STRING]
			all_fonts: ARRAYED_LIST [STRING]
		do
			create res.make (20)
			all_fonts ?= font_enumerator.font_faces
			from
				all_fonts.start
			until
				all_fonts.off
			loop
				res.extend (all_fonts.item)
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


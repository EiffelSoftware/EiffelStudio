indexing
	description:
		"Eiffel Vision Environment. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	supported_image_formats: LINEAR [STRING_32] is
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, XPM, ICO
		local
			res: ARRAYED_LIST [STRING_32]
		do
			create res.make (3)
			res.extend ("BMP")
			res.extend ("PNG")
			res.extend ("ICO")
			res.compare_objects
			Result := res
		end

	font_families: LINEAR [STRING_32] is
			-- All font families available on current platform.
		local
			res: ARRAYED_LIST [STRING_32]
			all_fonts: ARRAYED_LIST [STRING_32]
		do
			create res.make (20)
			all_fonts := font_enumerator.font_faces
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




end -- class EV_ENVIRONMENT_IMP


indexing
	description:
		"Eiffel Vision Environment. GTK implementation."
	status: "See notice at end of class"
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_I

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Pass `an_interface' to base make.
		do
			base_make (an_interface)
		end

	initialize is
			-- No initialization needed.
		do
			is_initialized := True
		end
		
feature -- Access
		
	supported_image_formats: LINEAR [STRING] is
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, ICO
		do
			Result := (<<"PNG">>).linear_representation
			Result.compare_objects
		end

	mouse_wheel_scroll_lines: INTEGER is
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		do
			Result := 3
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


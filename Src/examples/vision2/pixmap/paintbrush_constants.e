indexing
	description	: "Constants used in the PAINTBRUSH application"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PAINTBRUSH_CONSTANTS

feature -- Access

	Interface_names: PAINTBRUSH_INTERFACE_NAMES is
			-- String constants used in the application
		once
			create Result
		end
		
	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Constant for default size for padding, border, buttons.
		once
			create Result
		end
		
	Drawable_constants: EV_DRAWABLE_CONSTANTS is
			-- Drawable constants
		once
			create Result
		end

	Font_constants: EV_FONT_CONSTANTS is
			-- Font constants
		once
			create Result
		end
		
end -- class PAINTBRUSH_CONSTANTS

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


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

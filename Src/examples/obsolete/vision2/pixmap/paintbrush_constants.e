indexing
	description	: "Constants used in the PAINTBRUSH application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end -- class PAINTBRUSH_CONSTANTS


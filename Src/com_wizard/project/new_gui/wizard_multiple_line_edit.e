indexing
	description: "Multiple line edit with erase background message disabled"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MULTIPLE_LINE_EDIT

inherit
	WEL_MULTIPLE_LINE_EDIT
		redefine
			on_erase_background
		end

create
	make

feature {NONE} -- Implementation

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Disable erase background message
		do
		end
		
end -- class WIZARD_MULTIPLE_LINE_EDIT

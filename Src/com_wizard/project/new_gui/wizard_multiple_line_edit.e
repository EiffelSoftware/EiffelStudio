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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------


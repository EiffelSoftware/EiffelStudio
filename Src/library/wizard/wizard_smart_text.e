indexing
	description: "Text we can display on the wizard."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SMART_TEXT

inherit
	EV_VERTICAL_BOX
		
creation
	make

feature -- Initialization

	make(par: EV_BOX) is
			-- Initialize with box parent 'par'.
		do
			default_create
			par.extend(Current)
			par.disable_item_expand(Current)
		end

feature -- basic Operations 

	add_line(s: STRING) is
			-- Add a line to the text.
		require
			possible: s /= Void
		do
			extend(Create {EV_LABEL}.make_with_text(s))
		end

end -- class WIZARD_SMART_TEXT


--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
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


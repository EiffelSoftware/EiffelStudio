indexing
	description: "Controls used to modify objects of type EV_SELECTABLE"
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTABLE_CONTROL

inherit
	EV_FRAME

create
	make
	
feature {NONE} -- Initialization

	make (box: EV_BOX; selectable: EV_SELECTABLE; output: EV_TEXT) is
			-- Create controls to manipulate `selectable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_SELECTABLE")	
			create button.make_with_text ("Enable_select")
			extend (button)
			button.select_actions.extend (agent selectable.enable_select)
			button.select_actions.extend (agent button.disable_sensitive)
			box.extend (Current)
		end
	
feature {NONE} -- Implementation

		-- Widget used to create controls.
	button: EV_BUTTON

end -- class SELECTABLE_CONTROL

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


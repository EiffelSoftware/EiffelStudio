indexing
	description: "Controls used to modify objects of type EV_TEXT_ALIGNABLE"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_ALIGNABLE_CONTROL

inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; text_alignable: EV_TEXT_ALIGNABLE; output: EV_TEXT) is
			-- Create controls to manipulate `text_alignable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_TEXT_ALIGNABLE")
			create vertical_box
			extend (vertical_box)
			create button.make_with_text ("Align text left")
			button.select_actions.extend (agent text_alignable.align_text_left)
			vertical_box.extend (button)
			create button.make_with_text ("Align text center")
			button.select_actions.extend (agent text_alignable.align_text_center)
			vertical_box.extend (button)
			create button.make_with_text ("Align text right")
			button.select_actions.extend (agent text_alignable.align_text_right)
			vertical_box.extend (button)
			box.extend (Current)
		end

feature {NONE} -- Implementation

		-- Widgets used to build controls.
	vertical_box: EV_VERTICAL_BOX
	button: EV_BUTTON

end -- class TEXTABLE_CONTROL

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

indexing
	description: "Controls used to modify objects of type EV_TEXTABLE"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXTABLE_CONTROL

inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; textable: EV_TEXTABLE; output: EV_TEXT) is
			-- Create controls to manipulate `textable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_TEXTABLE")
			create vertical_box
			extend (vertical_box)
			create text_field.make_with_text ("Default_text")
			vertical_box.extend (text_field)
			textable.set_text ("Default_text")
			text_field.change_actions.extend (agent textable_set_text (textable))
			box.extend (Current)
		end

feature {NONE} -- Implementation

	textable_set_text (a_textable: EV_TEXTABLE) is
			-- Assign text of `textable_text_field' to `a_textable'.
		do
			if text_field.text = Void then
				a_textable.remove_text
			else
				a_textable.set_text (text_field.text)
			end
		end

		-- Widgets used to build controls.
	vertical_box: EV_VERTICAL_BOX
	text_field: EV_TEXT_FIELD

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


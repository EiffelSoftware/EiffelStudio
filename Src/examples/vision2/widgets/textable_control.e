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
			create button.make_with_text ("Align text left")
			button.select_actions.extend (agent textable.align_text_left)
			vertical_box.extend (button)
			create button.make_with_text ("Align text center")
			button.select_actions.extend (agent textable.align_text_center)
			vertical_box.extend (button)
			create button.make_with_text ("Align text right")
			button.select_actions.extend (agent textable.align_text_right)
			vertical_box.extend (button)
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
	button: EV_BUTTON

end -- class TEXTABLE_CONTROL

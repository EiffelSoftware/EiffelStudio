note
	description: "Controls used to modify objects of type EV_TEXTABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXTABLE_CONTROL

inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; textable: EV_TEXTABLE; output: EV_TEXT)
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

	textable_set_text (a_textable: EV_TEXTABLE)
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
	text_field: EV_TEXT_FIELD;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEXTABLE_CONTROL


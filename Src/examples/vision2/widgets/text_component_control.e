indexing
	description: "Controls used to modify objects of type EV_TEX_COMPONENT"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_COMPONENT_CONTROL

inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; a_text_component: EV_TEXT_COMPONENT; output: EV_TEXT;) is
			-- Create controls to manipulate `a_text_component', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			text_component := a_text_component
			set_text ("EV_TEXT_COMPONENT")
			create vertical_box
			extend (vertical_box)
			create text_field.make_with_text ("Default_text")
			text_component.set_text ("Default_text")
			vertical_box.extend (text_field)
			text_field.change_actions.extend (agent text_component_set_text)
			create horizontal_box
			create button.make_with_text ("Append")
			horizontal_box.extend (button)
			create append_text_field.make_with_text ("A")
			horizontal_box.extend (append_text_field)
			vertical_box.extend (horizontal_box)
			button.select_actions.extend (agent append_text)
			append_text_field.return_actions.extend (agent append_text)
			
			create horizontal_box
			create button.make_with_text ("Prepend")
			horizontal_box.extend (button)
			create prepend_text_field.make_with_text ("P")
			horizontal_box.extend (prepend_text_field)
			vertical_box.extend (horizontal_box)
			button.select_actions.extend (agent prepend_text)
			prepend_text_field.return_actions.extend (agent prepend_text)
			box.extend (Current)
		end
		
	append_text is
			-- Append text of `append_text_field' to `text_component'.
		do
			if append_text_field.text /= Void then
				text_component.append_text (append_text_field.text)
			end
		end
		
 	prepend_text is
			-- Prepend text of `prepend_text_field' to `text_component'.
		do
			if prepend_text_field.text /= Void then
				text_component.prepend_text (prepend_text_field.text)	
			end
		end

	text_component_set_text is
			-- Assign text of `text_field' to `text_component'.
		do
			if text_field.text = Void then
				text_component.remove_text
			else
				text_component.set_text (text_field.text)
			end
		end

feature {NONE} -- Implementation

		-- widgets used to build controls.
	button: EV_BUTTON
	vertical_box: EV_VERTICAL_BOX
	horizontal_box: EV_HORIZONTAL_BOX
	text_field, append_text_field, prepend_text_field: EV_TEXT_FIELD
	text_component: EV_TEXT_COMPONENT

end -- class TEXT_COMPONENT_CONTROL

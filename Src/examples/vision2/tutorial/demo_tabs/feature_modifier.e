indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_MODIFIER

inherit
	
	EV_TABLE
		rename
			make as old_make
		end

creation

	make

feature -- Initialization

	make (par: EV_CONTAINER; title: STRING; cmd1: EV_COMMAND; cmd2: EV_COMMAND) is
			-- Create the features.
		do
			old_make (par)
			create label.make_with_text(Current,title)
			set_child_position(label,0,0,1,1)
			create text_field.make(Current)
			set_child_position(text_field,0,1,1,2)
			create button.make_with_text(Current,"Fetch Value")
			set_child_position(button,0,2,1,3)
			if cmd1/=Void then
				text_field.add_activate_command(cmd1, Void)
			else
				disable_text
			end
			button.add_click_command(cmd2, Void)
			button.set_vertical_resize (False)
			label.set_vertical_resize (False)
			label.set_horizontal_resize (False)
		end

feature -- Values

	disable_text is
			-- Disables the text field box
		do
			text_field.set_insensitive(True)
		end

	enable_text is
			-- Enables the text field box
		do
			text_field.set_insensitive(False)
		end

	get_text: string is
			-- Returns the text item of the feature
		do
			Result:=text_field.text	
		end

	set_text(new_text: string) is
			-- Sets the text item of the feature
		do
			text_field.set_text(new_text)
		end

feature -- Access

	text_field: EV_TEXT_FIELD
	button: EV_BUTTON
	label: EV_LABEL

end -- class FEATURE_MODIFIER

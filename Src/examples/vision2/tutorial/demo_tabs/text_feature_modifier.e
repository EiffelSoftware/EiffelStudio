indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FEATURE_MODIFIER

inherit
	FEATURE_MODIFIER

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER; title: STRING; cmd1: EV_COMMAND; cmd2: EV_COMMAND) is
			-- Create the label and the text.
		require
			valid_command: cmd2 /= Void
			valid_title: title /= Void
		do
			initialize (par, title, cmd2)
			create text_field.make (Current)
			set_child_position (text_field, 0, 1, 1, 2)
			if cmd1 /= Void then
				text_field.add_activate_command (cmd1, Void)
			else
				disable_text
			end
		end

feature -- Access

	text_field: EV_TEXT_FIELD
			-- Text field of the modifier.

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
			Result := text_field.text	
		end

	set_text(new_text: string) is
			-- Sets the text item of the feature
		do
			text_field.set_text(new_text)
		end

end -- class TEXT_FEATURE_MODIFIER

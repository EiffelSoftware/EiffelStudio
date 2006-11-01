indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FEATURE_MODIFIER

inherit
	FEATURE_MODIFIER

create
	make

feature -- Initialization

	make (par: EV_TABLE; top, left: INTEGER; title: STRING; cmd1: EV_COMMAND; cmd2: EV_COMMAND) is
			-- Create the label and the text.
		require
			valid_title: title /= Void
		do
			initialize (par, top, left, title, cmd2)
			create text_field.make (par)
			par.set_child_position (text_field, top, left + 1, top + 1, left + 2)
			if cmd1 /= Void then
				text_field.add_return_command (cmd1, Void)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEXT_FEATURE_MODIFIER


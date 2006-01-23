indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEATURE_MODIFIER

feature -- Initialization

	initialize (par: EV_TABLE; top, left: INTEGER; title: STRING; cmd: EV_COMMAND) is
			-- Create the label and the text.
		require
			valid_title: title /= Void
		do
			create_label (par, top, left, title)
			create_button (par, top, left + 2, cmd)
		end

feature -- Access

	button: EV_BUTTON
			-- Fetch value button

feature -- Status setting

	disable_button is
			-- Disable the button
		do
			button.set_insensitive (True)
		end

feature {NONE} -- Basic operation

	create_button (par: EV_TABLE; top, left: INTEGER; cmd: EV_COMMAND) is
			-- Create the button.
		do
			create button.make_with_text (par, "Fetch Value")
			par.set_child_position (button, top, left, top + 1, left + 1)
			if cmd /= Void then
				button.add_click_command (cmd, Void)
			else
				button.set_insensitive (True)
			end
			button.set_vertical_resize (False)
		end

	create_label (par: EV_TABLE; top, left: INTEGER; title: STRING) is
			-- Create the label.
		local
			label: EV_LABEL
		do
			create label.make_with_text (par, title)
			par.set_child_position (label, top, left, top + 1, left + 1)
			label.set_vertical_resize (False)
			label.set_horizontal_resize (False)
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


end -- class FEATURE_MODIFIER


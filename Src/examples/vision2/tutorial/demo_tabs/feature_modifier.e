indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEATURE_MODIFIER

inherit
	EV_TABLE
		rename
			make as old_make
		end

feature -- Initialization

	initialize (par: EV_CONTAINER; title: STRING; cmd: EV_COMMAND) is
			-- Create the label and the text.
		require
			valid_command: cmd /= Void
			valid_title: title /= Void
		do
			old_make (par)
			set_column_spacing (5)
			create_label (title)
			create_button (cmd)
		end

feature -- Access

	button: EV_BUTTON
			-- Fetch value button

feature {NONE} -- Basic operation

	create_button (cmd: EV_COMMAND) is
			-- Create the button.
		do
			create button.make_with_text (Current, "Fetch Value")
			button.add_click_command (cmd, Void)
			button.set_vertical_resize (False)
			set_child_position (button, 0, 2, 1, 3)
		end

	create_label (title: STRING) is
			-- Create the label.
		local
			label: EV_LABEL
		do
			-- We create the first label
			create label.make_with_text (Current, title)
			label.set_vertical_resize (False)
			label.set_horizontal_resize (False)
			set_child_position (label, 0, 0, 1, 1)
		end

end -- class FEATURE_MODIFIER

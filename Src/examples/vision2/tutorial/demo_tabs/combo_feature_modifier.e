indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMBO_FEATURE_MODIFIER

inherit
	FEATURE_MODIFIER

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER; title: STRING; cmd1: EV_COMMAND; cmd2: EV_COMMAND) is
			-- Create combo_box between the label and the button.
		require
			valid_commands: cmd1 /= Void and cmd2 /= Void
			valid_title: title /= Void
		do
			initialize (par, title, cmd2)
			create combo.make (Current)
			combo.set_editable (False)
			set_child_position (combo, 0, 1, 1, 2)
			combo.add_selection_command (cmd1, Void)
		end

feature -- Access

	combo: EV_COMBO_BOX
			-- The combo_box used in the modifier

feature -- Values


end -- class COMBO_FEATURE_MODIFIER

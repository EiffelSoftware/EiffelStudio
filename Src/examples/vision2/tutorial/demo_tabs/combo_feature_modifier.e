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

	make (par: EV_TABLE; top, left: INTEGER; title: STRING; cmd1: EV_COMMAND; cmd2: EV_COMMAND) is
			-- Create combo_box betwwen the label and the button.
		require
			valid_title: title /= Void
		do
			initialize (par, top, left, title, cmd2)
			create combo.make (par)
			par.set_child_position (combo, top, left + 1, top + 1, left + 2)
			combo.set_editable (False)
			if cmd1 /= Void then
				combo.add_selection_command (cmd1, Void)
			end
		end

feature -- Access

	combo: EV_COMBO_BOX
			-- The combo_box used in the modifier

feature -- Element change

	add_item (txt: STRING; cmd: EV_INTERNAL_COMMAND) is
			-- Add an item and set the command on it.
		local
			item: EV_LIST_ITEM
		do
			create item.make_with_text (combo, txt)
			if cmd /= Void then
				item.add_select_command (cmd.command, cmd.argument)
			end
		end

end -- class COMBO_FEATURE_MODIFIER

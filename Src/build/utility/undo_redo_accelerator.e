indexing
	description: "Element of the GUI that can call the %
				% accelerators Ctrl-Z and Ctrl-R."
	id: "$Id: "
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REDO_ACCELERATOR

feature {NONE} -- Implementation

	add_undo_redo_accelerator (arg: WIDGET) is
			-- Add accelerators on `arg'.
		local
			undo_cmd: UNDO_ACCELERATOR_CMD
			redo_cmd: REDO_ACCELERATOR_CMD
		do
			!! undo_cmd
			!! redo_cmd
			arg.set_action ("Ctrl<Key>z", undo_cmd, Void)
			arg.set_action ("Ctrl<Key>r", redo_cmd, Void)
		end


end -- class UNDO_REDO_ACCELERATOR

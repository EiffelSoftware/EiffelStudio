indexing
	description: "Pick and drop accelerator."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PND_ACCELERATOR

inherit
	EV_COMMAND

	WINDOWS

	ERROR_POPUPER

feature -- Command

	execute (arg: EV_ARGUMENT1 [ANY]; ev_data: EV_BUTTON_EVENT_DATA) is
		local
			nm: NAMABLE
			ed: EDITABLE
		do
			if ev_data.shift_key_pressed then
					-- Rename command
				nm ?= arg.first
				if nm /= Void then
					change_name (nm)
				else
					error_dialog.popup (Current,
										Messages.cannot_rename_er, Void)
				end
			elseif ev_data.control_key_pressed then
					-- Create editor command
				ed ?= arg.first
				if ed /= Void then
					ed.create_editor
				end
			end
		end

end -- class PND_ACCELERATOR


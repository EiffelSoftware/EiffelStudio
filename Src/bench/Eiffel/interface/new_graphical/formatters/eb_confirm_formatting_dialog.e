indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONFIRM_FORMATTING_DIALOG

inherit
	EV_DIALOG
	EV_COMMAND
	INTERFACE_NAMES

creation
	make_default

feature {NONE} -- Initialization

	make_default (a_caller: like caller) is
		local
			i: EV_BUTTON
		do
			caller := a_caller
			make (caller.associated_window)
			set_title (t_Confirm)
			create label.make_with_text (display_area, 
				"This format requires exploring the entire%N%
				%system and may take a long time...")
			create i.make_with_text (action_area, " Continue ")
			i.add_click_command (Current, Process_it)
			create i.make_with_text (action_area, b_Cancel)
			i.add_click_command (Current, Void)
			set_modal (True)
			show
		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
			destroy
			caller.process
		end

feature {NONE} -- Implementation

	Process_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	label: EV_LABEL

	caller: EB_LONG_FORMAT_COMMAND

end -- class EB_CONFIRM_FORMATTING_DIALOG

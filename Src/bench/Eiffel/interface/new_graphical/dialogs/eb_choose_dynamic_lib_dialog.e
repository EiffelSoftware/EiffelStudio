indexing
	description: "Dialog to choose or build a dynamic library file"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOOSE_DYNAMIC_LIB_DIALOG

inherit
	EV_DIALOG
	EV_COMMAND
	INTERFACE_NAMES

creation
	make_default

feature {NONE} -- Initialization

	make_default (a_caller: like caller; t: STRING; msg: STRING) is
		local
			i: EV_BUTTON
		do
			caller := a_caller
			make (caller.associated_window)
			set_title (t)
			create label.make_with_text (display_area, msg)
			create i.make_with_text (action_area, b_Browse)
			i.add_click_command (Current, Browse_it)
			create i.make_with_text (action_area, "Default")
			i.add_click_command (Current, Build_it)
			create i.make_with_text (action_area, b_Cancel)
			i.add_click_command (Current, Void)
			set_modal (True)
			show
		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
			destroy
			if arg = Browse_it then
				caller.load_chosen
			elseif arg = Build_it then
				caller.load_default
			end
		end

feature {NONE} -- Implementation

	Browse_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	Build_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	label: EV_LABEL

	caller: EB_SHOW_DYNAMIC_LIB_TOOL

end -- class EB_CHOOSE_DYNAMIC_LIB_DIALOG

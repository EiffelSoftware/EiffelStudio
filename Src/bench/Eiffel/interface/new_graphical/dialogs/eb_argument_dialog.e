indexing
	description:	
		"Window to enter arguments."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_DIALOG

inherit

	EV_COMMAND
	EV_DIALOG
	EB_SHARED_INTERFACE_TOOLS
	NEW_EB_CONSTANTS
--	WINDOW_ATTRIBUTES

creation
	make_default
	
feature -- Initialization

	make_default (par: EV_WINDOW; cmd: EV_COMMAND) is
			-- Initialize Current with `par' as parent and
			-- `cmd' as command window.
			--| Use this in conjunction with `make_plain' to
			--| create a shared argument window.
		local
			b: EV_BUTTON
			f: EV_FRAME
		do
			make (par)
			set_title (Interface_names.t_Argument_w)
			create f.make_with_text (display_area, Interface_names.l_Specify_arguments)
			create selection_label.make_with_text (f, Argument_list)

			create b.make_with_text (action_area, Interface_names.b_Run)
			b.add_click_command (Current, apply_and_run_it)
			create b.make_with_text (action_area, Interface_names.b_Apply)
			b.add_click_command (Current, apply_it)
			create b.make_with_text (action_area, Interface_names.b_Cancel)
			b.add_click_command (Current, Void)
			run := cmd
--			set_composite_attributes (Current)
			show
		end

feature -- Properties

--	argument_list: STRING is
--		once
--			create Result.make (0)
--		end

	-- moved in EB_SHARED_INTERFACE_TOOLS

feature {NONE} -- Properties

	selection_label: EV_TEXT_FIELD

	apply_it, apply_and_run_it: EV_ARGUMENT1 [ANY] is
			-- Arguments for the command
		once
			create Result.make (Void)
		end

	run: EV_COMMAND

feature {NONE} -- Implementation

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		local
			arg_list: STRING
		do
			hide
			if arg /= Void then
					-- User selected "Run" or "Apply"
				arg_list := Argument_list
				arg_list.wipe_out
				arg_list.append (clone (selection_text))
					-- trick for changing `Argument_list'
				if argument = Apply_and_run_it then
					run.execute (Void, data)
				end
			end
		end

end -- class EB_ARGUMENT_DIALOG

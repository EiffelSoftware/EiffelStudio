indexing
	description: "Hole which can receive command stones. %
				% Output of behavior function."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class
	COMMAND_HOLE

inherit
	ELMT_HOLE
		redefine
			make_with_editor,
			symbol
		end

	EV_COMMAND

creation
	make_with_editor

feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; func: BEHAVIOR_EDITOR) is
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [BEHAVIOR_EDITOR]
		do
			Precursor (par, func)
			create cmd.make (func~update_output_hole)
			add_pnd_command (Pnd_types.command_type, cmd, Void)

--			create instances_list_wnd.make_with_hole (par, Current)
			create arg.make (func)
			add_button_press_command (3, Current, arg)
		end

feature {NONE} -- Implementation

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end

--	associated_label: STRING is
--		do
--			Result := Widget_names.command_label
--		end

--	instances_list_wnd: CMD_INSTANCE_CHOICE_WND

	execute (arg: EV_ARGUMENT1 [BEHAVIOR_EDITOR]; ev_data: EV_EVENT_DATA) is
			-- Display a list of possible command instances.
		local
			ctxt: CONTEXT
		do
			ctxt := arg.first.edited_context
--			instances_list_wnd.popup_with_list (ctxt.default_commands_list)
		end

end -- class COMMAND_HOLE


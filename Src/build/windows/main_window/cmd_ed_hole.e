indexing
	description: "Button used to raise a command tool %
				% targeted on the command corresponding %
				% to the dropped stone."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	
	CMD_ED_HOLE

inherit
	EDIT_BUTTON
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EDIT_BUTTON} Precursor (par)
			create cmd.make (~create_editor)
			add_pnd_command (Pnd_types.command_type, cmd, Void)
			add_pnd_command (Pnd_types.instance_type, cmd, Void)
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end

feature {CMD_ED_HOLE} -- Pick and Drop

	create_editor (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
--			cmd: CMD
--			cmd_inst: CMD_INSTANCE
		do
--			cmd ?= ev_data.data
--			if cmd /= Void then
--				cmd.create_editor
--			else
--				cmd_inst ?= ev_data.data
--				cmd_inst.create_editor
--			end
		end

--	create_focus_label is 
--		do
--			set_focus_string (Focus_labels.command_type_label)
--		end

	create_empty_editor is
		do
			window_mgr.display (window_mgr.command_tool)	
		end
 
end -- class CMD_ED_HOLE


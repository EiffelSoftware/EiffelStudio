indexing
	description: "Hole in the top left corner of a command %
				% tool used to retarget the tool."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_TOOL_HOLE

inherit
	EDIT_BUTTON
		redefine
			data,
			execute
		end

creation
	make

feature -- Access

	associated_command: CMD is
		do
			if data /= Void and then not data.empty then
				Result := data.command_instance.associated_command
			end
		end

	associated_instance: CMD_INSTANCE is 
		do
			if data /= Void and then not data.empty then
				Result := data.command_instance
			end
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end

	full_symbol: EV_PIXMAP is
		do
			Result := Pixmaps.command_dot_pixmap
		end

feature -- Status setting

	set_callbacks is
		local
			arg: EV_ARGUMENT1 [ANY]
			cmd: EV_ROUTINE_COMMAND
		do
			create arg.make (associated_instance)
			add_button_press_command (3, create {PND_ACCELERATOR}, arg)
			activate_pick_and_drop (Void, Void)
			set_data_type (Pnd_types.instance_type)

			create cmd.make (~process_command)
			add_pnd_command (Pnd_types.command_type, cmd, Void)
			create cmd.make (~process_instance)
			add_pnd_command (Pnd_types.instance_type, cmd, Void)
		end

	set_empty_symbol is
		do
			set_transported_data (Void)
			if pixmap /= symbol then
				set_pixmap (symbol)
			end
		end

	set_full_symbol is
		do
			set_transported_data (associated_instance)
			if pixmap /= full_symbol then
				set_pixmap (full_symbol)
			end
		end

feature -- Basic operations

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.command_label)
--		end

	create_empty_editor is
		do
			window_mgr.display (window_mgr.command_tool)	
		end

feature {COMMAND_TOOL_HOLE} -- Hole features

	process_command (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Retarget the associted command tool creating
			-- a new instance of `dropped.data'.
		local
			cmd: CMD
		do
			cmd ?= ev_data.data
			data.set_command (cmd)
		end

	process_instance (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Retarget the associated command tool .
		local
			inst: CMD_INSTANCE
		do
			inst ?= ev_data.data
			data.set_instance (inst)
		end

feature {NONE} -- Attribute

	data: COMMAND_TOOL
			-- Command tool to which Current belongs

feature {NONE} -- Command execution

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Retarget the command tool to a new instance of the currently
			-- edited command when `Current' is selected.
		local
			an_instance: CMD_INSTANCE
		do
			if pixmap = symbol then
				{EDIT_BUTTON} Precursor (arg, ev_data)
			elseif not data.empty then
				create an_instance.session_init (data.edited_command)
				data.set_instance_only (an_instance)
			end
		end

end -- class COMMAND_TOOL_HOLE


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
			process_command, 
			process_instance,
			process_any,
			compatible,
			execute,
			make
		end

	DRAG_SOURCE

	CMD_INST_STONE
		redefine
			stone_type
		end

creation

	make

feature -- Creation

	make (a_parent: COMPOSITE) is
		do
			{EDIT_BUTTON} Precursor (a_parent)
			initialize_transport
		end
feature -- Initialization

	set_parent_command_tool (cmd_tool: COMMAND_TOOL) is
			-- Set `parent_command_tool' to `cmd_tool'.
		require
			parent_not_void: cmd_tool /= Void
		do
			parent_command_tool := cmd_tool
		end

	stone_type: INTEGER is
			-- Current accept both command and instance stone.
			-- That's why we need to use any_type
		do
			Result := Stone_types.command_type
		end

	create_focus_label is
		do
			set_focus_string (Focus_labels.command_label)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.command_dot_pixmap
		end

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type
		end

	create_empty_editor is
		local
			tool: COMMAND_TOOL_TOP_SHELL
		do
			tool := window_mgr.command_tool
			window_mgr.display (tool)	
		end

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

feature -- Hole features

	process_any (dropped: STONE) is
			-- Check the kind of stone
		local
			a_cmd_inst: CMD_INST_STONE
			a_cmd: CMD_STONE
		do
			a_cmd_inst ?= dropped
			a_cmd ?= dropped
			if a_cmd_inst /= Void then
				process_instance (a_cmd_inst)
			elseif a_cmd /= Void then
				process_command (a_cmd)
			end
		end

	process_instance (dropped: CMD_INST_STONE) is
			-- Retarget the associated command tool .
		do
			parent_command_tool.set_instance (dropped.data)
		end

	process_command (dropped: CMD_STONE) is
			-- Retarget the associted command tool creating
			-- a new instance of `dropped.data'.
		do
			parent_command_tool.set_command (dropped.data)
		end

feature {NONE} -- Attribute

	parent_command_tool: COMMAND_TOOL
			-- Command tool to which Current belongs

	execute (arg: ANY) is
			-- Retarget the command tool to a new instance of the currently
			-- edited command when `Current' is pressed.
		local
			an_instance: CMD_INSTANCE
		do
			if parent_command_tool.command_instance /= Void then
				!! an_instance.session_init (parent_command_tool.edited_command)
				parent_command_tool.set_instance_only (an_instance)
			end
		end

feature -- Drag source features

	source: like Current is
		do
			Result := Current
		end

--	stone: like Current is
--		do
--			Result := Current
--		end

feature -- Stone features

	associated_command: CMD is
		do
			if parent_command_tool /= Void and then not parent_command_tool.empty then
				Result := parent_command_tool.command_instance.associated_command
			end
		end

	data: CMD_INSTANCE is 
		do
			if parent_command_tool /= Void and then not parent_command_tool.empty then
				Result := parent_command_tool.command_instance
			end
		end

end -- class COMMAND_TOOL_HOLE

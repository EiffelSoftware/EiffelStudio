indexing
	description: "Hole to drop a command that is an observer of %
				% another one";
	date: "$Date$";
	revision: "$Revision$"

class
	OBSERVER_HOLE

inherit
	EB_BUTTON;
	HOLE
		redefine
			process_instance, compatible
		select
			init_toolkit
		end

creation

	make

feature {NONE}

	command_tool: COMMAND_TOOL;
			-- Associated command tool

feature 

	data: CMD_INSTANCE is
		do
			if command_tool.command_instance /= Void then
				Result := command_tool.command_instance.data
			end
		end;

	target, source: WIDGET is
		do
			Result := Current
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.command_instance_label)
		end;

	associated_command: CMD is
		do
			Result := data.associated_command;
		end;

	make (ed: COMMAND_TOOL; a_parent: COMPOSITE) is
			-- Create the cmd_edit_hole with `ed' 
			-- as command_tool.
		require
			not_void_ed: not (ed = Void)
		do
			command_tool := ed;
			make_visible (a_parent);
			register
		end; 

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end;

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_dot_pixmap
		end;

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type
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

	stone_type: INTEGER is
			do
				Result := Stone_types.instance_type 
			end

feature {NONE}

	process_instance (dropped: CMD_INST_STONE) is
		local
			inst: CMD_INSTANCE
			command: ADD_OBSERVER_CMD
		do
			inst ?= dropped.data;
			if inst /= Void then
				!! command.make (command_tool.command_instance, inst)
				command.execute (Void)
			end
		end; 

end


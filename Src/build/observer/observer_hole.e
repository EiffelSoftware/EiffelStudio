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
			process_instance
		select
			init_toolkit
		end

creation

	make

feature {NONE}

	instance_editor: COMMAND_TOOL;
			-- Associated instance editor

feature 

	data: CMD_INSTANCE is
		do
			if instance_editor.command_instance /= Void then
				Result := instance_editor.command_instance.data
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
			-- as instance_editor.
		require
			not_void_ed: not (ed = Void)
		do
			instance_editor := ed;
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
				!! command.make (instance_editor.command_instance)
				command.execute (inst)
			end
		end; 

end -- class OBSERVER_HOLE

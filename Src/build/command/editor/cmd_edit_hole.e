-- Editing hole for command editor
class CMD_EDIT_HOLE 

inherit

	CMD_EDITOR_HOLE
		rename
			make as old_make
		end;
	CMD_STONE
		redefine
			transportable
		end
	REMOVABLE

creation

	make

feature {NONE}

	remove_yourself is
		do
			command_editor.clear
		end;

	focus_string: STRING is	
		do
			Result := Focus_labels.command_label
		end;
	
	source: WIDGET is
		do
			Result := Current
		end;
	
feature {NONE}

	make (cmd_editor: CMD_EDITOR; a_parent: COMPOSITE) is
			-- Create the cmd_edit_hole with `cmd_editor' 
			-- as command_editor.
		do
			old_make (cmd_editor, a_parent);
			initialize_transport
		end -- Create

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end;

feature

	original_stone: CMD is
		do
			Result := 
				command_editor.current_command.original_stone
		end;

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void
		end;

	label: STRING is
		do
			Result := original_stone.label
		end;

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end

	arguments: EB_LINKED_LIST [ARG] is
		do
			Result := original_stone.arguments
		end

	labels: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end

feature {NONE}

	process_stone is
		local
			cmd_type: CMD_STONE
			cmd_inst: CMD_INST_STONE
		do
			cmd_type ?= stone
			cmd_inst ?= stone
			if not (cmd_type = Void) then 
				if cmd_type.original_stone.edited then
					cmd_type.original_stone.command_editor.raise
				else
					command_editor.set_command (cmd_type.original_stone)
				end
			elseif not (cmd_inst = Void) then
				if cmd_inst.associated_command.edited then
					cmd_inst.associated_command.command_editor.raise
				else	
					command_editor.set_command (cmd_inst.associated_command)
				end
			end
		end -- process_stone

end 

class CMD_EDIT_HOLE 

inherit

	ICON_HOLE
		rename
			button as source,
			make_visible as make_icon_visible,
			identifier as oui_identifier
		export 
			{CMD_EDITOR} main_panel
		end
	ICON_HOLE
		rename
			button as source,
			identifier as oui_identifier
		redefine
			make_visible
		select
			make_visible
		end;
	CMD_STONE
		redefine
			transportable
		end
	REMOVABLE

creation

	make

	
feature {NONE}

	command_editor: CMD_EDITOR
		-- Associated command editor

	remove_yourself is
		do
			command_editor.clear
		end
	
feature 

	make (cmd_editor: CMD_EDITOR) is
			-- Create the cmd_edit_hole with `cmd_editor' 
			-- as command_editor.
		require
			not_void_cmd_editor: not (cmd_editor = Void)
		do
			command_editor := cmd_editor
			set_symbol (Pixmaps.command_pixmap)
		end -- Create


	reset is 
		do
			set_label ("")
  			set_symbol (Pixmaps.command_pixmap)
			original_stone := Void
		end

	set_command (cmd: CMD) is
		do
			
			original_stone := cmd
			if realized and shown and (label = Void or else label.empty 
			  or else cmd.label.count >= label.count) then
				parent.unmanage
			elseif realized and (label = Void or else label.empty 
			  or else cmd.label.count >= label.count) then
				hide
			end
			set_label (cmd.label)
			set_symbol (cmd.symbol)
			if realized and (not shown) then
				show
			end
			if not parent.managed then
				parent.manage
			end
		end

	original_stone: CMD

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void
		end

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


	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent)
			initialize_transport
		end

	update_name is
		do
			set_label (command_label)
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


	command_label: STRING is
		do
			Result := original_stone.label
		end

end 

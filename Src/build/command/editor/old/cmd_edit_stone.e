
class CMD_EDIT_STONE 

inherit

	ICON
		rename
			button as source,
			make_visible as make_icon_visible,
			identifier as oui_identifier
		export
			{NONE} all;
			{ANY} hide
		undefine
			init_toolkit
		end;

	ICON
		rename
			button as source,
			identifier as oui_identifier
		undefine
			init_toolkit
		redefine
			make_visible
		select
			make_visible
		end;
	CMD_STONE;
	PIXMAPS
		export
			{NONE} all
		end;
	REMOVABLE
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end


creation

	make

feature 

	reset is 
		do
			if realized and shown then
				hide
			end;
			original_stone := Void
		end;

	
feature {NONE}

	command_editor: CMD_EDITOR;

	remove_yourself is
		do
			command_editor.clear
		end;

	
feature 

	make (ed: CMD_EDITOR) is
		do
			command_editor := ed;
			set_label ("");
			set_symbol (Command_pixmap);
		end;

	set_command (cmd: CMD) is
		do
			original_stone := cmd;
			set_label (cmd.label);
			set_symbol (cmd.symbol);
			if realized and (not shown) then
				show
			end;
		end;

	original_stone: CMD;

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end;

	arguments: EB_LINKED_LIST [ARG] is
		do
			Result := original_stone.arguments
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport
		end;

	update_name is
		do
			set_label (command_label)
		end;

feature {NONE} 

	command_label: STRING is
		do
			Result := original_stone.label
		end;

end

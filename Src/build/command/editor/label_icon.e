
class LABEL_ICON 

inherit

	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end;
	LABEL_STONE;
	REMOVABLE

creation

	make
	
feature {NONE}

	cmd_editor: CMD_EDITOR;

	
feature 

	data: CMD_LABEL;

	make (ed: CMD_EDITOR) is
		do
			cmd_editor := ed
		end;

	set_widget_default is
		do
			initialize_transport;
		end;

	remove_yourself is
		do
			cmd_editor.remove_label (data)
		end;

end

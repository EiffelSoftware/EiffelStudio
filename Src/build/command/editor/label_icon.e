
class LABEL_ICON 

inherit

	ICON_STONE
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
		end;
	LABEL_STONE;
	REMOVABLE

creation

	make
	
feature {NONE}

	cmd_editor: CMD_EDITOR;

	
feature 

	original_stone: CMD_LABEL;

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
			cmd_editor.remove_label (original_stone)
		end;

end

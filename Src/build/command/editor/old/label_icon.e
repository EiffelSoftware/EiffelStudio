
class LABEL_ICON 

inherit

	ICON_STONE
		rename
			make_visible as make_icon_visible,
			make as icon_make
		undefine
			stone_cursor
		redefine
			original_stone
		end;
	ICON_STONE
		rename
			make as icon_make
		undefine
			stone_cursor
		redefine
			make_visible, original_stone
		select
			make_visible
		end;
	LABEL_STONE
		export
			{NONE} all
		end;
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

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport;
		end;

	remove_yourself is
		do
			cmd_editor.remove_label (original_stone)
		end;

end

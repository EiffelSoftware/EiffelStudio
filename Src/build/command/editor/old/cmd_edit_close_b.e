
class CMD_EDIT_CLOSE_B 

inherit

	CLOSE_BUTTON
		undefine
			init_toolkit,
			make
		redefine
			execute
		end;
	WINDOWS
		export
			{NONE} all
		end


creation

	make

	
feature 

	make (ed: CMD_EDITOR) is
		do
			associated_editor := ed;
			set_symbol (Quit_pixmap)
		end;

	
feature {NONE}

	associated_editor: CMD_EDITOR;

	execute (argument: ANY) is
		do
			associated_editor.close
		end;
	
end

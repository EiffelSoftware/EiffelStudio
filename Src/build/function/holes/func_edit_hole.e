
class FUNC_EDIT_HOLE 

inherit

	ICON_HOLE
		export
			{NONE} all;
			{ANY} set_managed;
		end;

	REMOVABLE


creation

	make
	
feature 

	remove_yourself is
		local
			wipe_out_command: FUNC_WIPE_OUT
		do
			!!wipe_out_command;
			wipe_out_command.execute (function_editor.edited_function)
		end;

	
feature {NONE}

	function_editor: FUNC_EDITOR;

feature 

	make (ed: FUNC_EDITOR) is
		do
			function_editor := ed;
		end;

	process_stone is do end;

end


class S_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		rename
			make as func_edit_make,
			identifier as oui_identifier
		export
			{ANY} all
		redefine
			stone, function_editor, 
			process_stone
		end;

	PIXMAPS
		export
			{NONE} all
		end

creation

	make

feature {NONE}

	function_editor: STATE_EDITOR;

feature 

	make (ed: STATE_EDITOR) is
		do
			func_edit_make (ed);
			set_symbol (State_pixmap)
		end;

	-- ** Hole definitions ** --

	
feature {NONE}

	stone: STATE_STONE;

	process_stone is
		local
			state: STATE
		do
			state := stone.original_stone;
			if
				state.edited
			then
				state.raise_editor
			else
				function_editor.set_edited_function (state);
			end
		end;

end



class CON_EDIT_HOLE 

inherit

	ICON_HOLE
		redefine
			stone
		end;
	PIXMAPS
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	associated_editor: CONTEXT_EDITOR;

	
feature 

	stone: CONTEXT_STONE;

	make (ed: CONTEXT_EDITOR) is
		do
			set_symbol (Context_pixmap);
			associated_editor := ed
		end;

	
feature {NONE}

	process_stone is
			-- Set the new edited context
		do
			associated_editor.set_edited_context (stone.original_stone)
		end;

end

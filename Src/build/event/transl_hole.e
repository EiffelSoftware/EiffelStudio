
class TRANSL_HOLE 

inherit

	ICON_HOLE
		redefine
			stone
		end;
	PIXMAPS	

creation

	make
	
feature 

	stone: EV_ICON_STONE;
	
feature 

	editor: TRANSL_EDITOR;

	make (ed: TRANSL_EDITOR) is
		do
			editor := ed;
			set_symbol (Event_pixmap);
			make_visible (editor);
		end;

feature {NONE}

	process_stone is
		local
			translation: TRANSLATION;
		do
			translation ?= stone.original_stone;
			if not (translation = Void) then
				editor.set_edited_translation (translation);
			end;
		end;

end

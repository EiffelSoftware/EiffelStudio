
class TRANSL_HOLE 

inherit

	ICON_HOLE
		rename
			make_visible as trans_make_visible
		redefine
			stone, compatible
		end;
	ICON_HOLE
		redefine
			stone, compatible, make_visible
		select
			make_visible, button, identifier, same
		end;
	EV_ICON_STONE
		rename
			make as unused_make,
			make_visible as ev_make_visible,
			identifier as stone_identifier
		undefine
			same
		redefine
			original_stone, transportable
		end;

creation

	make
	
feature 

	original_stone: TRANSLATION;

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void;
		end;

	reset is 
		do
			if original_stone /= Void then
				original_stone := Void;
				set_symbol (Pixmaps.event_pixmap);
				set_label ("");
			end;
		end;

	stone: EV_ICON_STONE;

	compatible (s: EV_ICON_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;
	
feature 

	editor: TRANSL_EDITOR;

	make (ed: TRANSL_EDITOR) is
		do
			editor := ed;
			set_symbol (Pixmaps.event_pixmap);
			make_visible (editor);
		end;

	set_translation (t: like original_stone) is
		do
			original_stone := t;
			set_label (t.label);
			set_symbol (t.symbol);
		end;

	make_visible (a_parent: COMPOSITE) is
		do
			trans_make_visible (a_parent);
			initialize_transport
		end;

	update_name is
		do
			set_label (trans_label)
		end;

	trans_label: STRING is
		do
			Result := original_stone.label
		end



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

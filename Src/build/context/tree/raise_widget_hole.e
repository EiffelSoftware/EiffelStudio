class RAISE_WIDGET_HOLE

inherit

	HOLE
		redefine
			stone, compatible
		end;
	EB_BUTTON 

creation

	make

feature {NONE}

	stone: CONTEXT_STONE;

	focus_string: STRING is
		do
			Result := Focus_labels.raise_widget_label
		end;

	focus_label: FOCUS_LABEL;

	make (a_parent: COMPOSITE; l: like focus_label) is
		do
			focus_label := l;
			make_visible (a_parent);
			register
		end;

	target: WIDGET is
		do
			Result := Current;
		end;

	compatible (s: CONTEXT_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	process_stone is
		do
			stone.original_stone.raise
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.raise_widget_pixmap
		end;

end

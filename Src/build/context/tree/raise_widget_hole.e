class RAISE_WIDGET_HOLE

inherit

	TREE_HOLE
		redefine
			process_context
		end;
	EB_BUTTON 

creation

	make

feature {NONE}

	focus_string: STRING is
		do
			Result := Focus_labels.raise_widget_label
		end;

	process_context (dropped: CONTEXT_STONE) is
		do
			dropped.data.raise
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.raise_widget_pixmap
		end;

end

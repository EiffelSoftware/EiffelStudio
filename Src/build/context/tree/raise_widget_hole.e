class RAISE_WIDGET_HOLE

inherit

	HOLE
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

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
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

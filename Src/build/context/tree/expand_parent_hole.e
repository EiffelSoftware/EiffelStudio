class EXPAND_PARENT_HOLE

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
			Result := Focus_labels.expand_parent_label
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
		local
			os: CONTEXT;
		do
			os := dropped.data;
			os.tree_element.expand_action
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.expand_parent_pixmap
		end;

end


deferred class MERGE_HOLE 

inherit

	HOLE;
	EB_BUTTON;

feature {NONE}

	target: WIDGET is
		do
			Result := Current
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.merge_label
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := associated_function.focus_label
		end;

	make (func: FUNC_EDITOR; a_parent: COMPOSITE) is
		do
			associated_function := func;
			make_visible (a_parent);
			register
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.merge_pixmap
		end;
	
feature {NONE}

	associated_function: FUNC_EDITOR;
			-- Function associated with current hole


end

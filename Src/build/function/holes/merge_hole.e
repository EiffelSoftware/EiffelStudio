
deferred class MERGE_HOLE 

inherit

	HOLE
		select
			init_toolkit
		end
	EB_BUTTON

feature {NONE}

	target: WIDGET is
		do
			Result := Current
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.merge_label)
		end;

-- samik	focus_label: FOCUS_LABEL is
-- samik		do
-- samik			Result := associated_function.focus_label
-- samik		end;

	make (func: FUNC_EDITOR; a_parent: COMPOSITE) is
		do
			associated_function := func;
			make_visible (a_parent);
			-- added by samik
			set_focus_string (Focus_labels.merge_label)
			-- end of samik
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

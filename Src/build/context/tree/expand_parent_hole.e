class EXPAND_PARENT_HOLE

inherit

	TREE_HOLE

creation

	make

feature {NONE}

	focus_string: STRING is
		do
			Result := Focus_labels.expand_parent_label
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

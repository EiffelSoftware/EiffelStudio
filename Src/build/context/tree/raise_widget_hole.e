class RAISE_WIDGET_HOLE

inherit

	TREE_HOLE
        rename
            make as parent_make
		redefine
			process_context
		end;

creation

	make

feature {NONE}
 
	make (a_parent: COMPOSITE) is
        do
            parent_make (a_parent)
            set_focus_string (Focus_labels.raise_widget_label)
        end

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.raise_widget_label
-- samik		end;

	process_context (dropped: CONTEXT_STONE) is
		do
			dropped.data.raise
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.raise_widget_pixmap
		end;

end

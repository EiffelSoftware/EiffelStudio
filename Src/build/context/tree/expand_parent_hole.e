class EXPAND_PARENT_HOLE

inherit

	TREE_HOLE
        rename
            make as parent_make
		end
creation

	make

feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            parent_make (a_parent)
        end

	create_focus_label is
		do
			set_focus_string (Focus_labels.expand_parent_label)
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

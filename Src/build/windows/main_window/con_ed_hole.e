class CON_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_stone
		end;

creation
	make

feature

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			set_symbol (Context_pixmap);
			initialize_focus;
		end;

	process_stone is
		local
			cont: CONTEXT;
		do
			cont ?= stone.original_stone;
			if cont /= Void then
				cont.create_editor;
			end;
		end;

feature {NONE}

	focus_label: LABEL is
		do
			Result := main_panel.focus_label;
		end;

	focus_string: STRING is "Context hole";
	

end

class STATE_ED_HOLE

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
			set_symbol (State_pixmap);
			initialize_focus;
		end;

	process_stone is
		local
			st: STATE;
		do
			st ?= stone.original_stone;
			if st /= Void then
				st.create_editor;
				
			end;
		end;

feature {NONE}

	focus_label: LABEL is
		do
			Result := main_panel.focus_label;
		end;

	focus_string: STRING is "State hole";
	

end

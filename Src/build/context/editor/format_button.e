deferred class FORMAT_BUTTON

inherit

	EB_BUTTON_COM

feature

	editor: CONTEXT_EDITOR;

	form_number: INTEGER is
		deferred
		end;

	selected_symbol: PIXMAP is
		deferred
		end;

	set_form_number (nbr: like form_number) is
		require
			valid_form_nbr: valid_form_nbr (nbr)
		do
			-- Do nothing
		end;

	valid_form_nbr (nbr: INTEGER): BOOLEAN is
		do
			Result := True
		end;

	unselect_symbol is
		do
			set_symbol (symbol)
		end;

	set_selected_symbol is
		do
			set_symbol (selected_symbol)
		end;

feature {NONE} -- command

	make (a_parent: COMPOSITE; ed: like editor) is
		do
			editor := ed;
			make_visible (a_parent);
		end;

	execute (argument: ANY) is
		do
			editor.update_form (form_number)
		end

end

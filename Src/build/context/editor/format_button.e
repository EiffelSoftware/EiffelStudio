deferred class FORMAT_BUTTON

inherit

	EB_BUTTON_COM

feature {NONE} -- focus

	focus_string: STRING is
		deferred
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := editor.focus_label
		end

feature

	editor: CONTEXT_EDITOR;

	form_number: INTEGER is
		deferred
		end;

	set_form_number (nbr: like form_number) is
		require
			valid_form_nbr: valid_form_nbr (nbr)
		do
			-- Do nothing
		end;

	make (a_parent: COMPOSITE; ed: like editor) is
		do
			editor := ed;
			make_visible (a_parent);
		end;

	valid_form_nbr (nbr: INTEGER): BOOLEAN is
		do
			Result := True
		end;

feature {NONE} -- command

	execute (argument: ANY) is
		do
			editor.update_form (form_number)
		end

end

deferred class FORMAT_BUTTON

inherit

	EB_PICT_B
		undefine
			init_toolkit, symbol
		end;
	PIXMAPS
	COMMAND
	FOCUSABLE
	WINDOWS
	CONSTANTS

feature {NONE} -- focus

	focus_source: WIDGET is
		do
			Result := Current
		end

	focus_string: STRING is
		deferred
		end;

	focus_label: LABEL is
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
			set_symbol (symbol);
			add_activate_action (Current, Void);
			initialize_focus
		end;

	valid_form_nbr (nbr: INTEGER): BOOLEAN is
		do
			Result := True
		end;

feature {NONE} -- command

	execute (argument: ANY) is
		do
			if form_number /= editor.current_form_number then
				editor.set_form (form_number)
			end
		end

end

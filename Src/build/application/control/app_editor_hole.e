deferred class APP_EDITOR_HOLE

inherit

	EB_BUTTON;
	HOLE

feature {NONE}

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			register
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := app_editor.focus_label
		end;

	target: WIDGET is
		do
			Result := Current
		end;

end




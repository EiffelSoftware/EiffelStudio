-- General class for holes in the command editor
deferred class CMD_EDITOR_HOLE

inherit

	EB_BUTTON;
	HOLE

feature {NONE}

	command_editor: CMD_EDITOR;

	make (ed: CMD_EDITOR; a_parent: COMPOSITE) is
		require
			valid_ed: ed /= Void
		do
			command_editor := ed;
			make_visible (a_parent);
			register;
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := command_editor.focus_label
		end;

	target: WIDGET is
		do
			Result := Current
		end

end
	

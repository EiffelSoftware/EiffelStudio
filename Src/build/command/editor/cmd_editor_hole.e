-- General class for holes in the command editor
deferred class CMD_EDITOR_HOLE

inherit

	EB_BUTTON;
	HOLE
		select
			init_toolkit
		end

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

	target: WIDGET is
		do
			Result := Current
		end

end
	

indexing
	description: "General class for holes in the command editor."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMD_EDITOR_HOLE

inherit

	EB_BUTTON

	HOLE
		select
			init_toolkit
		end

feature {NONE}

	command_editor: COMMAND_EDITOR

	make (ed: like command_editor; a_parent: COMPOSITE) is
		require
			valid_ed: ed /= Void
		do
			command_editor := ed
			make_visible (a_parent)
			register
		end

	target: WIDGET is
		do
			Result := Current
		end

end -- class CMD_EDITOR_HOLE

indexing

	description: 
		"Class abstraction for editing text.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EDIT

inherit

	EB_CONSTANTS;

feature -- Element change

	edit (a_file: STRING) is
			-- Edit file `a_file'.
		require
			file_not_void: a_file /= Void
		local
			editor: STRING;
			cmd: STRING;
			cmd_exec: EXTERNAL_COMMAND_EXECUTOR
		do
			editor := General_resources.editor.value;
			if editor /= Void then
				!!cmd.make (0);
				cmd.append (editor);
				cmd.extend (' ');
				cmd.append (a_file);
				!! cmd_exec;
				cmd_exec.execute (cmd)
			else
				io.error.putstring ("The resource EDITOR is not set%N");
			end;
		end;

end -- class EWB_EDIT

indexing

	description: 
		"Class abstraction for editing text.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EDIT

inherit
	EB_SHARED_PREFERENCES

feature -- Element change

	edit (a_file: STRING) is
			-- Edit file `a_file'.
		require
			file_not_void: a_file /= Void
		local
			editor: STRING;
			cmd: STRING;
			cmd_exec: COMMAND_EXECUTOR
		do
			editor := preferences.misc_data.general_shell_command
			if editor /= Void then
				create cmd.make (0);
				cmd.append (editor);
				cmd.extend (' ');
				cmd.append (a_file);
				create cmd_exec;
				cmd_exec.execute (cmd)
			else
				io.error.put_string ("The resource EDITOR is not set%N");
			end;
		end;

end -- class EWB_EDIT

indexing

	description: 
		"Class abstraction for editing text.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EDIT

inherit

	SHARED_BENCH_RESOURCES;

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
			editor := resources.get_string (r_Editor, Void);
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

class SHELL_COMMAND 

inherit

	ICONED_COMMAND

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;


feature {NONE}

	work (argument: ANY) is
			-- Quit cautiously a file.
		local
			req: ASYNC_SHELL;
			cmd_string: STRING;
			fs: FILED_STONE
		do
			if text_window.root_stone /= Void then
				fs ?= text_window.root_stone;
				!!req;
				!!cmd_string.make (0);
				cmd_string.append ("$EIF_EDITOR ");
				cmd_string.append (fs.file_name);
				req.set_command_name (cmd_string);
				req.send
			end;
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Shell) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Shell end;

end

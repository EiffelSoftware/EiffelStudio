
class EBUILD 

inherit

	ARGUMENTS;

	WINDOWS
		export
			{NONE} all
		end;
	AUTO_SAVE
		export
			{NONE} all
		end

creation

	make
	
feature 

	make is
		local
			init: INIT_CHECK
		do
			!!init;
			init.perform_initial_check;
			if init.error then
				io.error.putstring ("EiffelBuild stopped%N");
				exit
			else
				init_windowing;
				init_project;
				read_command_line;
				iterate
			end;
		rescue
			save_rescue
		end;
	
feature {NONE}
	
	read_command_line is
		local
			cmd: OPEN_PROJECT
		do
			if argument_count > 1 then
				!!cmd;
				cmd.execute (argument (1))
			end;
		end;

	retried: BOOLEAN;

	save_rescue is
		do
			-- no_message_on_failure;
			if not retried then
				history_window.wipe_out;
				-- Force garbage collection
				if main_panel.project_initialized then
					auto_save;
				end
			else
				io.error.putstring ("EiffelBuild: internal error%N");	
			end;
		rescue
			retried := True;
			retry
		end;

end


class EBUILD 

inherit

	CONSTANTS;
	ARGUMENTS;
	WINDOWS;
	SHARED_LICENSE;
	GRAPHICS;

feature 

	make is
		local
			init: INIT_CHECK;
		do
			init_windowing;
			!!init;
			init.perform_initial_check;
			if init.error then
				io.error.putstring ("EiffelBuild stopped%N");
				exit
			elseif init_licence then
					-- Initialize the resources;
				if resources = Void then end;
				init_project;
				read_command_line;
				iterate;
				discard_licence
			end;
		rescue
			discard_licence;
			rescue_project
		end;

feature {NONE} -- Initialize toolkit

	init_windowing is
			-- Initialize toolkit
		do
            if (toolkit = Void) then end
		end

feature {NONE}

	Application_name: STRING is "eiffelbuild";

	init_licence: BOOLEAN is
		do
			licence.get_registration_info;
			licence.set_version (3);
			licence.set_application_name (Application_name);
			Result := licence.connected
		end;

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

	rescue_project is
		local
			storer: STORER
		do
			-- no_message_on_failure;
			if not retried then
				history_window.wipe_out;
				-- Force garbage collection
				if main_panel.project_initialized then
					!! storer.make;
					storer.store (Environment.restore_directory);
					io.error.putstring ("EiffelBuild: internal error%N");	
				end
			end;
		rescue
			retried := True;
			io.error.putstring ("EiffelBuild: internal error%N");	
            if original_exception = Operating_system_exception then
                io.error.putstring ("Reason:  ");
                io.error.putstring (original_tag_name)
            end;
			retry
		end;

end

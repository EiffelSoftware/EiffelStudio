
class EBUILD 

inherit

	CONSTANTS;
	ARGUMENTS;
	WINDOWS;
	SHARED_LICENSE;
	GRAPHICS;
	UNIX_SIGNALS
		rename
			meaning as sig_meanging,
			ignore as sig_ignore,
			catch as sig_catch
		end;
	QUEST_POPUPER
		redefine
			continue_after_question_popdown
		end

feature 

	make is
		local
			init: INIT_CHECK;
			mp: MOUSE_PTR;
			tg: STRING
		do
			no_message_on_failure;
			if not retried then
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
				end
			else
				!! mp;
				mp.restore;
				if original_tag_name = Void then
					tg := " "
				else
					tg := original_tag_name
				end
				Question_box.popup (Current,
					Messages.internal_error_qu,
					tg);
				retried := False;
				iterate
			end;
		rescue
			discard_licence;
			if not is_signal or else signal /= Sigint then
				retried := True;
				rescue_project
				retry
			end
		end;

	popuper_parent: COMPOSITE is	
		do
			Result := main_panel.base
		end;

	continue_after_question_popdown (yes: BOOLEAN) is
		do
			if yes then
				update_all_windows;
			else
				exit
			end
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
			if main_panel.project_initialized then
				history_window.wipe_out;
				!! storer.make;
				storer.store (Environment.restore_directory);
			end;
		end;

end

-- Root class of the Eiffelbench system.

class EWB

inherit

	WINDOWS;
	EIFFEL_ENV;
	ISED_X_SLAVE;
	ARGUMENTS;
	BUILD_LIC
		rename
			build_dir as Eiffel3_dir_name
		undefine
			Eiffel3_dir_name
		end;
	SHARED_RESCUE_STATUS;
	EXCEPTIONS

creation

	make

feature -- Licence managment

	init_licence: BOOLEAN is
		do
			licence.get_registration_info;
			licence.set_version (3);
			licence.set_application_name ("eiffelbench");
			licence.register;
			if licence.registered then
				licence.open_licence;
				Result := licence.licenced
			end;
		end;

	discard_licence is
		do
			if licence.registered then
				licence.unregister
			end;
		end;
	
feature 

	retried: BOOLEAN;

	make is
			-- Create and map the first window: the system window.
		local
			screen: SCREEN;
			temp: STRING
		do
				-- Check that environment variables
				-- are properly set.
			temp := env_variable ("EIFFEL3");
			if (temp = Void) or else temp.empty then
				io.error.putstring 
					("Ise Eiffel3: the environment variable $EIFFEL3 is not set%N");
				die (-1)
			end;
			temp := env_variable ("PLATFORM");
			if (temp = Void) or else temp.empty then
				io.error.putstring 
					("Ise Eiffel3: the environment variable $PLATFORM is not set%N");
				die (-1)
			end;
			if not retried then
				if argument_count = 2 and then
					argument (1).is_equal ("-bench")
				then
					set_batch_mode (False);
					init_connection;
					if init_licence then
						init_windowing;
						iterate
					end;
				else
					set_batch_mode (True);
					if init_licence then
						!!batch_compiler.make;
						discard_licence;
					end;
				end;
			else
				-- Ensure clean exit in case of exception
			end;
		rescue
			discard_licence;
			if not Rescue_status.fail_on_rescue then
				retried := True;
--				io.error.putstring
--					("ISE Eiffel3: Session aborted%N");
--				io.error.putstring
--					("Exception tag: ");
--				io.error.putstring
--					(programmer_exception_name);
--				io.error.new_line;
				retry
			end;
		end;
	
feature {NONE}

	batch_compiler: ES;

	init_windowing is
			-- Initialize the windowing environment.
		do
			if project_tool = Void then end;
			if name_chooser = Void then end;
			if confirmer = Void then end;
			project_tool.popup_file_selection;
		end
 
end

-- Root class of the Eiffelbench system.

class EWB

inherit

	WINDOWS;
	EIFFEL_ENV;
	ISED_X_SLAVE;
	ARGUMENTS;
	LIC_EXITER
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
				if not Result then
					licence.unregister
				end;
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
			if not retried then
					-- Check that environment variables
					-- are properly set.
				temp := env_variable ("EIFFEL3");
				if (temp = Void) or else temp.empty then
					io.error.putstring 
						("ISE Eiffel3: the environment variable $EIFFEL3 is not set%N");
					die (-1)
				end;
				temp := env_variable ("PLATFORM");
				if (temp = Void) or else temp.empty then
					io.error.putstring 
						("ISE Eiffel3: the environment variable $PLATFORM is not set%N");
					die (-1)
				end;
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
						discard_license;
					end;
				end;
			else
				-- Ensure clean exit in case of exception
			end;
		rescue
			discard_license;
			if not batch_mode then
					-- The rescue in BASIC_ES will display the tag
				io.error.putstring ("ISE Eiffel3: Session aborted%N");
				io.error.putstring ("Exception tag: ");
				io.error.putstring (developer_exception_name);
				io.error.new_line;
			end;
			if not Rescue_status.fail_on_rescue then
				retried := True;
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

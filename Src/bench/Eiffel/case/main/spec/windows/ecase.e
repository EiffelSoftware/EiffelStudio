indexing

	description: "Root class to initiate eiffelcase session.";
	date: "$Date$";
	revision: "$Revision $"

class ECASE

inherit

	MEMORY;
	ONCES;
	CONSTANTS;
	SHARED_FILE_SERVER;
	GRAPHICS;
	SHARED_CASE_LICENCE;
	UNIX_SIGNALS
		rename
			meaning as sig_meanging,
			ignore as sig_ignore,
			catch as sig_catch
		end
	ARGUMENTS
	WARNING_CALLER

feature -- Initialization

	make is
			-- Run an EiffelCase session.
		local
			init: INIT_CHECK;
			st : STRING
		do
			no_message_on_failure;
			if not rescued then
				if toolkit = void then end;
				Windows.create_screen;
				Windows.create_present ( Current )
			else
				io.error.putstring ("Internal error: ");
				if original_tag_name /= Void then
					io.error.putstring (original_tag_name); 
				end;
				io.error.putstring ("%NEiffelCase stopped%N");
			end
		rescue
			discard_license;
			if not is_signal or else signal /= Sigint then
				rescued := True;
				retry;
			else
				Temporary_system_file_server.remove_tmp_files;
				Class_content_server.delete_classes_not_in_system
			end
		end -- make


feature -- Properties

	rescued: BOOLEAN;
			-- Has the project been rescued?

	rescue_project is
			-- Rescue project to the restore file.	
		local
			rescue_info: RESCUE_INFO
		do
			history.wipe_out;
			!! rescue_info.make;
			rescue_info.store_information;
		end;

	after_present is
		-- routine launched after the creation of the splash screen 
		-- and the different windows... 
		local
			init: INIT_CHECK;
			st : STRING
		do
					!! init;
					init.execute (Void);
					if init.error then
							io.error.putstring ("EiffelCase stopped%N");
							elseif init_license then
								init := Void;
								windows.create_windows;
								refresh_background
									if argument_count>0 and then argument(1)/= Void then
									-- case where the application is launched from a 
									-- particular file.
										st := clone (argument(1))
										Windows.set_automatic_load (st)
									end
								iterate
					end
					rescue
						try_to_rescue
		end
		
		try_to_rescue is
			-- routine in charge of rescuing a project.
			-- it offers the choice of starting again or exiting ...
			local
				err : BOOLEAN
			do
				if not err then
					Windows.warning(Windows.main_graph_window,"Wad","", Current )
				else
					io.put_string("%N EiffelCase stopped.Please retry.%N")
				end
				rescue
					-- We do not succeed in displaying the windows ...
					err := TRUE 
					retry
			end

		ok_action is do
			after_present
		end
		
		cancel_action is do 
		end

feature -- Access

	refresh_background is do end

	init_license: BOOLEAN is
			-- Is the licence initalized?
		do
			license.get_license;
			Result := license.licensed
		end

end -- class ECASE

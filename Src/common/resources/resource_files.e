indexing

	description: "Resource file name server";
	date: "$Date$";
	revision: "$Revision $"

class RESOURCE_FILES

inherit

	EXECUTION_ENVIRONMENT;
	OPERATING_ENVIRONMENT

creation

	make

feature -- Initialization

	make (new_name: STRING) is
			-- Create a resource file name server for application `new_name'.
		require
			new_name_not_void: new_name /= Void
		do
			application_name := new_name;
			Eiffel4 := get ("EIFFEL4");
			Platform := get ("PLATFORM");
			Home := get ("HOME");
			Eifdefaults := get ("EIF_DEFAULTS")
		ensure
			application_name = new_name
		end;

feature -- File names

	system_general: FILE_NAME is
			-- General system level resource specification file
			-- ($EIFFEL4/eifinit/application_name/general)
		do
			if Eiffel4 /= Void then
				!! Result.make_from_string (Eiffel4);
				Result.extend_from_array (<<Eifinit, application_name>>);
				Result.set_file_name (General);
			end
		end;

	system_specific: FILE_NAME is
			-- Platform specific system level resource specification file
			-- ($EIFFEL4/eifinit/application_name/spec/$PLATFORM)
		do
			if Eiffel4 /= Void and Platform /= Void then
				!! Result.make_from_string (Eiffel4);
				Result.extend_from_array (<<Eifinit, application_name, Spec>>);
				Result.set_file_name (Platform);
			end
		end;

	user_general: FILE_NAME is
			-- General user level resource specification file
			-- $HOME/eifinit/application_name/general
		local
			directory: DIRECTORY
			msg: STRING;
			wd: WARNING_D;
			file: PLAIN_TEXT_FILE
		do
			if Home /= Void then
				!! Result.make_from_string (Home);
				!! directory.make (Result)
				if directory.is_writable then
					Result.extend (Eifinit);	
					!! directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.extend (application_name);
					!! directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.set_file_name (General);
					!! file.make (Result)
					if not file.exists then
						file.create_read_write
						file.close
					end	
				else
					Result.extend (Eifinit);
					Result.extend (application_name);
					Result.set_file_name (General);
				end
			end
		end;

	user_specific: FILE_NAME is
			-- Platform specific user level resource specification file
			-- $HOME/eifinit/application_name/spec/$PLATFORM
		local
			directory: DIRECTORY
			msg: STRING;
			wd: WARNING_D;
			file: PLAIN_TEXT_FILE
		do
			if Home /= Void and Platform /= Void then
				!! Result.make_from_string (Home);
				!! directory.make (Result)
				if directory.is_writable then
					Result.extend (Eifinit);
					!! directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.extend (application_name);				!! directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.extend (Spec);			
					!! directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.set_file_name (Platform);
					!! file.make (Result)
					if not file.exists then
						file.create_read_write
						file.close
					end	
				else
					Result.extend (Eifinit);
					Result.extend (application_name);
					Result.extend (Spec);
					Result.set_file_name (Platform);			
				end
			end
		end;

	defaults_general: FILE_NAME is
			-- General user level resource specification file
			-- $EIF_DEFAULTS/application_name/general
		do
			if Eifdefaults /= Void then
				!! Result.make_from_string (Eifdefaults);
				Result.extend (application_name);
				Result.set_file_name (General);
			end
		end;

	defaults_specific: FILE_NAME is
			-- Platform specific user level resource specification file
			-- $EIF_DEFAULTS/application_name/spec/$PLATFORM
		do
			if Eifdefaults /= Void and Platform /= Void then
				!! Result.make_from_string (Eifdefaults);
				Result.extend (application_name);
				Result.extend (Spec);
				Result.set_file_name (Platform);
			end
		end

feature {NONE} -- Implementation

	Eiffel4: STRING;
	Platform: STRING;
	Home: STRING;
	Eifdefaults: STRING;
			-- Environments variables

	Eifinit: STRING is "eifinit";
	Spec: STRING is "spec";
	General: STRING is "general";
			-- File and directory names

	application_name: STRING;
			-- Application name (bench, build, case, ...)

invariant

	application_name_not_void: application_name /= Void

end -- class RESOURCE_FILES

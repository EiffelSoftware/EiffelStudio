indexing

	description: "Resource file name server";
	date: "$Date$";
	revision: "$Revision $"

class RESOURCE_FILES

inherit
	EIFFEL_ENV

creation

	make

feature -- Initialization

	make (new_name: STRING) is
			-- Create a resource file name server for application `new_name'.
		require
			new_name_not_void: new_name /= Void
		do
			application_name := new_name;
		ensure
			application_name = new_name
		end;

feature -- File names

	system_general: FILE_NAME is
			-- General system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/general)
		do
			if Eiffel_installation_dir_name /= Void then
				create Result.make_from_string (Eiffel_installation_dir_name);
				Result.extend_from_array (<<Eifinit, application_name>>);
				Result.set_file_name (General);
			end
		end;

	system_specific: FILE_NAME is
			-- Platform specific system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/spec/$PLATFORM)
		do
			if Eiffel_installation_dir_name /= Void and Eiffel_platform /= Void then
				create Result.make_from_string (Eiffel_installation_dir_name);
				Result.extend_from_array (<<Eifinit, application_name, Spec>>);
				Result.set_file_name (Eiffel_platform);
			end
		end;

	user_general: FILE_NAME is
			-- General user level resource specification file
			-- $HOME/eifinit/application_name/general
		local
			directory: DIRECTORY
			file: PLAIN_TEXT_FILE
		do
			if Home /= Void then
				create Result.make_from_string (Home)
				create directory.make (Result)
				if directory.is_writable then
					Result.extend (Eifinit)
					create directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.extend (application_name)
					create directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.set_file_name (General)
					create file.make (Result)
					if not file.exists then
						file.create_read_write
						file.close
					end	
				else
					Result.extend (Eifinit)
					Result.extend (application_name)
					Result.set_file_name (General)
				end
			end
		end

	user_specific: FILE_NAME is
			-- Platform specific user level resource specification file
			-- $HOME/eifinit/application_name/spec/$PLATFORM
		local
			directory: DIRECTORY
			file: PLAIN_TEXT_FILE
		do
			if Home /= Void and Eiffel_platform /= Void then
				create Result.make_from_string (Home)
				create directory.make (Result)
				if directory.is_writable then
					Result.extend (Eifinit)
					create directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.extend (application_name)
					create directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.extend (Spec)
					create directory.make (Result)
					if not directory.exists then
						directory.create_dir
					end
					Result.set_file_name (Eiffel_platform)
					create file.make (Result)
					if not file.exists then
						file.create_read_write
						file.close
					end	
				else
					Result.extend (Eifinit)
					Result.extend (application_name)
					Result.extend (Spec)
					Result.set_file_name (Eiffel_platform)
				end
			end
		end

	defaults_general: FILE_NAME is
			-- General user level resource specification file
			-- $EIF_DEFAULTS/application_name/general
		do
			if Eiffel_defaults /= Void then
				create Result.make_from_string (Eiffel_defaults);
				Result.extend (application_name);
				Result.set_file_name (General);
			end
		end;

	defaults_specific: FILE_NAME is
			-- Platform specific user level resource specification file
			-- $EIF_DEFAULTS/application_name/spec/$PLATFORM
		do
			if Eiffel_defaults /= Void and Eiffel_platform /= Void then
				create Result.make_from_string (Eiffel_defaults);
				Result.extend (application_name);
				Result.extend (Spec);
				Result.set_file_name (Eiffel_platform);
			end
		end

feature {NONE} -- Implementation

	Eifinit: STRING is "eifinit";
	Spec: STRING is "spec";
	General: STRING is "general";
			-- File and directory names

	application_name: STRING;
			-- Application name (bench, build, case, ...)

invariant

	application_name_not_void: application_name /= Void

end -- class RESOURCE_FILES

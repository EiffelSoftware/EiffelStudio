indexing

	description: "Resource file name server";
	date: "$Date$";
	revision: "$Revision $"

class RESOURCE_FILES_PARSER

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

feature -- File extension

	set_extension (an_extension: STRING) is
			-- Set `extension' to `an_extension'.
		require
			an_extension_valid: an_extension /= Void and then an_extension.count <= 3
		do
			extension := an_extension
		end;

	extension: STRING
			-- The extension

feature -- File parsing

	parse_files (a_table: RESOURCE_TABLE) is
			-- Put resources from specified application and suffix into
			-- table `a_table'.
		local
			file_name: FILE_NAME;
			parser: RESOURCE_PARSER
		do
			!! parser;
            file_name := system_general;
            if file_name /= Void and then not file_name.empty then
                parser.parse_file (file_name, a_table)
            end;
            file_name := system_specific;
            if file_name /= Void and then not file_name.empty then
                parser.parse_file (file_name, a_table)
            end;
            file_name := user_general;
            if file_name /= Void and then not file_name.empty then
                parser.parse_file (file_name, a_table)
            end;
            file_name := user_specific;
            if file_name /= Void and then not file_name.empty then
                parser.parse_file (file_name, a_table)
            end;
            file_name := defaults_general;
            if file_name /= Void and then not file_name.empty then
                parser.parse_file (file_name, a_table)
            end;
            file_name := defaults_specific;
            if file_name /= Void and then not file_name.empty then
                parser.parse_file (file_name, a_table)
            end;
		end

feature {NONE} -- File names

	system_general: FILE_NAME is
			-- General system level resource specification file
			-- ($EIFFEL4/eifinit/application_name/general)
		do
			if Eiffel4 /= Void then
				!! Result.make_from_string (Eiffel4);
				Result.extend_from_array (<<Eifinit, application_name>>);
				Result.set_file_name (General);
				if extension /= Void then	
					Result.add_extension (extension)
				end;
			end
		end;

	system_specific: FILE_NAME is
			-- Platform specific system level resource specification file
			-- ($EIFFEL4/eifinit/application_name/spec/$PLATFORM)
		local
			fn: FILE_NAME
		do
			if Eiffel4 /= Void and Platform /= Void then
				!! Result.make_from_string (Eiffel4);
				Result.extend_from_array (<<Eifinit, application_name, Spec>>);
				Result.set_file_name (Platform);
				if extension /= Void then	
					Result.add_extension (extension)
				end;
			end
		end;

	user_general: FILE_NAME is
			-- General user level resource specification file
			-- $HOME/eifinit/application_name/general
		local
			fn: FILE_NAME
		do
			if Home /= Void then
				!! Result.make_from_string (Home);
				Result.extend (Eifinit);
				Result.extend (application_name);
				Result.set_file_name (General);
				if extension /= Void then	
					Result.add_extension (extension)
				end;
			end
		end;

	user_specific: FILE_NAME is
			-- Platform specific user level resource specification file
			-- $HOME/eifinit/application_name/spec/$PLATFORM
		do
			if Home /= Void and Platform /= Void then
				!! Result.make_from_string (Home);
				Result.extend (Eifinit);
				Result.extend (application_name);
				Result.extend (Spec);
				Result.set_file_name (Platform);
				if extension /= Void then	
					Result.add_extension (extension)
				end;
			end
		end;

	defaults_general: FILE_NAME is
			-- General user level resource specification file
			-- $EIF_DEFAULTS/application_name/general
		local
			fn: FILE_NAME
		do
			if Eifdefaults /= Void then
				!! fn.make_from_string (Eifdefaults);
				fn.extend (application_name);
				fn.set_file_name (General);
				Result := fn
			end
		end;

	defaults_specific: FILE_NAME is
			-- Platform specific user level resource specification file
			-- $EIF_DEFAULTS/application_name/spec/$PLATFORM
		local
			fn: FILE_NAME
		do
			if Eifdefaults /= Void and Platform /= Void then
				!! fn.make_from_string (Eifdefaults);
				fn.extend (application_name);
				fn.extend (Spec);
				fn.set_file_name (Platform);
				Result := fn
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

end -- class RESOURCE_FILES_PARSER

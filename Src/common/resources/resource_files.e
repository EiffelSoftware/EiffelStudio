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
			Eiffel3 := get ("EIFFEL3");
			Platform := get ("PLATFORM");
			Home := get ("HOME");
			Eifdefaults := get ("EIF_DEFAULTS")
		ensure
			application_name = new_name
		end;

feature -- File names

	system_general: STRING is
			-- General system level resource specification file
			-- ($EIFFEL3/eifinit/application_name/general)
		local
			fn: FILE_NAME
		do
			if Eiffel3 /= Void then
				!!fn.make_from_string (Eiffel3);
				fn.extend_from_array (<<Eifinit, application_name>>);
				fn.set_file_name (General);
				Result := fn
			end
		end;

	system_specific: STRING is
			-- Platform specific system level resource specification file
			-- ($EIFFEL3/eifinit/application_name/spec/$PLATFORM)
		local
			fn: FILE_NAME
		do
			if Eiffel3 /= Void and Platform /= Void then
				!!fn.make_from_string (Eiffel3);
				fn.extend_from_array (<<Eifinit, application_name, Spec>>);
				fn.set_file_name (Platform);
				Result := fn
			end
		end;

	user_general: STRING is
			-- General user level resource specification file
			-- $HOME/eifinit/application_name/general
		local
			fn: FILE_NAME
		do
			if Home /= Void then
				!! fn.make_from_string (Home);
				fn.extend (Eifinit);
				fn.extend (application_name);
				fn.set_file_name (General);
				Result := fn
			end
		end;

	user_specific: STRING is
			-- Platform specific user level resource specification file
			-- $HOME/eifinit/application_name/spec/$PLATFORM
		local
			fn: FILE_NAME
		do
			if Home /= Void and Platform /= Void then
				!!fn.make_from_string (Home);
				fn.extend (Eifinit);
				fn.extend (application_name);
				fn.extend (Spec);
				fn.set_file_name (Platform);
				Result := fn
			end
		end;

	defaults_general: STRING is
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

	defaults_specific: STRING is
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

	Eiffel3: STRING;
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

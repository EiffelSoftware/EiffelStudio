-- Resource file name server

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
			Eifdefaults := get ("EIFDEFAULTS")
		ensure
			application_name = new_name
		end;

feature -- File names

	system_general: STRING is
			-- General system level resource specification file
			-- ($EIFFEL3/defauls.eif/application_name/general)
		local
			c: CHARACTER
		do
			if Eiffel3 /= Void then
				c := Directory_separator;
				!! Result.make (30);
				Result.append (Eiffel3);
				Result.extend (c);
				Result.append ("defaults.eif");
				Result.extend (c);
				Result.append (application_name);
				Result.extend (c);
				Result.append ("general")
			end
		end;

	system_specific: STRING is
			-- Platform specific system level resource specification file
			-- ($EIFFEL3/defauls.eif/application_name/spec/$PLATFORM)
		local
			c: CHARACTER
		do
			if Eiffel3 /= Void and Platform /= Void then
				c := Directory_separator;
				!! Result.make (30);
				Result.append (Eiffel3);
				Result.extend (c);
				Result.append ("defaults.eif");
				Result.extend (c);
				Result.append (application_name);
				Result.extend (c);
				Result.append ("spec");
				Result.extend (c);
				Result.append (Platform)
			end
		end;

	user_general: STRING is
			-- General user level resource specification file
			-- ($EIFDEFAULTS/application_name/general or
			-- $HOME/defaults.eif/application_name/general)
		local
			c: CHARACTER
		do
			if Eifdefaults /= Void then
				c := Directory_separator;
				!! Result.make (30);
				Result.append (Eifdefaults);
				Result.extend (c);
				Result.append (application_name);
				Result.extend (c);
				Result.append ("general")
			elseif Home /= Void then
				c := Directory_separator;
				!! Result.make (30);
				Result.append (Home);
				Result.extend (c);
				Result.append ("defaults.eif");
				Result.extend (c);
				Result.append (application_name);
				Result.extend (c);
				Result.append ("general")
			end
		end;

	user_specific: STRING is
			-- Platform specific user level resource specification file
			-- ($EIFDEFAULTS/application_name/spec/$PLATFORM or
			-- $HOME/defaults.eif/application_name/spec/$PLATFORM)
		local
			c: CHARACTER
		do
			if Eifdefaults /= Void and Platform /= Void then
				c := Directory_separator;
				!! Result.make (30);
				Result.append (Eifdefaults);
				Result.extend (c);
				Result.append (application_name);
				Result.extend (c);
				Result.append ("spec");
				Result.extend (c);
				Result.append (Platform)
			elseif Home /= Void and Platform /= Void then
				c := Directory_separator;
				!! Result.make (30);
				Result.append (Home);
				Result.extend (c);
				Result.append ("defaults.eif");
				Result.extend (c);
				Result.append (application_name);
				Result.extend (c);
				Result.append ("spec");
				Result.extend (c);
				Result.append (Platform)
			end
		end;

feature {NONE} -- Implementation

	Eiffel3: STRING;
	Platform: STRING;
	Home: STRING;
	Eifdefaults: STRING;
			-- Environments variables

	application_name: STRING;
			-- Application name (bench, build, case, ...)

invariant

	application_name_not_void: application_name /= Void

end -- class RESOURCE_FILES

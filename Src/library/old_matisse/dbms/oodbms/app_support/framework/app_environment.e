indexing
	description: "Common access point operating environment resources.%
                     %Sources of resource settings are as follows:%
                     %	* environment variables%
                     %	* local $DEEP_HOME/xxx.cfg file%
                     %	* server host configuration server%
                     %These are all gathered at initialisation time and made available%
                     %through the app_resource_value() interface."
	keywords:    "repository"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

class APP_ENVIRONMENT

inherit
	EVENT_SEVERITY_CONSTANTS

feature --- Application Resource Configuration
	app_env_init is
		-- initialise the application environment; guarantee to set the
		-- init_status string if encountered problems
	    local
		    fname,msg,home:STRING
		    a_dir:DIRECTORY
		    cfg_name:STRING
	    do
		    -- setup command line args
		    app_exec_env.command_line.set_option_sign(app_cmd_line_option_sign)

		    -- get $DEEP_HOME value
		    home := app_exec_env.get(app_home_env_varname)

		    if home = Void then
			    app_init_fail_reason.append(app_home_env_varname) 
			    app_init_fail_reason.append(" environment variable not specified")
		    else
			    -- find $DEEP_HOME dir.
			    app_home_dir_name.copy(home)

			    -- see if home dir is a valid directory
			    !!a_dir.make_open_read(app_home_dir_name)
			    if not a_dir.exists then
				    app_init_fail_reason.append("Application HOME directory does not exist or not readable: ") 
				    app_init_fail_reason.append(app_home_dir_name)
			    else
				    -- find config file in $DEEP_HOME, defaults to current dir.
				    fname := clone(app_home_dir_name)

				    -- need a directory separator?
				    if fname.item(fname.count) /= os_directory_separator then
					fname.extend(os_directory_separator)
				    end

				    -- see if a config file name was supplied on the command line
				    cfg_name := app_exec_env.command_line.separate_word_option_value("cfg")
				    if cfg_name = Void or else cfg_name.empty then
					    cfg_name := app_default_cfg_file_name
				    end
		    
				    fname.append(cfg_name)
				    app_cfg_file_name.copy(fname)
	
				    -- read in resources
				    if not app_cfg_file.is_valid then
					    app_init_fail_reason.append(app_cfg_file.fail_reason)
				    end
			    end
		     end
	    ensure
		    Status_recorded: not app_is_valid implies app_init_fail_reason /= Void and then not app_init_fail_reason.empty
	    end

	app_home_dir_name:STRING is once !!Result.make(0) end
			-- application home directory

	app_cfg_file_name:STRING is once !!Result.make(0) end
			-- application config file full pathname

	app_resource_value(category, resource_name:STRING): STRING is
			-- get the config file resource value for resource_name, in category
		require
			Is_valid: app_is_valid
		do
			Result := app_cfg_file.resource_value(category, resource_name)
		end

	app_resource_value_list(category, resource_name:STRING):ARRAYED_LIST[STRING] is
	        -- List of items specified in .ini file setting
	        -- of the form of a comma-separated list.
	    require
	        Is_valid: app_is_valid
	    do
		Result := app_cfg_file.resource_value_list(category, resource_name)
	    end

	app_print_resources_read_list is
		-- print resources read in from .ini file on standard out.
	    require
	        Is_valid: app_is_valid
	    do
		app_cfg_file.print_resources_read_list
	    end

	app_resources_read_list:ARRAYED_LIST[STRING] is
		-- actual resources read in resource file; result in format
		-- 	category	res_name		res_val
	    require
	        Is_valid: app_is_valid
	    do
		Result := app_cfg_file.resources_read_list
	    end

	app_print_resources_requested_list is
		-- print resources requested by app on standard out.
	    require
	        Is_valid: app_is_valid
	    do
		app_cfg_file.print_resources_requested_list
	    end

	app_resources_requested_list:ARRAYED_LIST[STRING] is
		-- resources required by application; determined
		-- simply by logging all calls to app_resource_val
		-- same format as app_resources
	    require
	        Is_valid: app_is_valid
	    do
		Result := app_cfg_file.resources_requested_list
	    ensure
		Result_exists: Result /= Void
	    end

	app_default_cfg_file_name:STRING is "matisse.cfg"

	app_cmd_line_option_sign:CHARACTER is '/'

	db_trans_file_name:STRING is "_trans.dat"
			-- object type translation table for multi-reader/writer database access;
			-- will have database name prepended to it

	app_home_env_varname:STRING is "DEEP_HOME"

	app_cfg_file_cmt_char:CHARACTER is ';'

feature -- Environment Status
	app_is_valid:BOOLEAN is
	        -- if not True, look at app_init_fail_reason
	    do
	        Result := app_init_fail_reason = Void or else app_init_fail_reason.empty
	    end

	app_init_fail_reason:STRING is
 	    once
	        !!Result.make(0)
	    end

feature -- Environment Information & Facilities
	app_exec_env: EXECUTION_ENVIRONMENT is
	    once
	        !!Result
	    end

	os_directory_separator: CHARACTER is
	    once
			Result := operating_environment.directory_separator
	    end

	app_name:STRING is
	    once
			!!Result.make(0)
			Result.append(app_exec_env.command_line.argument(0).mirrored)

			if Result.has(os_directory_separator) then
			    Result.head( Result.index_of(os_directory_separator, 1)-1 )
			end

			Result.mirror
	    end

	app_cwd:STRING is
		once
			Result := app_exec_env.current_working_directory
	    end

	log_event(class_name, op_name, msg:STRING; severity:INTEGER) is
		do
			log_facility.append_event(class_name, op_name, msg, severity)
		end

feature -- Miscellaneous
        close_console:BOOLEAN is
            external
                "C | <wincon.h> , <wtypes.h>"
            alias
                "FreeConsole"
            end

feature {NONE} -- Implementation
	app_cfg_file:CONFIG_FILE_ACCESS is
		once
			!!Result.make(app_cfg_file_name)
		end

	log_facility:EVENT_LOG_FACILITY is
	    once
	        !!Result.make
	    end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,   modification   and   distribution  |
--         | permitted with this notice  intact.  Please send  |
--         | modifications  and suggestions  to  Deep Thought  |
--         | Informatics, in  the  interests  of  maintenance  |
--         | and improvement.                                  |
--         |                                                   |
--         | Use of this software is on the understanding that |
--         | the  author(s)  accept no  liability of any kind. |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+


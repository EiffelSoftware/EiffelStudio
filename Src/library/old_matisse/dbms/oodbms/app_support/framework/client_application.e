indexing
	description: "Basic template for a client application."
	keywords:    ""
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

deferred class CLIENT_APPLICATION

inherit
	MATISSE_CONST
		export
			{NONE} all
		undefine
			default_rescue
		end

	MT_EXTERNAL
		export
			{NONE} all
		undefine
			default_rescue
		end

	SHARED_ACCESS
		undefine
			default_rescue
		end

	SHARED_ODB_ACCESS
		undefine
			default_rescue
		end

	APP_ENVIRONMENT
		redefine
			default_rescue
		end

feature {NONE} -- Template
	main is
	        -- application specific instructions
	    deferred
	    end

	arch_def_init is
			-- to be overridden by different archetype creations as needed
			-- by different applications
	    do
	    end

feature -- Initialisation
	make is
		local
			an_ext_storable:EXT_STORABLE
			msg, str:STRING
			an_odb_schema:ODB_SCHEMA
		do
			-- initialise operating environment
			app_env_init

			if app_is_valid then
				debug ("app") app_print_resources_read_list end

				db_initialise
				if db_initialised then
					-- Set all EXT_STORABLE objects to use MATISSE
					!!an_ext_storable
					an_ext_storable.set_storer(matisse_storer)
			  		an_ext_storable.set_retriever(matisse_retriever)

					-- build odb schemas
					from db_sessions.start until db_sessions.off loop
						!MATISSE_SCHEMA!an_odb_schema.make(db_sessions.key_for_iteration, db_sessions.item_for_iteration)
						odb_schemas.put(an_odb_schema, db_sessions.key_for_iteration)

						debug("odb-schema")
							io.put_string(an_odb_schema.as_string)
						end
						db_sessions.forth
					end

					-- install ARCHETYPE
					arch_def_init
					archetype.initialise
		          		if archetype.is_valid then

						-- decide whether using dynamic or static REP_CLIENTs
						use_dyn_rep_clients := True
						str := app_resource_value("repository", "use_dyn_rep_clients") 
						if str /= Void and then str.is_boolean then
							use_dyn_rep_clients := str.to_boolean
						end
		    
						!!msg.make(0)
						if use_dyn_rep_clients then
							msg.append("Using DYNAMIC REP_CLIENTs")
						else
							msg.append("Using STATIC REP_CLIENTs")
						end
						log_event(generator, "main", msg, Information)

						build_rep_clients

						-- DO SOME WORK!!!!
						main

						-- STOP DOING WORK!!!
						finalise
					else
						!!msg.make(0)
						msg.append("Archetype initialisation failed; reason: ")
						msg.append(archetype.invalid_reason)
						log_event(generator, "make", msg, Error)
					end
				else
					log_event(generator, "make", "Database initialisation failed", Error)
				end
			else
				-- note: can't use event log here since APP_ENV not even valid, so
				-- don't know which event log to use.
				!!msg.make(0)
				msg.append("Application initialisation failed for the following reason: ")
				msg.append(app_init_fail_reason)
				io.put_string(msg)
			end
		end

	db_initialise is
	    do
	        create_db_sessions
			if db_initialised then
				-- see if trans_table create mode was requested on the command line
				if app_exec_env.command_line.has_word_option("trans") /= 0 then
					db_create_trans_tables
				end
				db_restore_trans_tables
			end
	    end

feature {NONE} -- Repository
	build_rep_clients is
		local
			rep_client: REP_CLIENT
			key, msg:STRING
		once
			from
				archetype.rep_units_start
			until
				archetype.rep_units_off
			loop
				-- make a repository client (this is the means of access to the repository); don't bother with subtypes
				-- since subtyped objects will be found in the parent type repository (e.g. look for a UNITISED_INVESTMENT in
				-- the INVESTMENT REP_CLIENT).

				key := archetype.rep_units_key

				if not archetype.rep_units_item.is_subtype then
					rep_client := create_rep_client(db_name_for_class(key), key)

					if archetype.rep_units_bo_desc.rep_modifiable then
						rep_client.set_modifiable
					end

					-- put the rep client in shared access 
					rep_client_put(rep_client, key)
				end
				archetype.rep_units_forth
			end    
		end

	create_rep_client(logical_db_name,item_type:STRING): REP_CLIENT is
  			-- create a REP_CLIENT object. Override with different impls as needed
			-- by 'build_rep_clients'
	    require
	        Archetype_has_type: archetype.has_type(item_type)
	    local
	        a_rep:FAST_SORTED_TWO_WAY_LIST [REP_ITEM]
	        ref_info_item : REP_ITEM
	    do
			ref_info_item ?= archetype.create_by_type(item_type)
			if use_dyn_rep_clients then
				!MAT_DYN_REP_CLIENT!Result.make(ref_info_item, logical_db_name)
			else
				!!a_rep.make
				!TEST_STAT_REP_CLIENT!Result.make(ref_info_item, a_rep.generator, a_rep)
			end
	    end

feature -- Translation Table Management
	db_restore_trans_tables is
		local
			msg:STRING
		do
			from db_sessions.start until db_sessions.off loop
				if db_sessions.item_for_iteration.trans_tbl_exists then
					db_sessions.item_for_iteration.trans_tbl_restore
				else
					!!msg.make(0) 
					msg.append("file ") msg.append(db_sessions.item_for_iteration.trans_tbl_filename)
					msg.append(" does not exist")
					log_event(generator, "db_restore_trans_tables", msg, Error)
					db_initialised := False
				end
				db_sessions.forth
			end
		end

	db_create_trans_tables is
			-- one-off create of translation tables for subsequent use; 
			-- use "/trans" on command-line to get this effect
		local
			msg:STRING
		do
			-- create all tables as if all dbs were being written to by this application
			from db_sessions.start until db_sessions.off loop
				db_sessions.item_for_iteration.trans_tbl_create
				if db_sessions.item_for_iteration.trans_tbl_exists then
					!!msg.make(0)
					msg.append("file ") msg.append(db_sessions.item_for_iteration.trans_tbl_filename)
					msg.append(" created")
					log_event(generator, "db_create_trans_tables", msg, Information)
				else
					!!msg.make(0)
					msg.append("file ") msg.append(db_sessions.item_for_iteration.trans_tbl_filename)
					msg.append(" creation failed")
					log_event(generator, "db_create_trans_tables", msg, Error)
					db_initialised := False
				end
				db_sessions.forth
			end
		end

feature -- Session Management
	create_db_sessions is
	        -- Template database initialisation to be overridden as necessary
	    local
			msg:STRING
			db_hostname, db_phys_db_name:STRING
			db_list:ARRAYED_LIST[STRING]
			res_name:STRING
	    do
			db_initialised := True

			db_hostname := app_resource_value("database", "matisse_hostname")
			if db_hostname.empty then
				!!msg.make(0)
				msg.append("No hostname specified in ") msg.append(App_cfg_file_name)
				msg.append(" (matisse_hostname resource in [database])")
				log_event(generator, "create_db_sessions", msg, Error)
				db_initialised := False
			else
				-- determine the list of logical database names to use
				db_list := app_resource_value_list("database", "matisse_logical_databases")
				from db_list.start until db_list.off loop
					res_name := "matisse_"
					res_name.append(db_list.item)
					res_name.append("_database")

					db_phys_db_name := app_resource_value("database", res_name)

					if db_phys_db_name.empty then
						!!msg.make(0)
						msg.append("No physical db specified in ") msg.append(App_cfg_file_name)
						msg.append(" (matisse_") msg.append(db_list.item) msg.append("_database resource in [database])")
						msg.append(" for logical db ") msg.append(db_list.item)
						log_event(generator, "create_db_sessions", msg, Error)
						db_initialised := False
					else
						db_create_session(db_list.item, db_hostname, db_phys_db_name)
						if not db_sessions.has(db_list.item) or else not db_sessions.item(db_list.item).is_ok then
							!!msg.make(0)
							msg.append("Session establishment failed for physical db ") msg.append(db_phys_db_name)
							log_event(generator, "create_db_sessions", msg, Error)
							db_initialised := False
						end
					end

					db_list.forth
				end
			end
	    end

	db_create_session(logical_db_name, db_hostname, phys_db_name:STRING) is
	    require
	        Valid_logical_db_name: logical_db_name /= Void and then not logical_db_name.empty
	        Valid_db_hostname: db_hostname /= Void and then not db_hostname.empty
	        Valid_phys_db_name: phys_db_name /= Void and then not phys_db_name.empty
	    local
			pmsg, msg, fn:STRING
			a_server:MATISSE_APPL
			a_session:DB_CONTROL
			priority, wait_time:INTEGER
			priority_str, wait_time_str:STRING
	    do
			-- get priority and wait from ini file or else use defaults
			!!pmsg.make(0) 
			priority_str := app_resource_value("database", "priority")
			if not priority_str.empty and then priority_str.is_integer then
				priority := priority_str.to_integer
				pmsg.append("Using priority ") pmsg.append_integer(priority)
			else
				priority := default_priority
				pmsg.append("Using default priority ") pmsg.append_integer(default_priority)
			end
			pmsg.append("; ")

			wait_time_str := app_resource_value("database", "wait_time")
			if not wait_time_str.empty and then wait_time_str.is_integer then
				wait_time := wait_time_str.to_integer
				pmsg.append("Using wait_time ") pmsg.append_integer(wait_time)
			else
				wait_time := default_wait_time
				pmsg.append("Using default wait_time ") pmsg.append_integer(default_wait_time)
			end

			-- 1/ Choose host name and database name. Adjust wait and priority so that it suits your needs.
			!!a_server.login(db_hostname, phys_db_name, priority, wait_time)
			if a_server.is_logged_to_base then
				!!msg.make(0) 
				msg.append("Logged in to db ") msg.append(phys_db_name) msg.append(" on server ") msg.append(db_hostname)
				msg.append("; ") msg.append(pmsg)
				log_event(generator, "db_create_session", msg, Information)

				-- 2/ Choose working mode. See documentation for that.
				a_server.set_mode(VERSION_ACCESS,Void)
	
				!!msg.make(0) msg.append("Set DB mode to VERSION_ACCESS")
				log_event(generator, "db_create_session", msg, Information)

				-- 3/ Connect Matisse handle to EiffelStore.
				a_server.set_base

				-- 4/ Create a Matisse session.
				!!a_session.make
		
				-- 5/ Connect to database with the appropriate mode (given above).
				a_session.connect

				if not a_session.is_ok then
					!!msg.make(0) msg.append("Failed to connect session ") msg.append(phys_db_name)
					msg.append(" on server ") msg.append(db_hostname) msg.append("; reason: ") msg.append(a_session.error_message)
					log_event(generator, "db_create_session", msg, Error)
				elseif not c_admin_sts_success then
					!!msg.make(0) msg.append("Failed to make admin connection to ") msg.append(phys_db_name)
					msg.append(" on server ") msg.append(db_hostname) msg.append("; reason: ") msg.append(admin_sts_msg)
					log_event(generator, "db_create_session", msg, Error)
				else
					-- 6/ Insert your actions here.

					-- initialise filename for this database's object type translation table
					fn := clone(app_home_dir_name)
					fn.append_character(os_directory_separator) fn.append(phys_db_name) fn.append(db_trans_file_name)
					a_session.trans_tbl_make(fn)

					-- put the session and server in the access tables
					db_servers.put(a_server, logical_db_name)
					db_sessions.put(a_session, logical_db_name)
				end
			else
				!!msg.make(0) msg.append("Failed to logon to db ") msg.append(phys_db_name)
				msg.append(" on server ") msg.append(db_hostname)
				log_event(generator, "db_create_session", msg, Error)
		    end
	    end

	log_session_info is
		local
			db_info:MT_INFO
			msg:STRING
		do
			!!db_info
			!!msg.make(0) msg.append("Max buffered objects: ") msg.append_integer(db_info.max_buffered_objects)
			log_event(generator, "db_create_session", msg, Information)
			!!msg.make(0) msg.append("Max index criteria number: ") msg.append_integer(db_info.max_index_criteria_number)
			log_event(generator, "db_create_session", msg, Information)
			!!msg.make(0) msg.append("Max index key_length: ") msg.append_integer(db_info.max_index_key_length)
			log_event(generator, "db_create_session", msg, Information)
			!!msg.make(0) msg.append("Total read bytes: ") msg.append_integer(db_info.total_read_bytes)
			log_event(generator, "db_create_session", msg, Information)
			!!msg.make(0) msg.append("Total write bytes: ") msg.append_integer(db_info.total_write_bytes)
			log_event(generator, "db_create_session", msg, Information)
		end


feature -- Finalisation
	finalise is
	    do
			db_finalise
	    end

	db_finalise is
	    local
	        msg:STRING
	    do
	        !!msg.make(0)

		    --7/ Disconnect from database.
		    from db_sessions.start until db_sessions.off loop
				if db_sessions.item_for_iteration.is_connected then
					db_sessions.item_for_iteration.disconnect
					msg.append("Session for ") msg.append(db_sessions.key_for_iteration) msg.append(" disconnected")
					log_event(generator, "db_finalise", msg, Information)
				end
				db_sessions.forth
		    end
	    end

feature -- Basic operations
	default_rescue is
		do
			finalise
		end

feature {NONE} -- Database connection
	use_dyn_rep_clients:BOOLEAN

	default_priority:INTEGER is 1
			-- should be between 0 and 3 (no Eiffel interface to these consts)

	default_wait_time:INTEGER is 5
			-- seconds to wait to obtain a lock

feature -- Application Status
	db_initialised:BOOLEAN
	spec_initialised:BOOLEAN

feature {NONE} -- Implementation
	matisse_storer:MATISSE_STORER is once !!Result end
	matisse_retriever:MATISSE_RETRIEVER is once !!Result end

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


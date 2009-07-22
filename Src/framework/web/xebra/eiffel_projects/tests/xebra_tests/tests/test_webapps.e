note
	description: "[
		Test class for webapp testing
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WEBAPPS

inherit
	XS_SHARED_SERVER_CONFIG
	EQA_TEST_SET

feature -- Test routines

	test_demoapplication
			-- Tests demoapplication
		do
			internal_test ("demoapplication")
		end

	test_helloworld
			-- Tests helloworld
		do
			internal_test ("helloworld")
		end

	test_xebrahome
			-- Tests xebrahome
		do
			internal_test ("xebrahome")
		end

	test_support
			-- Tests support
		do
			internal_test ("support")
		end

	test_servercontrol
			-- Tests servercontrol
		do
			internal_test ("servercontrol")
		end

	test_xmlrpc_demo
			-- Tests xmlrpc_demo
		do
			internal_test ("xmlrpc_demo")
		end

feature {NONE} -- Internal

	internal_test (a_webapp_name: STRING)
			-- Tests translation and compilation of 'webapp_name'
		require
			not_a_webapp_name_is_detached_or_empty: a_webapp_name /= Void and then not a_webapp_name.is_empty
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_webapp_finder: XS_WEBAPP_FINDER
			l_config_reader: XS_CONFIG_READER
			l_ee: EXECUTION_ENVIRONMENT
			l_f_utils: XU_FILE_UTILITIES
			l_exp: STRING_AGENT_EXPANDER
			ok: BOOLEAN
		do
			ok := True
			create l_exp
			create l_f_utils
			create l_ee

				-- Create fake server run arguments
			config.args.set_assume_webapps_are_running (False)
			config.args.set_clean (False)
			config.args.set_debug_level (9)
			if (create {PLATFORM}).is_windows then
					config.args.set_config_filename ( l_f_utils.resolve_env_vars ("$XEBRA_DEV\eiffel_projects\xebra_server\config.ini", False))
			else
				config.args.set_config_filename ( l_f_utils.resolve_env_vars ("$XEBRA_DEV/eiffel_projects/xebra_server/config.ini", False))
			end


				-- Read config file
			create l_config_reader.make
			if attached {XS_FILE_CONFIG} l_config_reader.process_file (config.args.config_filename) as l_config then
				config.file := l_config
				create l_webapp_finder.make
				config.file.set_webapps (l_webapp_finder.search_webapps (config.file.webapps_root))
				if attached {XS_WEBAPP} l_config.webapps [a_webapp_name] as l_webapp then

						--De-chain actions
					l_webapp.action_translate.set_next_action (Void)
					l_webapp.action_compile_sgen.set_next_action (Void)
					l_webapp.action_compile_webapp.set_next_action (Void)
					l_webapp.action_generate.set_next_action (Void)

						-- Translate
					if ok then
						l_webapp.action_translate.set_force (True)
						l_webapp.action_translate.internal_execute.do_nothing

						if attached l_webapp.action_translate.translate_process as l_process then
							l_process.wait_for_exit
						else
							ok := False
						end
						ok := not l_webapp.action_translate.is_necessary
						assert ( "Translation of " + a_webapp_name, ok)
					end

						-- Compile sgen
					if ok then
						l_webapp.action_compile_sgen.internal_execute.do_nothing
						if attached l_webapp.action_compile_sgen.gen_compile_process as l_process then
							l_process.wait_for_exit
						else
							ok := False
						end
						ok := not l_webapp.action_compile_sgen.is_necessary
						assert ( "Compilation Servlet_gen of " + a_webapp_name, ok)
					end

						-- Generate
					if ok then
						l_webapp.action_generate.internal_execute.do_nothing
						if attached l_webapp.action_generate.generate_process as l_process then
							l_process.wait_for_exit
						else
							ok := False
						end
						ok := not l_webapp.action_generate.is_necessary
						assert ( "Generation  of " + a_webapp_name, ok)
					end

						-- Compile webapp
					if ok then
						l_webapp.action_compile_webapp.internal_execute.do_nothing
						if attached l_webapp.action_compile_webapp.compile_process as l_process then
							l_process.wait_for_exit
						else
							ok := False
						end
						ok := not l_webapp.action_compile_webapp.is_necessary
						assert ( "Compilation webapp  of " + a_webapp_name, ok)
					end
				end
			else
				assert ("Could not process config.ini file", False)
			end
		end
end

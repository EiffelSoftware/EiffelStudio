note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WEBAPPS

inherit
	EQA_TEST_SET
	XS_SHARED_SERVER_CONFIG

feature -- Test routines

	test_all_webapps
			--
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_webapp_finder: XS_WEBAPP_FINDER
			l_config_reader: XS_CONFIG_READER
			l_ee: EXECUTION_ENVIRONMENT
			l_exp: STRING_AGENT_EXPANDER
		do
			create l_exp
			print ("%N%N%N%N=========================================STARTING NEW TEST========")

			create l_ee
			config.args.set_assume_webapps_are_running (False)
			config.args.set_clean (False)
			config.args.set_debug_level (6)
			config.args.set_config_filename ( l_exp.expand_string ("$XEBRA_DEV/eiffel_projects/xebra_server/config.ini", replacer, True))




			create l_config_reader.make
			if attached {XS_FILE_CONFIG} l_config_reader.process_file (config.args.config_filename) as l_config then
				config.file := l_config
				create l_webapp_finder.make
				config.file.set_webapps (l_webapp_finder.search_webapps (config.file.webapps_root))

				from
					l_config.webapps.start
				until
					l_config.webapps.after
				loop

					l_config.webapps.item_for_iteration.force_translate
					l_config.webapps.item_for_iteration.translate_action.translate_process.wait_for_exit

					if l_config.webapps.item_for_iteration.translate_action.output_handler_translate.has_successfully_terminated then

						l_config.webapps.item_for_iteration.translate_action.gen_compile_process.wait_for_exit

						if l_config.webapps.item_for_iteration.translate_action.output_handler_compile.has_successfully_terminated then

							l_config.webapps.item_for_iteration.translate_action.generate_process.wait_for_exit

							if l_config.webapps.item_for_iteration.translate_action.output_handler_gen.has_successfully_terminated then

								l_config.webapps.item_for_iteration.compile_action.compile_process.wait_for_exit

								if l_config.webapps.item_for_iteration.compile_action.output_handler.has_successfully_terminated then

									l_ee.sleep (5000000000)
									l_config.webapps.item_for_iteration.shutdown_all
								else
									assert ("Webapp Compile Failed", False)
								end
							else
								assert ("Generation Failed", False)
							end
						else
							assert ("Gen Compile Failed", False)
						end
					else
						assert ("Translation Failed", False)
					end
					l_config.webapps.forth
				end

			else
				assert ("Could not process config.ini file", False)
			end

		end
feature {NONE} -- Internal

	replacer: FUNCTION [ANY, TUPLE [READABLE_STRING_8], detachable STRING]
			-- Converts get from EXECUTION_ENVIRONMENT to be usable by string expander
		once
			Result := agent (ia_exec: EXECUTION_ENVIRONMENT; a_name: READABLE_STRING_8): STRING
				do
					Result := ia_exec.get (a_name.as_string_8)
				end (create {EXECUTION_ENVIRONMENT}, ?)
		end

end

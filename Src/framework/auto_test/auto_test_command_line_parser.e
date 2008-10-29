indexing

	description:

		"AutoTest command line parser"

	copyright: "Copyright (c) 2004-2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUTO_TEST_COMMAND_LINE_PARSER

inherit

	AUT_SHARED_RANDOM

	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

feature -- Status report

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	output_dirname: STRING
			-- Name of output directory

	ecf_filename: STRING
			-- Name of ecf file of input system

--	ecf_target: STRING
--			-- Name of target in file named `ecf_filename'; Void if no target was specified.

	class_names: DS_LINKED_LIST [STRING]
			-- List of class names to be tested

	time_out: DT_DATE_TIME_DURATION
			-- Maximal time to test;
			-- A timeout value of `0' means no time out.

	is_debug_mode_enabled: BOOLEAN
			-- Should the interpreter runtime be compiled with
			-- assertion checking on?

	just_test: BOOLEAN
			-- Should generation and compilation of the interpreter be skipped

	is_deep_relevancy_enabled: BOOLEAN
			-- Should the manual testing strategy use deep dependence
			-- checking when locating relevant manual unit tests?

	is_manual_testing_enabled: BOOLEAN
			-- Should the manual testing strategy be used?

	is_automatic_testing_enabled: BOOLEAN
			-- Should the automatic testing strategy be used?

	is_minimization_enabled: BOOLEAN
			-- Should bug reproducing examples be minimized?

	is_text_statistics_format_enabled: BOOLEAN
			-- Should statistics be output as plain text?

	is_html_statistics_format_enabled: BOOLEAN
			-- Should statistics be output static HTML?

	is_slicing_enabled: BOOLEAN
			-- Should test cases be minimized via slicing?

	is_ddmin_enabled: BOOLEAN
			-- Should test cases be minimized via ddmin?

	proxy_time_out: INTEGER
			-- Proxy time out in second

	is_replay_enabled: BOOLEAN
			-- Is log replay specified?

	log_to_replay: STRING
			-- File name of the log to be replayed.

	should_display_help_message: BOOLEAN
			-- Should help message be displayed?

	help_message: STRING
			-- Help message for command line arguments
			-- This value is only set if help option presents.

feature -- Parsing

	process_arguments (a_arguments: DS_LIST [STRING]) is
			-- Process `a_arguments'.
		require
			a_arguments_attached: a_arguments /= Void
			error_hanlder_not_void: error_handler /= Void
		local
			parser: AP_PARSER
			version_option: AP_FLAG
			quiet_option: AP_FLAG
			just_test_option: AP_FLAG
--			ecf_target_option: AP_STRING_OPTION
			deep_manual_option: AP_FLAG
			disable_manual_option: AP_FLAG
			disable_auto_option: AP_FLAG
			benchmark_option: AP_FLAG
			disable_minimize_option: AP_FLAG
			minimize_option: AP_STRING_OPTION
			finalize_option: AP_FLAG
			output_dir_option: AP_STRING_OPTION
			time_out_option: AP_INTEGER_OPTION
			seed_option: AP_INTEGER_OPTION
			statistics_format_op: AP_STRING_OPTION
			cs: DS_LINEAR_CURSOR [STRING]
			time: TIME
			proxy_time_out_option: AP_INTEGER_OPTION
			l_log_to_replay: AP_STRING_OPTION
			l_help_option: AP_FLAG
			l_help_flag: AP_DISPLAY_HELP_FLAG
		do
			create parser.make_empty
			parser.set_application_description ("auto_test is a contract-based automated testing tool for Eiffel systems.")
			parser.set_parameters_description ("class-name+")

			create version_option.make ('V', "version")
			version_option.set_description ("Output version information and exit")
			parser.options.force_last (version_option)

			create quiet_option.make ('q', "quiet")
			quiet_option.set_description ("Be quiet.")
			parser.options.force_last (quiet_option)

			create just_test_option.make ('j', "just-test")
			just_test_option.set_description ("Skip compilation and generation of interpreter and go right to testing.")
			parser.options.force_last (just_test_option)

--			create ecf_target_option.make ('r', "target")
--			ecf_target_option.set_description ("Target (from supplied ECF file) that should be used for testing.")
--			parser.options.force_last (ecf_target_option)

			create deep_manual_option.make ('d', "deep-manual")
			deep_manual_option.set_description ("Enable deep relevancy check for manual strategy.")
			parser.options.force_last (deep_manual_option)

			create disable_manual_option.make ('m', "disable-manual")
			disable_manual_option.set_description ("Disable manual testing strategy.")
			parser.options.force_last (disable_manual_option)

			create disable_auto_option.make ('a', "disable-auto")
			disable_auto_option.set_description ("Disable automated testing strategy.")
			parser.options.force_last (disable_auto_option)

			create benchmark_option.make ('k', "benchmark")
			benchmark_option.set_description ("Log timeing information (usefull for assessing efficiency).")
			parser.options.force_last (benchmark_option)

			create disable_minimize_option.make ('i', "disable-minimize")
			disable_minimize_option.set_description ("Disable minimize testing strategy.")
			parser.options.force_last (disable_minimize_option)

			create minimize_option.make ('n', "minimize")
			minimize_option.set_description ("Minimize with a certain algorithm.")
			parser.options.force_last (minimize_option)

			create finalize_option.make ('f', "finalize")
			finalize_option.set_description ("Use finalized intepreter. (Better performance, but no melting)")
			parser.options.force_last (finalize_option)

			create output_dir_option.make ('o', "output-dir")
			output_dir_option.set_description ("Output directory for reflection library")
			parser.options.force_last (output_dir_option)

			create time_out_option.make ('t', "time-out")
			time_out_option.set_description ("Time used for testing (in minutes). Default is 15 minutes.")
			parser.options.force_last (time_out_option)

			create seed_option.make ('e', "seed")
			seed_option.set_description ("Integer seed to initialize pseudo-random number generation with. If not specified seed is intialized with current time.")
			parser.options.force_last (seed_option)

			create statistics_format_op.make ('s', "stat-format")
			statistics_format_op.set_description ("Format in which to output statistics. Possibilities are 'html' and 'text'. Default is 'html'.")
			parser.options.force_last (statistics_format_op)

			create proxy_time_out_option.make ('x', "proxy-time-out")
			proxy_time_out_option.set_description ("Time in seconds used by proxy to wait for a feature to execute. Default is 5.")
			parser.options.force_last (proxy_time_out_option)

			create l_log_to_replay.make ('l', "log")
			l_log_to_replay.set_description ("Log file to be replayed. All the test cases in the given log file will be replayed.")
			parser.options.force_last (l_log_to_replay)

			create l_help_option.make ('h', "help")
			l_help_option.set_description ("Display this help message.")
			parser.options.force_last (l_help_option)

			parser.parse_list (a_arguments)

			if version_option.was_found then
				error_handler.enable_verbose
				error_handler.report_version_message
				error_handler.disable_verbose
				Exceptions.die (0)
			end

			if not quiet_option.was_found then
				error_handler.enable_verbose
			end

			just_test := just_test_option.was_found

--			if ecf_target_option.was_found then
--				ecf_target := ecf_target_option.parameter
--			end

			is_manual_testing_enabled := not disable_manual_option.was_found
			is_deep_relevancy_enabled := deep_manual_option.was_found
			is_automatic_testing_enabled := not disable_auto_option.was_found
			is_minimization_enabled := not disable_minimize_option.was_found
			is_debug_mode_enabled := not finalize_option.was_found

			if benchmark_option.was_found then
				error_handler.enable_benchmarking
			end

			if is_minimization_enabled then
				if minimize_option.was_found then
					if minimize_option.parameter.is_equal ("slice") then
						is_slicing_enabled := True
					elseif minimize_option.parameter.is_equal ("ddmin") then
						is_ddmin_enabled := True
					elseif minimize_option.parameter.is_equal ("slice,ddmin") then
						is_slicing_enabled := True
						is_ddmin_enabled := True
					else
						error_handler.report_invalid_minimization_algorithm (minimize_option.parameter)
						Exceptions.die (1)

					end
				else
					is_slicing_enabled := True -- Default
				end
			else
				if minimize_option.was_found then
					error_handler.report_cannot_specify_both_disable_minimze_and_minimize
					Exceptions.die (1)
				end
			end

			if output_dir_option.was_found then
				output_dirname := output_dir_option.parameter
			end

			if time_out_option.was_found then
				create time_out.make (0, 0 ,0, 0, time_out_option.parameter, 0)
			end

			if seed_option.was_found then
				random.set_seed (seed_option.parameter)
			else
				create time.make_now
				random.set_seed (time.milli_second)
			end

			if statistics_format_op.was_found then
				if statistics_format_op.parameter.is_equal ("text") then
					is_text_statistics_format_enabled := True
				elseif statistics_format_op.parameter.is_equal ("html") then
					is_html_statistics_format_enabled := True
				else
					error_handler.report_statistics_format_error (statistics_format_op.parameter)
					Exceptions.die (1)
				end
			else
				is_html_statistics_format_enabled := True
				is_text_statistics_format_enabled := True
			end

			if proxy_time_out_option.was_found then
				proxy_time_out := proxy_time_out_option.parameter
			end

			if l_log_to_replay.was_found then
				is_replay_enabled := True
				log_to_replay := l_log_to_replay.parameter.twin
			end

			should_display_help_message := l_help_option.was_found
			if should_display_help_message then
				create l_help_flag.make_with_short_form ('h')
				help_message := l_help_flag.full_help_text (parser)
			end

--			if parser.parameters.count = 0 then
--				error_handler.report_missing_ecf_filename_error
--				-- TODO: Display usage_instruction (currently not exported, find better way to do it.)
--				-- error_handler.report_info_message (parser.help_option.usage_instruction (parser))
--				Exceptions.die (1)
--			else
--				ecf_filename := parser.parameters.first
				create class_names.make
				from
					cs := parser.parameters.new_cursor
					cs.start
--					cs.forth
				until
					cs.off
				loop
					class_names.force_last (cs.item)
					cs.forth
				end
--			end
		ensure
			help_message_set_when_required: should_display_help_message implies help_message /= Void
		end

invariant
	minimization_is_either_slicing_or_ddmin: is_minimization_enabled implies (is_slicing_enabled xor is_ddmin_enabled)

end

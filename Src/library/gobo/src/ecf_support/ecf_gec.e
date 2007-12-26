indexing
	description: "Gobo Eiffel Compiler with ECF support."
	copyright: "Copyright (c) 2005-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ECF_GEC

inherit
	GEC
		redefine
			parse_ecf_file,
			parse_arguments
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

create
	execute

feature -- Access

	ecf_target: STRING is
			-- Target if any specified.
		do
			if target_option.was_found then
				Result := target_option.parameter
			end
		end

feature {NONE} -- Eiffel config file parsing

	parse_ecf_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Read ECF file `a_file'.
			-- Put result in `last_universe' if no error occurred.
		local
			a_ecf_parser: ET_ECF_PARSER
		do
			check_environment_variable
			set_precompile (False)
			last_universe := Void
			create a_ecf_parser.make_standard
			if ecf_target /= Void then
				a_ecf_parser.set_target (ecf_target)
			end
			a_ecf_parser.load (a_file.name)
			if not a_ecf_parser.is_error then
				last_universe := a_ecf_parser.last_universe
			end
		end

feature {NONE} -- Arguments

	target_option: AP_STRING_OPTION
			-- Flag for '--target'

	parse_arguments is
			-- Initialize options and parse the command line.
		local
			a_parser: AP_PARSER
			a_list: AP_ALTERNATIVE_OPTIONS_LIST
			an_error: AP_ERROR
		do
			create a_parser.make
			a_parser.set_application_description ("Gobo Eiffel Compiler, translate Eiffel programs into C code.")
			a_parser.set_parameters_description ("ace_filename")
				-- Options.
			create finalize_flag.make_with_long_form ("finalize")
			finalize_flag.set_description ("Compile with optimizations turned on.")
			a_parser.options.force_last (finalize_flag)
				-- cat
			create cat_flag.make_with_long_form ("cat")
			cat_flag.set_description ("CAT-call errors should be considered as fatal errors.")
			a_parser.options.force_last (cat_flag)
				-- cc
			create c_compile_option.make_with_long_form ("cc")
			c_compile_option.set_description ("Should the back-end C compiler be invoked on the generated C code? (default: yes)")
			c_compile_option.set_parameter_description ("no|yes")
			a_parser.options.force_last (c_compile_option)
				-- split
			create split_option.make_with_long_form ("split")
			split_option.set_description ("Should generated C code be split over several C files instead of being held in a single possibly large C file? (default: yes)")
			split_option.set_parameter_description ("no|yes")
			a_parser.options.force_last (split_option)
				-- split-size
			create split_size_option.make_with_long_form ("split-size")
			split_size_option.set_description ("Size of generated C files in bytes when in split mode.")
			split_size_option.set_parameter_description ("size")
			a_parser.options.force_last (split_size_option)
				-- gc
			create gc_option.make_with_long_form ("gc")
			gc_option.set_description ("Which garbage collector should the application be compiled with? (default: no)")
			gc_option.extend ("no")
			gc_option.extend ("boehm")
			gc_option.set_parameter_description ("no|boehm")
			a_parser.options.force_last (gc_option)
				-- silent
			create silent_flag.make_with_long_form ("silent")
			silent_flag.set_description ("Run gec in silent mode.")
			a_parser.options.force_last (silent_flag)
				-- verbose
			create verbose_flag.make_with_long_form ("verbose")
			verbose_flag.set_description ("Run gec in verbose mode.")
			a_parser.options.force_last (verbose_flag)
				-- version
			create version_flag.make ('V', "version")
			version_flag.set_description ("Print the version number of gec and exit.")
			create a_list.make (version_flag)
			a_parser.alternative_options_lists.force_last (a_list)
				-- target
			create target_option.make_with_long_form ("target")
			target_option.set_description ("Specify an ECF target.")
			a_parser.options.force_last (target_option)
				-- Parsing.
			a_parser.parse_arguments
			if version_flag.was_found then
				report_version_number
				Exceptions.die (0)
			elseif a_parser.parameters.count /= 1 then
				error_handler.report_info_message (a_parser.help_option.full_usage_instruction (a_parser))
				Exceptions.die (1)
			else
				ace_filename := a_parser.parameters.first
			end
			if split_size_option.was_found then
				if split_size_option.parameter > 0 then
					split_size := split_size_option.parameter
				else
					create an_error.make_invalid_parameter_error (split_size_option, split_size_option.parameter.out)
					error_handler.report_error (an_error)
					Exceptions.die (1)
				end
			end
		end

	application_name: STRING is "ec"
			-- Application name of estudio (for EIFFEL_ENV),
			-- to find right right keys in the registry

end

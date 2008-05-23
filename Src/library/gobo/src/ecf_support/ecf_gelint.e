indexing
	description: "Gobo Eiffel Lint modified for support of ECF."
	copyright: "Copyright (c) 1999-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ECF_GELINT

inherit
	GELINT
		redefine
			parse_ecf_file,
			execute,
			usage_message
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

create
	execute

feature -- Execution

	execute is
			-- Start 'gelint' execution.
		local
			a_filename: STRING
			a_file: KL_TEXT_INPUT_FILE
			i, nb: INTEGER
			arg: STRING
			a_ise_version: STRING
			a_ise_regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			Arguments.set_program_name ("gelint")
			create error_handler.make_standard
			is_flat_dbc := True
			nb := Arguments.argument_count
			from i := 1 until i > nb loop
				arg := Arguments.argument (i)
				if arg.is_equal ("-V") or arg.is_equal ("--version") then
					report_version_number
					Exceptions.die (0)
				elseif arg.is_equal ("-h") or arg.is_equal ("-?") or arg.is_equal ("--help") then
					report_usage_message
					Exceptions.die (0)
				elseif arg.count > 9 and then arg.substring (1, 9).is_equal ("--define=") then
					defined_variables := arg.substring (10, arg.count)
				elseif arg.is_equal ("--verbose") then
					is_verbose := True
				elseif arg.is_equal ("--flat") then
					is_flat := True
				elseif arg.is_equal ("--noflatdbc") then
					is_flat_dbc := False
				elseif arg.is_equal ("--catcall") then
					is_catcall := True
				elseif arg.is_equal ("--silent") then
					is_silent := True
				elseif arg.is_equal ("--ecma") then
					ecma_version := ecma_367_latest
				elseif arg.is_equal ("--ise") then
					ise_version := ise_latest
				elseif arg.count > 6 and then arg.substring (1, 6).is_equal ("--ise=") then
					a_ise_version := arg.substring (7, arg.count)
					create a_ise_regexp.make
					a_ise_regexp.compile ("([0-9]+)(\.([0-9]+))?(\.([0-9]+))?(\.([0-9]+))?")
					if a_ise_regexp.recognizes (a_ise_version) then
						inspect a_ise_regexp.match_count
						when 2 then
							create ise_version.make_major (a_ise_regexp.captured_substring (1).to_integer)
						when 4 then
							create ise_version.make_major_minor (a_ise_regexp.captured_substring (1).to_integer, a_ise_regexp.captured_substring (3).to_integer)
						when 6 then
							create ise_version.make (a_ise_regexp.captured_substring (1).to_integer, a_ise_regexp.captured_substring (3).to_integer, a_ise_regexp.captured_substring (5).to_integer, 0)
						when 8 then
							create ise_version.make (a_ise_regexp.captured_substring (1).to_integer, a_ise_regexp.captured_substring (3).to_integer, a_ise_regexp.captured_substring (5).to_integer, a_ise_regexp.captured_substring (7).to_integer)
						else
							report_usage_message
							Exceptions.die (1)
						end
					else
						report_usage_message
						Exceptions.die (1)
					end
				elseif arg.count > 9 and then arg.substring (1,9).is_equal ("--target=") then
					ecf_target := arg.substring (10, arg.count)
				elseif i = nb then
					a_filename := arg
				else
					report_usage_message
					Exceptions.die (1)
				end
				i := i + 1
			end
			if a_filename = Void then
				report_usage_message
				Exceptions.die (1)
			else
				create a_file.make (a_filename)
				a_file.open_read
				if a_file.is_open_read then
					last_system := Void
					nb := a_filename.count
					if nb > 5 and then a_filename.substring (nb - 4, nb).is_equal (".xace") then
						parse_xace_file (a_file)
					elseif nb > 4 and then a_filename.substring (nb - 3, nb).is_equal (".ecf") then
						parse_ecf_file (a_file)
					else
						parse_ace_file (a_file)
					end
					a_file.close
					if last_system /= Void then
						process_system (last_system)
						debug ("stop")
							std.output.put_line ("Press Enter...")
							io.read_line
						end
						if last_system.error_handler.has_eiffel_error then
							Exceptions.die (2)
						elseif last_system.error_handler.has_internal_error then
							Exceptions.die (5)
						end
					else
						Exceptions.die (3)
					end
				else
					report_cannot_read_error (a_filename)
					Exceptions.die (1)
				end
			end
		rescue
			Exceptions.die (4)
		end

feature -- Access

	ecf_target: STRING
			-- Target of ECF to compiler if any.

feature {NONE} -- Eiffel config file parsing

	parse_ecf_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Read ECF file `a_file'.
			-- Put result in `last_system' if no error occurred.
		local
			a_ecf_parser: ET_ECF_PARSER
		do
			check_environment_variable
			set_precompile (False)
			last_system := Void
			create a_ecf_parser.make_standard
			if ecf_target /= Void then
				a_ecf_parser.set_target (ecf_target)
			end
			a_ecf_parser.load (a_file.name)
			if not a_ecf_parser.is_error then
				last_system := a_ecf_parser.last_universe
			end
		end

	Usage_message: UT_USAGE_MESSAGE is
			-- Gelint usage message.
		once
			create Result.make ("[--ecma][--ise[=major[.minor[.revision[.build]]]]][--define=variables]%N%
				%%T[--flat][--noflatdbc][--cat][--void][--silent][--verbose][--target=ecf-target] ace_filename")
		end

	application_name: STRING is "ec"
			-- Application name of estudio (for EIFFEL_ENV),
			-- to find right right keys in the registry

invariant
	error_handler_not_void: error_handler /= Void

end

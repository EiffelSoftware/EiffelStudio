note
	description: "[
			Container for program options
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	OPTIONS

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- New instance.
		do
			create archive_name.make_empty
			create file_list.make_empty
			absolute_paths_enabled := False
			mode := mode_usage
		end

feature -- Mode

	mode: INTEGER
			-- Program mode.

	absolute_paths_enabled: BOOLEAN
			-- Keep absolute paths?

	archive_name: IMMUTABLE_STRING_32
			-- archive name.

	file_list: ARRAY [IMMUTABLE_STRING_32]
			-- given files.

feature -- Mode: constants

	mode_usage: INTEGER = 0
			-- Usage printing.

	mode_list: INTEGER = 1
			-- List archive contents.

	mode_unarchive: INTEGER = 2
			-- Unarchive given archive.

	mode_archive: INTEGER = 3
			-- Archive given files.		

feature -- Parsing

	parse (args: ARGUMENTS_32)
			-- Parse `args'.
		local
			i, n: INTEGER
			arg,arg_next: READABLE_STRING_32
			optional_args_finished: BOOLEAN
		do
				-- optional arguments
			from
				n := args.argument_count
				i := 1
				optional_args_finished := False
			until
				i > n or optional_args_finished
			loop
				arg := args.argument (i)
				if arg.same_string_general ("-A") then
					absolute_paths_enabled := True
				else
					optional_args_finished := True
				end
				i := i + 1
			end

			if optional_args_finished then
				i := i - 1
			end

				-- Now for the remaining arguments
			arg := args.argument (i)
			if n - i = 1 and then arg.same_string_general ("-f") then
				mode := mode_list
				archive_name := args.argument (n)
			elseif n - i >= 2 then
				arg_next := args.argument (i + 1)
				if n - i = 2 and then (arg.same_string_general ("-r") and arg_next.same_string_general ("-f")) then
					mode := mode_unarchive
					archive_name := args.argument (n)
				elseif n - i >= 3 and then (arg.same_string_general ("-w") and arg_next.same_string_general ("-f")) then
					mode := mode_archive
					archive_name := args.argument (i + 2)
					file_list := args.argument_array.subarray (i + 3, n)
					file_list.rebase (1) -- Not required, but easier to inspect.
				end
			end
		end


invariant
	correct_mode: mode = mode_usage or mode = mode_list or mode = mode_unarchive or mode = mode_archive
	empty_name_implies_usage: archive_name.is_empty implies mode = mode_usage
	non_empty_file_list_implies_archive: not file_list.is_empty implies mode = mode_archive
note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

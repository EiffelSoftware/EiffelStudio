note
	description: "A parsed command line argument."
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"

class PARSED_COMMAND_LINE_ARGUMENT

create
	{COMMAND_LINE_PARSER} make

feature {NONE} -- Initialization

	make (s: STRING; spec_opts: HASH_TABLE [OPTION_SPECIFICATION, STRING])
			-- Create a new parsed command line argument from the
			-- command line argument `s' and use the specified
			-- options in `spec_opts' to check if option
			-- arguments are expected.
		require
			s_not_void: s /= Void
			s_not_empty: s.count > 0
			spec_opts_not_void: spec_opts /= Void
		do
			argument := s.twin
			specified_options := spec_opts
			parse
		end

feature {COMMAND_LINE_PARSER} -- Access

	argument: STRING
			-- The textual value of this command line argument

	is_option_argument: BOOLEAN
			-- Is this an option argument?

	has_option_names: BOOLEAN
			-- Does this command line argument contain option
			-- name(s)?
		do
			Result := option_names /= Void and then option_names.count > 0
		end

	option_names: detachable LIST [STRING] note option: stable attribute end
			-- List of encountered option names. Short option names
			-- may come in groups. If the parsed command line
			-- argument was a long option and the specification
			-- lists a synonym short name, the short name will be
			-- returned.

	has_invalidly_grouped_option_names: BOOLEAN
			-- Does this commandline ragument contain invalidly
			-- grouped option names?
		do
			Result := invalidly_grouped_option_names /= Void and then invalidly_grouped_option_names.count > 0
		end

	invalidly_grouped_option_names: detachable LIST [STRING] note option: stable attribute end
			-- List of invalidly grouped option names. A short
			-- option name is invalidly grouped if it:
			-- a) is specified to take optional or required option
			--    arguments and
			-- b) is part of a group of short option names and
			-- c) is not the first option name in the group.

	is_single_dash: BOOLEAN
			-- Is this command line argument simply a single dash?
		do
			Result := argument.count = 1 and argument @ 1 = '-'
		end

	has_option_arguments: BOOLEAN
			-- Does it have any option arguments?
		do
			Result := option_arguments /= Void and then option_arguments.count > 0
		end

	option_arguments: detachable LIST [STRING] note option: stable attribute end
			-- Option arguments

feature {NONE} -- Implementation 	

	specified_options: HASH_TABLE [OPTION_SPECIFICATION, STRING]
			-- Table of specified options hashed by option name

	parse
			-- Parse.
		do
			if argument @ 1 = '-' then
				-- Is an option
				if argument.count > 1 and then argument @ 2 = '-' then
					-- Is a long option
					parse_long_option_name
				elseif argument.count > 1 then
					-- Is a short option
					parse_short_option_names
				else
					-- Is single dash
					check
						argument.count = 1 and argument @ 1 = '-'
					end
				end
			else
				-- Is an option argument
				is_option_argument := True
			end
		end

	parse_short_option_names
			-- Parse the short option names.
		require
			valid_argument: argument.count >= 2
		local
			s: STRING
			i: INTEGER
		do
			create {LINKED_LIST [STRING]} option_names.make

			-- First check if the first short option matches a
			-- specified option and then if it takes an argument
			s := argument.substring (1, 2)
			option_names.extend (s)
			if argument.count >= 3 then
				if specified_options.has (s) and then attached specified_options.item (s) as os then
					if os.has_optional_argument or os.has_required_argument then
						create {LINKED_LIST [STRING]} option_arguments.make
						option_arguments.extend (argument.substring (3, argument.count))
					end
				end
			end
			if not has_option_arguments then
				create {LINKED_LIST [STRING]} invalidly_grouped_option_names.make
				invalidly_grouped_option_names.compare_objects
				-- Go through all remaining alphanumerical
				-- characters in `argument' and check if they
				-- are specified options that require option
				-- arguments
				from
					i := 3
				until
					i > argument.count
				loop
					s := ""
					s.append_character ('-')
					s.append_character (argument @ i)
					option_names.extend (s)
					if specified_options.has (s) and attached specified_options.item (s) as os then
						if os.has_optional_argument or os.has_required_argument then
							invalidly_grouped_option_names.extend (s)
						end
					end
					i := i + 1
				end
			end
		end

	parse_long_option_name
			-- Parse the long option name.
		require
			valid_argument: argument.count >= 2
		local
			s: STRING
			i: INTEGER
		do
			-- First check if there is an option argument attached
			i := argument.index_of ('=', 1)
			if i > 0 then
				s := argument.substring (1, i - 1)
				create {LINKED_LIST [STRING]} option_arguments.make
				option_arguments.extend (argument.substring (i + 1, argument.count))
			else
				s := argument
			end

			s := synonym_short_name (s)

			create  {LINKED_LIST [STRING]} option_names.make
			option_names.extend (s)
		end

	synonym_short_name (s: STRING): STRING
			-- The synonym short name for the long option `s'. If no
			-- synonym short name exists, `s' is returned.
		require
			s_not_void: s /= Void
		local
			os: OPTION_SPECIFICATION
			found: BOOLEAN
		do
			Result := s
			from
				specified_options.start
			until
				specified_options.after
			loop
				os := specified_options.item_for_iteration
				if os.has_long_name and then os.long_name ~ s then
					found := True
					if attached os.short_name as l_sname then
						Result := l_sname
					end
				end
				specified_options.forth
			end
		end

invariant
	argument_not_void: argument /= Void
	argument_not_empty: argument.count > 0

end -- class PARSED_COMMAND_LINE_ARGUMENT


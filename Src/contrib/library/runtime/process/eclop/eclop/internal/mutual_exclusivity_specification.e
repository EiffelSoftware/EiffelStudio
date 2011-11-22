note
	description: "Specification of a set of mutually exclusive command line options."
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"

class MUTUAL_EXCLUSIVITY_SPECIFICATION

create
	 {COMMAND_LINE_SYNTAX} make

feature {NONE} -- Initialization

	make (spec: STRING; opts: HASH_TABLE [OPTION_SPECIFICATION, STRING])
			-- Create a new specification from the textual
			-- specification `spec'. Modify the option
			-- specifications in `opts' as appropriate!
		require
			spec_not_void: spec /= Void
			spec_not_empty: spec.count > 0
		do
			is_valid := True
			specification := spec.twin
			specification.prune_all (' ')
			specified_options := opts
			invalid_reason := ""
			parse
		end

feature {COMMAND_LINE_PARSER, COMMAND_LINE_SYNTAX} -- Access

	is_valid: BOOLEAN
			-- Is this specification valid?

	invalid_reason: STRING
			-- If invalid, this is the reason

	invalid_position: INTEGER
			-- If invalid, this is the position in the specification
			-- that it is invalid

	specification: STRING
			-- The textual specification

feature {NONE} -- Implementation

	specified_options: HASH_TABLE [OPTION_SPECIFICATION, STRING]
			-- Table of the options specifications used to validate
			-- the mutual exclusivity specification hashed by
			-- option name

	parse
			--  Parse the textual `specification'.
		require
			specification_not_void: specification /= Void
		local
			opts: LIST [STRING]
		do
			if specification @ 1 = '(' then
				if specification @ (specification.count) = ')' then
				        opts := specification.substring (2, specification.count - 1).split ('|')
					if opts.count > 1 then
						parse_options (opts)
					else
						is_valid := False
						invalid_reason := "Specification must contain at least two named options"
						invalid_position := 1
					end
				else
					is_valid := False
					invalid_reason := "Specification must end with a ')' character"
					invalid_position := 1
				end
			else
				is_valid := False
				invalid_reason := "Specification must begin with a '(' character"
				invalid_position := 1
			end
		end

	parse_options (opt_names: LIST [STRING])
			-- Parse the list of option names in `opt_names'.
		require
			opt_names_not_void: opt_names /= Void
			at_least_two_option_names: opt_names.count >= 2
		local
			pos: INTEGER -- Keeps track of what position we are parsing in the textual specification
			invalid_syntax_found, unrecognized_name_found, duplicate_name_found: BOOLEAN
			used_names: LINKED_LIST [STRING]
		do
			-- Check that the option names in `opt_names' are among
			-- those specified by `specified_options' and that
			-- there are no duplicates among the `opt_names'.
			from
				pos := 2
				invalid_syntax_found := False
				unrecognized_name_found := False
				duplicate_name_found := False
				create used_names.make
				used_names.compare_objects
				opt_names.start
			until
				invalid_syntax_found or else
				unrecognized_name_found or else
				duplicate_name_found or else
				opt_names.after
			loop
				invalid_syntax_found := not is_valid_option_name_syntax (opt_names.item)
				if not invalid_syntax_found then
					unrecognized_name_found := not specified_options.has (opt_names.item)
					if not unrecognized_name_found then
						duplicate_name_found := used_names.has (opt_names.item)
						if not duplicate_name_found then
							used_names.extend (opt_names.item)
							pos := pos + 1 + opt_names.item.count
						end
					end
				end
				opt_names.forth
			end
			if invalid_syntax_found then
				is_valid := False
				invalid_reason := "Invalid option name syntax"
				invalid_position := pos
			elseif unrecognized_name_found then
				is_valid := False
				invalid_reason := "Unrecognized option name"
				invalid_position := pos
			elseif duplicate_name_found then
				is_valid := False
				invalid_reason := "Duplicate option name"
				invalid_position := pos
			else
				set_mutual_exclusivity (opt_names)
			end
		end

	set_mutual_exclusivity (opt_names: LIST [STRING])
			-- Update each appropriate option specification in
			-- `specified_options' with inormation on which options
			-- it is mutually exclusive based on `opt_names'.
		local
			i, j: INTEGER
			os1, os2: detachable OPTION_SPECIFICATION
		do
			from
				i := 1
			until
				i = opt_names.count
			loop
				os1 := specified_options @ (opt_names @ i)
				from
					j := i + 1
				until
					j > opt_names.count
				loop
					os2 := specified_options @ (opt_names @ j)
					if os1 /= Void and then os2 /= Void then
						os1.set_mutually_exclusive_with (os2)
					end
					j := j + 1
				end
				i := i + 1
			end
		end

	is_valid_option_name_syntax (s: STRING): BOOLEAN
			-- Is `s' a valid option name?
		require
			valid_s: s /= Void and then s.count > 0
		do
			Result := s @ 1 = '-'
			if Result and s @ 2 = '-' then
				-- Is a long option name
				if s.count > 2 then
					Result := is_alpha_numericalhyphen_string (s.substring (3, s.count))
				else
					Result := False
				end
			elseif Result then
				-- Is a short option name
				if s.count > 1 then
					Result := is_alpha_numerical_string (s.substring (2, s.count))
				else
					Result := False
				end
			end
		end

	is_alpha_numerical_string (s: STRING): BOOLEAN
			-- Is `s' an alphanumerical string?
		require
			s_not_void: s /= Void
		local
			i: INTEGER
		do
			from
				Result := True
				i := 1
			until
				not Result or else i > s.count
			loop
				Result := (s @ i).is_alpha or (s @ i).is_digit
				i := i + 1
			end
		end

	is_alpha_numericalhyphen_string (s: STRING): BOOLEAN
			-- Does `s' only contain an alphanumerical or '-'
			-- characters?
		require
			s_not_void: s /= Void
		local
			i: INTEGER
		do
			from
				Result := True
				i := 1
			until
				not Result or else i > s.count
			loop
				Result := (s @ i).is_alpha or (s @ i).is_digit or (s @ i) = '-'
				i := i + 1
			end
		end

end -- class MUTUAL_EXCLUSIVITY_SPECIFICATION



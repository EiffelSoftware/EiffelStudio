note
	description: "Command line parser."
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	
class COMMAND_LINE_PARSER
	
inherit
	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end
		
create
	make
   
feature {NONE} -- Initialization
	
	make (cls: COMMAND_LINE_SYNTAX)
			-- Create a new command line parser using the syntax
			-- `cls'. 
		require
			syntax_not_void: cls /= Void
			syntax_is_valid: cls.is_valid
		do
			syntax := cls
		ensure
			syntax_is_set: syntax = cls
		end
	
feature -- Access 
	
	executable: STRING
			-- The name of the current executable stripped of all
			-- preceding directory names and separators
		do
			Result := executable_path.twin
			Result.tail (Result.count - Result.last_index_of (directory_separator, Result.count))
		end
	
	executable_without_suffix: STRING
			-- The name of the current executable stripped of all
			-- preceding directory names and separators and without
			-- any eventual suffix like ".exe"
		do
			Result := executable.twin
			if Result.has ('.') then
				Result.head (Result.last_index_of ('.', Result.count) - 1)
			end
		end
	
	executable_path: STRING
			-- The name of the current executable in the form of a
			-- full path including preceding directory names and
			-- directoy name separators 
	
	valid_options: HASH_TABLE [LIST [STRING], STRING]
			-- Information on the parsed valid_options. The possible
			-- contents is a mix of:
			-- 1) A hash key consisting of a valid option found when
			--    parsing and a hash item that is Void.
			-- 2) A hash key consisting of a valid option found when 
			--    parsing and a hash item consisting of a list
			--    arguments found when parsing.
			-- Empty if no valid_options were encountered.
	
	operands: LIST [STRING] 
			-- List of operands, ie. all arguments following the
			-- "--" argument, if any
	
	single_dash_encountered: BOOLEAN
			-- Was a single dash encountered? This means that if
			-- your program uses operands to represent files to be
			-- opened for either reading or writing, you should now
			-- read or write, as the case is, from standard input or
			-- standard output respectively.
	
	invalid_options_found: BOOLEAN
			-- Where any invalid options found while parsing? 
		do
			Result := required_options_missing or 
				options_with_missing_arguments_found or 
				unrecognized_options_found  or
				mutually_exclusive_options_found or
				ambigous_options_found or
				invalidly_grouped_options_found
		ensure
			Result implies (required_options_missing or
				        options_with_missing_arguments_found or
					unrecognized_options_found or
					mutually_exclusive_options_found or
					ambigous_options_found or
					invalidly_grouped_options_found)
		end
	
	missing_options: LINKED_LIST [STRING] 
			-- List of missing options. Empty if no missing options
			-- were encountered. 
	
	options_with_missing_arguments: LINKED_LIST [STRING] 
			-- List of options with missing arguments. Empty
			-- if no options with missing arguments were encountered. 
	
	unrecognized_options: LINKED_LIST [STRING]
			-- List of unrecognized options. Empty if no
			-- unrecognized options were encountered.
	
	mutually_exclusive_options: HASH_TABLE [STRING, STRING] 
			-- Table of mutually exclusive options. Empty if no
			-- such options were encountered. Hash keys are
			-- individual option names and the items are strings
			-- containing a comma-separated list of all the parsed
			-- options with which the given option is mutually
			-- exclusive. 
	
	ambigous_options: LINKED_LIST [STRING]
			-- List of ambigous options. Empty if no
			-- ambigous options were encountered.
	
	invalidly_grouped_options: LINKED_LIST [STRING]
			-- List of invalidly grouped short options. A short
			-- option may not be grouped with other short options
			-- if it takes option arguments
	
	required_options_missing: BOOLEAN 
			-- Was any required options missing when parsing? 
	
	options_with_missing_arguments_found: BOOLEAN 
			-- Where any options requiring arguments lack arguments
			-- when parsing?  
	
	unrecognized_options_found: BOOLEAN
			-- Where any unrecognized options encountered when
			-- parsing?  
	
	mutually_exclusive_options_found: BOOLEAN
			-- Where any mutually exclusive options found when
			-- parsing? 
	
	ambigous_options_found: BOOLEAN
			-- Where any ambigous (long) options found when
			-- parsing? 
	
	invalidly_grouped_options_found: BOOLEAN
			-- Where any invalidly grouped short options found when
			-- parsing? 
	
	error_message: STRING
			-- An error message with information on errors
			-- encountered when parsing
		require
			invalid_options: invalid_options_found
		do
			Result := ""
			if required_options_missing then
				from 
					missing_options.start
				until
					missing_options.after
				loop
					Result := Result + executable_without_suffix + ": required option missing: " + missing_options.item + "%N"
					missing_options.forth
				end
			end
			if options_with_missing_arguments_found then
				from 
					options_with_missing_arguments.start
				until
					options_with_missing_arguments.after
				loop
					Result := Result + executable_without_suffix + ": option requires an argument: " + options_with_missing_arguments.item + "%N"
					options_with_missing_arguments.forth
				end
			end
			if unrecognized_options_found then
				from 
					unrecognized_options.start
				until
					unrecognized_options.after
				loop
					Result := Result + executable_without_suffix + ": illegal option: " + unrecognized_options.item + "%N"
					unrecognized_options.forth
				end
			end
			if mutually_exclusive_options_found then
				from 
					mutually_exclusive_options.start
				until
					mutually_exclusive_options.after
				loop
					Result := Result + executable_without_suffix + ": mutually exclusive options: " + mutually_exclusive_options.item_for_iteration + "%N"
					mutually_exclusive_options.forth
				end
			end
			if ambigous_options_found then
				from
					ambigous_options.start
				until
					ambigous_options.after
				loop
					Result := Result + executable_without_suffix + ": ambigous long option: " + ambigous_options.item + "%N"
					ambigous_options.forth
				end
			end
			if invalidly_grouped_options_found then
				from 
					invalidly_grouped_options.start
				until
					invalidly_grouped_options.after
				loop
					Result := Result + executable_without_suffix + ": invalidly grouped option: " + invalidly_grouped_options.item + "%N"
					invalidly_grouped_options.forth
				end
			end
		end
		
feature -- Basic operations
	
	parse (args: ARRAY [STRING]) 
			-- Parse the `args'. 
		require
			args_not_void: args /= Void
			args_contains_at_least_executable_name: args.count > 0
		do
			executable_path := (args @ args.lower).twin
			
			if args.count > 1 then
				-- 1. Parse the individual command line arguments by
				--    creating a list `parsed_arguments' of
				--    PARSED_COMMAND_LINE_ARGUMENT objects and a list
				--    `parsed_operands' of STRING objects.
				parse_command_line_arguments (args.subarray (args.lower + 1, args.upper))
			else
				parse_command_line_arguments (<<>>)
			end
				-- 2. Iterate over the `parsed_arguments' list and
				--    create a hash table `parsed_options' of
				--    PARSED_OPTION objects hashed by option name.				
			parse_options
				
				-- 3. Iterate over the `parsed_options' and validate
				--    the options.				
			validate_parsed_options
		end			
	
feature -- Test & Debug
	
	pretty_print_of_valid_options: STRING
			-- Pretty presentation of all information on the
			-- most recently parsed (valid) options
		local
			args_offset: INTEGER
			line, s: STRING
			l: LIST [STRING]
		do
			-- Define the offset to the column position where the
			-- arguments will be ouput
			args_offset := 14
			
			Result := "These are the encountered valid options:%N"
			Result := Result + "    key      arguments%N"
			from
				valid_options.start
			until
				valid_options.after
			loop
				line := "     " + valid_options.key_for_iteration
				create s.make (args_offset - line.count)
				s.fill_blank
				line := line + s 
				if valid_options.item_for_iteration /= Void then
					l := valid_options.item_for_iteration
					from
						l.start
					until
						l.after
					loop
						line := line + l.item
						l.forth
						if not l.after then
							line := line + ", "
						end
					end
				end
				line := line + "%N"
				Result := Result + line
				valid_options.forth
			end
		end
	
feature {NONE} -- Implementation (Basic operations)
	
	parse_command_line_arguments (args: ARRAY [STRING]) 
			-- Parse the command line arguments and create the lists
			-- `parsed_arguments' and `operands'.
		require
			args_not_void: args /= Void
--			valid_args: args.count > 0
		local
			i: INTEGER
			pa: PARSED_COMMAND_LINE_ARGUMENT
			double_dash_found: BOOLEAN
		do
			create parsed_arguments.make
			create {LINKED_LIST [STRING]} operands.make
			from
				double_dash_found := False
				i := args.lower
			until
				i > args.upper
			loop
				if not double_dash_found then
					if (args @ i).is_equal ("--") then
						double_dash_found := True
						i := i + 1
					else
						create pa.make (args @ i, syntax.specified_options)
						parsed_arguments.extend (pa)
						i := i + 1
					end
				else
					operands.extend (args @ i)
					i := i + 1
				end
			end
		ensure
			parsed_arguments_not_void: parsed_arguments /= Void 
			new_parsed_arguments: parsed_arguments /= old parsed_arguments
			operands_not_void: operands /= Void
			new_operands: operands /= old operands
		end
	
	parse_options
			-- Iterate over `parsed_arguments' and create the list `parsed_options'.
		require
			parsed_arguments_not_void: parsed_arguments /= Void
		local
			pa: PARSED_COMMAND_LINE_ARGUMENT
			ls: LIST [STRING]
			po, previous_po, temp_po: PARSED_OPTION
		do
			create parsed_options.make (parsed_arguments.count)
				
			from
				parsed_arguments.start
			until
				parsed_arguments.after
			loop
				pa := parsed_arguments.item
				if pa.is_single_dash then
                                         create po.make ("-", Void)
                                         single_dash_encountered := True
				end
				if pa.has_invalidly_grouped_option_names then
					invalidly_grouped_options_found := True
					ls := pa.invalidly_grouped_option_names
					from 
						ls.start
					until
						ls.after
					loop
						create po.make (ls.item, Void)
						po.set_invalidly_grouped
						parsed_options.put (po, po.name)
						ls.forth
					end
					previous_po := Void
				end
				if pa.has_option_names then
					if pa.option_names.count > 1 then
						-- We have grouped option names
						from
							pa.option_names.start
						until
							pa.option_names.after
						loop
							if not parsed_options.has (pa.option_names.item) then
								create po.make (pa.option_names.item, Void)
								parsed_options.put (po, pa.option_names.item)
							else
								-- Ignore multiple use of the same
								-- option name on the command line
							end
							pa.option_names.forth
						end
						previous_po := Void
					else
                                                create temp_po.make (pa.option_names.first, pa.option_arguments)
                                                -- If we've already parsed this
                                                -- option just update its list
                                                -- of arguments 
                                                if parsed_options.has (temp_po.name) then
							if temp_po.has_arguments then
								po := parsed_options @ po.name
								from
									temp_po.arguments.start
								until
									temp_po.arguments.after
								loop
									po.add_argument (temp_po.arguments.item)
									temp_po.arguments.forth
								end
							end
						else
							po := temp_po
							parsed_options.put (po, po.name)
						end	
						previous_po := po
					end
				elseif pa.is_option_argument then
					if previous_po /= Void then
						previous_po.add_argument (pa.argument)
					else
						-- Ignore option argument
					end
				end
				parsed_arguments.forth
			end
		ensure
			parsed_options_not_void: parsed_options /= Void
			new_parsed_options: parsed_options /= old parsed_options
		end
	
	is_option_argument (s: STRING): BOOLEAN
			-- Is `s' a command line option argument?
		do
			Result := s @ 1 /= '-'
		end
	
	validate_parsed_options
			-- Validate the parsed options against the option
			-- specifications.
		require
			parsed_options_not_void: parsed_options /= Void
		local
			spec_opts: LIST [OPTION_SPECIFICATION]
			cursor: CURSOR
			os, match_os: OPTION_SPECIFICATION
			po, po2: PARSED_OPTION
			option_found, args_found: BOOLEAN
			s: STRING
		do
			create valid_options.make (parsed_options.count)
			create missing_options.make
			create options_with_missing_arguments.make
			create unrecognized_options.make
			create mutually_exclusive_options.make (parsed_options.count)
			create ambigous_options.make
			create invalidly_grouped_options.make 
			required_options_missing := False
			options_with_missing_arguments_found := False
			unrecognized_options_found := False
			mutually_exclusive_options_found := False
			ambigous_options_found := False
			invalidly_grouped_options_found := False
			
			-- Check if required options exist and if options
			-- requiring arguments have arguments. 
			from
				spec_opts := syntax.specified_options.linear_representation
				spec_opts.start
			until
				spec_opts.after
			loop
				os := spec_opts.item 
				
				from 
					option_found := False
					args_found := False
					parsed_options.start
				until
					parsed_options.after
				loop
					po := parsed_options.item_for_iteration
					if os.matches_name (po.name) then
						option_found := True
						if po.is_invalidly_grouped then
							invalidly_grouped_options_found := True
							invalidly_grouped_options.extend (po.name)
						elseif os.has_required_argument and not po.has_arguments then
							options_with_missing_arguments_found := True
							options_with_missing_arguments.extend (os.name)
						else
							update_valid_options (po.name, po)
						end
					end
					parsed_options.forth
				end
				
				if os.is_required and not option_found then
					required_options_missing := True
					missing_options.extend (os.name)
				end
				spec_opts.forth
			end
			
			-- Check if any unrecognized options exist
			from 
				parsed_options.start
			until
				parsed_options.after
			loop
				po := parsed_options.item_for_iteration
				from 
					option_found := False
					spec_opts.start
				until
					spec_opts.after or option_found
				loop
					os := spec_opts.item
					if os.matches_name (po.name) then
						option_found := True
					end
					spec_opts.forth
				end
				
				if not option_found and then po.name.substring (1, 2).is_equal ("--") then
					-- Look for the closest match assuming
					-- `po.name' is an abbreviation for a
					-- long option name 
					from
						match_os := Void
						spec_opts.start
					until
						ambigous_options_found or else spec_opts.after
					loop
						os := spec_opts.item
						if os.has_abbreviation (po.name) then
							if match_os /= Void then
								ambigous_options_found := True
								ambigous_options.extend (po.name)
							else
								match_os := os
							end
						end
						spec_opts.forth
					end
					if match_os /= Void then
						option_found := True
						update_valid_options (match_os.name, po)
						if match_os.has_required_argument and not po.has_arguments then
							options_with_missing_arguments_found := True
							options_with_missing_arguments.extend (os.name)
						else
							update_valid_options (po.name, po)
						end
					end
				end
				
				if not option_found then
					ambigous_options.compare_objects
					if not ambigous_options.has (po.name) then
						unrecognized_options_found := True
						unrecognized_options.extend (po.name)
					end
				end
				
				parsed_options.forth
			end		
			
			-- Check if there are mutually exclusive options
			from
				parsed_options.start
			until
				parsed_options.after
			loop
				po := parsed_options.item_for_iteration
				if syntax.specified_options.has (po.name) then
					os := syntax.specified_options @ po.name
					from
						cursor := parsed_options.cursor
						parsed_options.start
					until
						parsed_options.after
					loop
						po2 := parsed_options.item_for_iteration
						if po2 /= po and os.is_exclusive_with (po2.name) then
							valid_options.remove (po2.name)
							mutually_exclusive_options_found := True
							if mutually_exclusive_options.has (po2.name) then
								s := mutually_exclusive_options @ po2.name + "," + os.name
								mutually_exclusive_options.force (s, po2.name)
							else
								mutually_exclusive_options.put (os.name, po2.name)
							end
						end
						parsed_options.forth
					end
					parsed_options.go_to (cursor)
				end
				parsed_options.forth
			end
		end
	
	update_valid_options (opt_name: STRING; po: PARSED_OPTION)
			-- Update the table of valid options
		require
			opt_name_not_void: opt_name /= Void
			po_not_void: po /= Void
		local
			args: LIST [STRING]
		do
			if valid_options.has (opt_name) then
				if po.has_arguments then
					args := valid_options @ opt_name
					args.append (po.arguments)
					valid_options.replace (args, opt_name)
				end
			else
				valid_options.put (po.arguments, opt_name)
			end
		end
	
feature {NONE} -- Implementation
	
	syntax: COMMAND_LINE_SYNTAX
			-- The syntax used when parsing
	
	parsed_arguments: LINKED_LIST [PARSED_COMMAND_LINE_ARGUMENT]
			-- The parsed command line arguments
	
	parsed_options: HASH_TABLE [PARSED_OPTION, STRING]
			-- The parsed options
	
invariant
	valid_syntax: syntax.is_valid
	
end -- class COMMAND_LINE_PARSER


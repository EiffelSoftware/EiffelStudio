indexing
	description: "common ancestor/utility for ES5SH"
	name: "EIFFEL_SRC:[ES5SH]ES5SH_COMMON.E"
	author: "David Schwartz"
	Version: "V6.2-001"
	Date: "$Date$"
	Revision: "$Revision$"
	Id:		"$Id$"
	Notes: "*** be sure to update pretty_version string below to match the Version here"

class
	ES5SH_COMMON

feature -- Access

	pretty_name:	STRING is	"ES5SH"
	pretty_version: STRING is	"es5sh X6.2-001"
	default_date_time_format: STRING  is "[0]dd-mmm-yyyy [0]hh:[0]mi:[0]ss"
	default_time_format: STRING is "[0]hh:[0]mi:[0]ss"
	default_wrap_margin: INTEGER is 80
	default_comment_prefix: STRING is "#--"

	symbol_eiffel:	STRING --is  "ISE_EIFFEL"  	
			-- eiffel macro name: one of ISE_EIFFEL, EIFFEL5, EIFFEL4
	symbol_platform: STRING is "ISE_PLATFORM"	-- platform macro name, was PLATFORM

-- VMS logical names (environment variables)
	value_eiffel: STRING
			-- value of $ISE_EIFFEL (`symbol_eiffel')
	value_eiffel_string: STRING
			-- symbol_eiffel + value_eiffel + value_eifel_native

	value_platform: STRING
		-- value of $ISE_PLATFORM

	macro_platform:	STRING is	-- "$(ISE_PLATFORM)"
		once
			Result := "$(" + symbol_platform + ")"
		end

	space_character: CHARACTER is ' '
	tab_character: CHARACTER is '%T'

	whitespace_characters : ARRAY[CHARACTER] is
		once
			Result := << ' ', '%T', '%N' , '%R'>>
			Result.compare_objects
		end

	path_delimiters : ARRAY[CHARACTER] is	--STRING is ":[]<>/\"
				-- The set of filespec delimiters on all platforms (VMS/Unix/Windows)
				-- (nb. excludes VMS intra-path delimiter '.')
		once
			Result := << ':', '[', ']', '<', '>', '/', '\' >>
			Result.compare_objects
		end

	configuration: ES5SH_CONFIGURATION

	configuration_file_name: FILE_NAME
			-- name of the configuration file (from -c argument, default: ISE_EIFFEL:[studio.config.$(ISE_PLATFORM)].eif)

	base_directory: DIRECTORY_NAME
			-- top level directory to start in (usually .../EIFGEN/W_code or ...EIFGEN/F_code)

	in_makefile: ES5SH_TEXT_FILE  --PLAIN_TEXT_FILE
			-- Makefile.SH where the shell script is now

	out_makefile: ES5SH_TEXT_FILE --PLAIN_TEXT_FILE
			-- Makefile to be created

	generate_object_libraries: BOOLEAN
		-- if True, generate object libraries (.olb); else generate object modules (.obj)
		-- used for transitioning/testing from object library to concatenated object module generation
	generate_object_libraries_default: BOOLEAN is True
	generated_object_file_type: STRING is
		once
			if generate_object_libraries then
				Result := ".olb"
			else
				Result := ".obj"
			end
		end


	--execution_environment_: VMS_EXECUTION_ENVIRONMENT is (someday!)
	Execution_environment_: ES5SH_EXECUTION_ENVIRONMENT is
		once create Result end

	Operating_environment_: OPERATING_ENVIRONMENT is
		once create Result end

	Exceptions_: EXCEPTIONS is
		once create Result end

	Arguments_: ARGUMENTS is
		once create Result end

feature -- Configuration

	configuration_item_once (a_key : STRING; a_default : STRING) : STRING is
			-- value of configuration option `a_key'.
			-- If not defined, print warning message and define as `a_default' so the warning is issued only once.
		require
			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
		local
			--l_msg: STRING
		do
			if configuration.has (a_key) then
				Result := configuration.item (a_key)
			else
				--print_file_message (in_makefile, in_makefile.line_count, "Warning", a_key + " not specified")
				print_makefile_message ("Warning", "%N%T value for $" + a_key + " not specified")
				if a_default /= Void and then not a_default.is_empty then
					Result := a_default
					print ("%N%T$" + a_key + " = " + Result + " will be assumed.%N")
				else
					Result := ""
					print ("%N%T$" + a_key + " will be ignored.%N")
				end
				configuration.force (Result, a_key)	-- suppress further warnings for this name
			end
		end; -- get_configuration_item_once

	configuration_item (a_key : STRING; a_default : STRING) : STRING is
			-- Rvalue of configuration option `a_key'.
		require
			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
		local
			--l_msg: STRING
		do
			if configuration.has (a_key) then
				Result := configuration.item (a_key)
			else
				Result := a_default
				end
		end; -- configuration_option

feature -- String utility operations

	remove_enclosing_quotes (a_str: STRING) is
			-- remove enclosing quotes, if any, from `a_str'
		require
			string_not_void: a_str /= Void
		do
			if a_str.count >= 2 and then a_str @ 1 = '%"' and then a_str @ (a_str.count) = '%"'  then
				a_str.remove_tail (1)
				a_str.remove_head (1)
			end
		end

	delimit_target_colon (a_line: STRING) is
			-- insert spaces around the target (colon) delimiter of a target dependency specification ( target : dependents...)
		require
			line_nonblank: a_line /= Void and then not a_line.is_empty
			line_is_target_dependency_specification:
				a_line.count >= 3 and then not is_whitespace (a_line @ 1) and then a_line.index_of (':', 2) > 0
		local
			l_pos: INTEGER
		do
			l_pos := a_line.index_of (':', 2)
			if l_pos > 0 then
				if a_line.count > l_pos and then a_line @ (l_pos + 1) /= ' ' then
					if a_line @ (l_pos + 1) = ':' then
						a_line.insert_character (' ', l_pos + 2)
					else
						a_line.insert_character (' ', l_pos + 1)
					end
				end
				if l_pos > 1 and then a_line @ l_pos /= ' ' then
					a_line.insert_character (' ', l_pos)
				end
			end
		end

feature -- character classification

	is_symbol_constituent (c : CHARACTER) : BOOLEAN is
			-- is `c' a constituent of a symbol, in shell/makefile terms,
			-- i.e. is it a digit, letter, or underscore?
		do
			-- ***FIXME*** why '.' ?  is this used for filenames somewhere?  precompile?
			Result :=  (c.is_alpha or c.is_digit or c = '_' or c = '.')
		end; -- is_symbol_constituent

	is_space_or_tab (c: CHARACTER): BOOLEAN is
			-- is `c' a space or tab character?
		do
			Result := (c = space_character or else c = tab_character)
		end

	is_whitespace (c : CHARACTER) : BOOLEAN is
			-- is character 'c' a whitespace character?
		local
			-- alt	: CHARACTER is '%255'
		do
			Result := whitespace_characters.has (c)
		end; -- is_whitespace


feature -- primivite tokenization

			-- words are whitespace delimited
			-- tokens are either symbols or special characters

	next_word_index (str : STRING; start_pos : INTEGER) : INTEGER is
			-- Returns the starting index of the next word in 'str', 0 if no more.
			-- start_pos is 0 to find the first word,
			-- otherwise it is the position of the last character of the current word, or
			-- a position in whitespace after the current word
		require
			str_exists:		str /= Void
			start_large_enough:		start_pos >= 0
			start_small_enough:		start_pos <= str.count
		local
			l_pos : INTEGER
		do
			-- Find the start of the next word: first non-whitespace character after start_pos
			from
				l_pos := start_pos + 1
			until
				l_pos > str.count or else not is_whitespace (str @ l_pos)
			loop
				l_pos := l_pos + 1
			end -- loop: find start of word

			if l_pos > str.count then
				Result := 0
			else
				Result := l_pos
			end
		ensure
			result_in_bounds:		Result >= 0 or Result <= str.count
		end; -- next_word_index


	end_word_index (str : STRING; start_pos : INTEGER) : INTEGER is
			-- return the index of the last character of the word that starts at start_pos in 'str'
			-- if start_pos is whitespace, returns start_pos -1
			-- if word starts with a quote character, retuns the index of the closing quote; if none,
			-- return index of last character in string.
		require
			str_exists:		str /= Void
			start_large_enough:		start_pos >= 0
			start_small_enough:		start_pos <= str.count
			--start_is_word:  		not is_whitespace (str @ start_pos)
		do
			if start_pos = 0 then
				Result := 0
			else
				if ("%"'`").has(str @ start_pos) then
						-- quoted string, find closing (unescaped) quote character
					from
						Result := start_pos + 1
					until
						Result = 0 or else Result >= str.count or else str @ start_pos = str @ Result
					--invariant: Result is always > previous Result
					loop
						Result := str.index_of (str @ start_pos, Result + 1)
						if Result = 0 then
							print_warning_message ("Quoted string has no closing quote, starting position: " + start_pos.out + ", %N string: %"" + str + "%"%N")
							Result := str.count + 1
						elseif str @ (Result - 1) = '\' then
							Result := Result + 1
						end
					end -- loop
				else
						-- Find the end of the current word: last non-whitespace character at or after start position
					from
						Result := start_pos
					until
						Result > str.count or else is_whitespace (str @ Result)
					loop
						Result := Result + 1
					end -- loop: find end of word
					if Result > str.count then
						Result := str.count
					else
						Result := Result - 1
					end
				end
			end
		ensure
			result_in_bounds:			Result <= str.count
		end; -- end_word_index



	first_token (a_str: STRING) : STRING is
			-- the first token in `a_str'; may be empty but never void
		require
			str_exists: a_str /= Void
		do
			if a_str.is_empty then
				Result := ""
			else
				Result := next_token (a_str, 1)
			end
		ensure
			result_exists:  Result /= Void
		end -- first_token

	second_token (a_str, token_1 : STRING) : STRING is
			-- the second token in `a_str', given the first
		require
			str_exists: a_str /= void
			first_token_exists : token_1 /= void
			first_token_not_empty : not token_1.is_empty
			-- substring_index requires not other.is_empty
		do
			Result := next_token (a_str, a_str.substring_index(token_1, 1) + token_1.count)
		ensure
			result_exists:  Result /= Void
		end -- second_token

	next_token (a_str : STRING; start_pos : INTEGER) : STRING is
			-- the "next" token in `a_str' beginning after `start_pos'
		require
			str_exists:	a_str /= Void
			start_large_enough : start_pos >= 1
		local
			l_pos : INTEGER
			l_line : STRING
		do
			if a_str /= void then
				if start_pos > a_str.count then
					Result := ""
				else
					l_line := a_str.substring (start_pos, a_str.count)
					-- look for comments, strip them off
					l_pos := l_line.index_of ('#', 1)
					if l_pos > 0 then
						l_line.keep_head (l_pos - 1)
					end
					-- strip leading and trailing whitespace
					l_line.left_adjust; l_line.right_adjust
					-- find the end of the token (first non-whitespace character)
					from l_pos := 1
					until
						l_pos > l_line.count or else is_whitespace (l_line.item(l_pos))
								-- "symbolness" of this character differs from that of first character
							or else is_symbol_constituent (l_line @ l_pos) /= is_symbol_constituent (l_line @ 1)
					loop
						l_pos := l_pos + 1
					end -- loop
					Result := l_line.substring (1, l_pos - 1)
				end
			end -- a_str not void

		ensure
			result_exists:  Result /= void
		end;  -- next_token



feature -- string utilities
-- should be features of a class that inherits from STRING

	is_nonblank (a_str: STRING) : BOOLEAN is
			-- does `a_str' exist, and is it nonblank?
		do
			Result := a_str /= Void and then not is_blank (a_str)
		end

	is_blank (this : STRING) : BOOLEAN is
			-- is `this' blank (all whitespace or empty)?
		require
			string_exists: this /= Void
		local
			l_pos : INTEGER
		do
			Result := True
			if not this.is_empty then
				from
					l_pos := 1
				until
					l_pos > this.count
				loop
					if not is_whitespace (this @ l_pos) then
						Result := False
						l_pos := this.count
					end
					l_pos := l_pos + 1
				end -- loop
			end
		end; -- is_blank

	first_index_of_any (this: STRING; set: ARRAY[CHARACTER]; start_pos: INTEGER) : INTEGER is
			-- index of first character in 'set' that appears in 'this' at or after start_pos; 0 if none
		require
			this_exists:	this /= Void
			set_exists:			set /= Void
		local
			ii, l_curr: INTEGER
		do
			from
				ii := set.lower
			until
				ii > set.upper
			loop
				l_curr := this.index_of (set @ ii, start_pos)
				if l_curr > 0 and then (Result = 0 or else l_curr < Result) then
					Result := l_curr
				end
				ii := ii + 1
			end
		end

	starts_with (this : STRING; other : STRING) : BOOLEAN is
			-- Does 'this' begin with 'other'? if other is empty, always True.
		require
			this_exists:	this /= Void
			other_exists:	other /= Void
		do
			Result := other.count <= this.count and then this.substring_index (other, 1) = 1
			--Result := this.substring_index (other, 1) = 1
		end; -- starts_with

	starts_with_symbol (this : STRING; symbol: STRING) : BOOLEAN is
			-- Does `this' begin with `symbol'? Symbol token is whitespace/non-alpha delimited.
		require
			this_exists: this /= Void
			-- symbol_nonblank:  symbol /= Void and then not symbol.is_empty
		do
			if symbol /= Void and then not symbol.is_empty then
				Result := this.is_equal (symbol) or else
					symbol.count < this.count and then this.substring_index (symbol, 1) = 1
					and then not is_symbol_constituent (this.item (symbol.count +1))
			end
		end; -- starts_with_symbol

	ends_with (this: STRING; other: STRING) : BOOLEAN is
			-- Does this end with other? If other is empty, always true.
		require
			this_exists:	this  /= Void
			other_exists:	other /= Void
		local
			l_pos : INTEGER
		do
			l_pos := this.count - other.count + 1
			Result := other.count <= this.count and then
				this.substring_index (other, this.count - other.count + 1) > 0
		end; -- ends_with

		replace_first (this, first, new: STRING) is
						-- replace "first" at end of "this" with "new" ("new" may be empty)
		require
			this_exists: this /= Void
			this_not_empty: not this.is_empty
			first_exists: first /= Void
			first_not_empty: not first.is_empty
			--this_contains_first: ends_with (this, first)
			new_exists:	new /= Void
		local
				l_pos: INTEGER
			do
					l_pos := this.substring_index (first, 1)
					if l_pos > 0 then
							this.replace_substring (new, l_pos, l_pos + first.count - 1)
					end
			end

	replace_end (this, last, new: STRING) is
			-- replace 'last' at end of 'this' with 'new' ('new' may be empty)
		require
			this_exists: this /= Void
			--this_not_empty: not this.is_empty
			last_exists: last /= Void
			--last_not_empty: not last.is_empty
			new_exists:	new /= Void
			this_ends_with_last: ends_with (this, last)
		local
			l_pos: INTEGER
		do
			l_pos := this.count - last.count + 1
			this.replace_substring (new, this.count - last.count + 1, this.count)
		ensure
			replacement_done: ends_with (this, new)
		end; -- replace_end

	trimmed (a_str: STRING): STRING is
			-- string with all leading and trailing whitespace removed
		do
			if a_str /= Void then
				Result := a_str.twin
				Result.right_adjust; Result.left_adjust
			end
		end

	reduce_whitespace (this : STRING; start_pos : INTEGER) is
			-- remove leading and trailing whitespace,
			-- reduce all other whitespace characters to single space
		require
			start_large_enough:			start_pos >= 1
		local
			l_pos : INTEGER
		do
			if not this.is_empty then
				this.right_adjust; this.left_adjust
				-- this.replace_substring_all ("%T", " ")
				from
					l_pos := start_pos
				until
					l_pos > this.count
				loop
					if is_whitespace (this @ l_pos) then
						if l_pos > 1 and then is_whitespace (this @ (l_pos - 1) ) then
							this.remove (l_pos)
							l_pos := l_pos - 1
						elseif this @ l_pos /= space_character then
							this.put (space_character, l_pos)
						end
					end -- if whitespace
					l_pos := l_pos + 1
				end -- loop				
			end
		end;


feature -- Output

	print_undefined_symbol_warning (a_sym: STRING) is
			-- print a warning that an undefined symbol referenced
		do
			print_makefile_warning ("undefined symbol referenced: " + a_sym)
		end

	print_error_message (msg: STRING) is
		do
			print_output_message ("Error: " + msg)
		end; -- print_error_message

	print_warning_message (msg: STRING) is
		do
			print_output_message ("Warning: " + msg)
		end; -- print_warning_message

	print_makefile_warning (a_msg: STRING) is
		do
			print_makefile_message ("Warning", a_msg)
		end

	print_makefile_error (a_msg: STRING) is
		do
			print_makefile_message ("Error", a_msg )
		end

	print_makefile_message (a_severity, a_msg: STRING) is
			-- print a message related to the current makefile, with line number
		do
			print_file_message (in_makefile, in_makefile.line_count, a_severity, a_msg + ":%N%T%"" + in_makefile.last_string + "%"%N")
		end

	print_file_message (a_file: ES5SH_TEXT_FILE; a_line_number: INTEGER; a_severity: STRING; a_msg: STRING) is
			-- print a file-related message, with line number
		do
			print_output_message (a_severity + ": " + a_file.name + " line " + a_line_number.out + ": " + a_msg)
		end; -- print_file_message

	print_output_prefix: STRING is
		once
				Result := pretty_name
		end

	print_output_message (msg: STRING) is
				-- write message to stdout, prefixed by facility (program) name
		do
			print (pretty_name + ": " + msg)
		end; -- print_output_message

	printable_value (a_val: STRING): STRING is
			-- printable value of string; "<Void>" if non-existent, "blank" if empty
		do
			if a_val = Void then
				Result := "<Void>"
			elseif a_val.is_empty then
				Result := "<blank>"
			else
				Result := a_val
			end
		ensure
			result_nonblank: Result /= Void and then not Result.is_empty
		end

	print_usage is
			-- print Usage: message. Use pretty_name to avoid full VMS path in command_name.
		once
			print ("Usage: " + pretty_name + " [ <options> ] [ <path> ] %N" +
"{	
  <path> is path of [..F_code or [..W_code] directory to process
  <options> is one or more of:
    -h output this message (inhibit other processing)
    -m make system (compile/link generated code)
    -c <configuration_file> (default: ISE_EIFFEL:[studio.config.$ISE_PLATFORM]config.eif)
    -l generate object libraries (.OLB) in subdirectories
    -o generate object files (.OBJ) in subdirectories
    -t test (suppress Makefile generation and make)
    -v verbose output 
    -z bypass big_file (concatenated source file) generation
nb: -l and -o are mutually exclusive; the default is
}" )
		if generate_object_libraries_default then
			print (" -l (generate object libraries).%N%N")
		else
			print (" -o (generate object files).%N%N")
		end
	end; -- print_usage

	print_help is
		local
			l_pretty: STRING
		once
			l_pretty := pretty_name + " "
			print_usage
			print (l_pretty + "[ 
					is an Eiffel utility that helps to build an Eiffel system.
					It runs as part of the FINISH_FREEZING process, which builds the
					intermediate (C) code generated by the Eiffel compiler when freezing
					freezing or finalizing, and creates an executable image.
				]" + "%N%N" + l_pretty + "[ 
					is normally invoked by the FINISH_FREEZING.COM (DCL command procedure), which is
					invoked by the Eiffel compiler after generating intermediate code, to build the system.
				]" + "%N%N" + l_pretty + "[ 
					generates Makefiles from the Makefile.SH (shell script) files produced
					by the Eiffel compiler, concatenates the generated intermediate files 
					in each subdirectory into a single file, then makes (builds) the system.
					
					By default (no arguments or options), 
				]" + l_pretty + "[
					will generate Makefiles	
					in the current working directory, using the configuration file
						ISE_EIFFEL:[studio.config.$(ISE_PLATFORM)]config.eif
					and then build the system.
				]" + "%N")
		end; -- print_help

feature {NONE} -- Implementation


end -- class ES5SH_COMMON

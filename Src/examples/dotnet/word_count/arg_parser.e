indexing
	description: "Argument parser"
	external_name: "ISE.Examples.WordCount.ArgParser"
	
deferred class
	ARG_PARSER

inherit
	STATICS

feature {NONE} -- Initialization

	make_case_insensitive_default_switch (s: ARRAY [STRING]) is
		indexing
			description: "[Default to case-insensitive switches and%
						%default to %"/%" and %"-%" as the only valid switch characters.]"
			external_name: "MakeCaseInsensitiveDefaultSwitch"
		require
			non_void_symbols: s /= Void
		do
			make (s, False, <<"/", "-">>)
		end

	make_default_switch (s: ARRAY [STRING]; cs: BOOLEAN) is
		indexing
			description: "Default to %"/%" and %"-%" as the only valid switch characters."
			external_name: "MakeDefaultSwitch"
		require
			non_void_symbols: s /= Void
		do
			make (s, case_sensitive, <<"/", "-">>)
		end
	
	make (s: ARRAY [STRING]; cs: BOOLEAN; sw: ARRAY [STRING]) is
		indexing
			description: "No defaults"
			external_name: "Make"
		require
			non_void_symbols: s /= Void
			non_void_switches: sw /= Void
		do
			symbols := s
			case_sensitive := cs
			switches := sw
		ensure
			symbols_set: symbols = s
			case_sensitive_set: case_sensitive = cs
			switches_set: switches = sw
		end

feature -- Access

	symbols: ARRAY [STRING]
		indexing
			description: "Command line symbols"
			external_name: "Symbols"
		end
	
	case_sensitive: BOOLEAN
		indexing
			description: "Should the symbol matching be case-sensitive?"
			external_name: "CaseSensitive"
		end
	
	switches: ARRAY [STRING]
		indexing
			description: "Command line switches"
			external_name: "Switches"
		end

feature -- Basic Operations

	usage (error_info: STRING) is
		indexing
			description: "[Display application usage description.%
						%`error_info' is equal to illegal switch in command line, if any.]"
		require
	--		valid_error_info: error_info /= Void implies array.index_of_array_object (switches, error_info) >= 0
		deferred
		end

	parse (args: ARRAY [STRING]): BOOLEAN is
		indexing
			description: "Parse arbitrary set of arguments. Return `True' if successful."
			external_name: "Parse"
		require
			non_void_args: args /= Void
		local
			arg_num: INTEGER
			is_switch, is_legal_switch: BOOLEAN
			ss: INTEGER
			n: INTEGER
		do
			from
				ss := No_error
				arg_num := 1
			until
				ss /= No_error or arg_num >= args.count
			loop
				is_switch := False
				from
					n := 0
				until
					is_switch or n >= switches.count
				loop
					is_switch := string.compare_ordinal_string_int32 (args.item (arg_num), 0, switches.item (n), 0, 1) = 0
					n := n + 1
				end
				if is_switch then
					-- Does the switch begin with a legal switch symbol?
					is_legal_switch := False
					from
						n := 0
					until
						is_legal_switch or n >= symbols.count
					loop
						if case_sensitive then
							is_legal_switch := string.compare_ordinal_string_int32 (args.item (arg_num), 1, symbols.item (n), 0, symbols.item (n).get_length) = 0
						else
							is_legal_switch := string.compare_ordinal_string_int32 (args.item (arg_num).to_upper, 1, symbols.item (n).to_upper, 0, symbols.item (n).get_length) = 0
						end
						n := n + 1
					end
					if not is_legal_switch then
						ss := Error
					else
						check
							valid_index: n > 0 and n < symbols.count
						end
						if case_sensitive then
							ss := switch_value (symbols.item (n - 1), args.item (arg_num).substring (1 + symbols.item (n - 1).get_length))
						else
							ss := switch_value (symbols.item (n - 1).to_lower, args.item (arg_num).substring (1 + symbols.item (n - 1).get_length))
						end
					end
				else
					ss := non_switch_value (args.item (arg_num))
				end
				if ss = No_error then
					arg_num := arg_num + 1
				end
			end
			if ss = No_error then
				-- No error occurred while parsing, let derived class perform a 
				-- sanity check and return an appropraite status
				ss := process_post_parsing
			end
			if ss = show_usage then
				usage (Void)
			end
			if ss = Error then
				if arg_num = args.count then
					usage (Void)
				else
					usage (args.item (arg_num))
				end
			end
			Result := ss = No_error
		end
		
feature {NONE} -- Implementation

	switch_value (symbol, value: STRING): INTEGER	is
			-- By default, return an error
		require
			non_void_symbol: symbol /= Void
			non_void_value: value /= Void
		do
			Result := Error
		ensure
			valid_result: Result = No_error or Result = Error or Result = Show_usage
		end
		
	non_switch_value (value: STRING): INTEGER is
			-- By default, return an error
		require
			non_void_value_value: value /= Void
		do
			Result := Error
		ensure
			valid_result: Result = No_error or Result = Error or Result = Show_usage
		end
		
	process_post_parsing: INTEGER is
			-- By default, return an error
		do
			Result := Error
		ensure
			valid_result: Result = No_error or Result = Error or Result = Show_usage
		end

end -- class ARG_PARSER



deferred class
	ARG_PARSER

inherit
	STATICS

feature {NONE} -- Initialization

	make_case_insensitive_default_switch (s: ARRAY [STRING]) is
			-- Default to case-insensitive switches and
			-- default to "/" and "-" as the only valid switch characters.
		require
			non_void_symbols: s /= Void
		do
			make (s, False, <<"/", "-">>)
		end

	make_default_switch (s: ARRAY [STRING]; cs: BOOLEAN) is
			-- Default to "/" and "-" as the only valid switch characters.
		require
			non_void_symbols: s /= Void
		do
			make (s, case_sensitive, <<"/", "-">>)
		end
	
	make (s: ARRAY [STRING]; cs: BOOLEAN; sw: ARRAY [STRING]) is
			-- No defaults
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
			-- Command line symbols
	
	case_sensitive: BOOLEAN
			-- Should the symbol matching be case-sensitive?
	
	switches: ARRAY [STRING]
			-- Command line switches

feature -- Basic Operations

	usage (error_info: STRING) is
			-- Display application usage description.
			-- `error_info' is equal to illegal switch in command line, if any.
		require
	--		valid_error_info: error_info /= Void implies array.IndexOf_System_Array_System_Object (switches, error_info) >= 0
		deferred
		end

	parse (args: ARRAY [STRING]): BOOLEAN is
			-- Parse arbitrary set of arguments.
			-- Return `True' if successful.
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
					is_switch := string.CompareOrdinal_System_String_System_Int32 (args.item (arg_num), 0, switches.item (n), 0, 1) = 0
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
							is_legal_switch := string.CompareOrdinal_System_String_System_Int32 (args.item (arg_num), 1, symbols.item (n), 0, symbols.item	(n).count) = 0
						else
							is_legal_switch := string.CompareOrdinal_System_String_System_Int32 (args.item (arg_num).ToUpper, 1, symbols.item (n).ToUpper, 0, symbols.item (n).count) = 0
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
							ss := switch_value (symbols.item (n - 1), args.item (arg_num).Substring_System_Int32 (1 + symbols.item (n - 1).count))
						else
							ss := switch_value (symbols.item (n - 1).ToLower, args.item (arg_num).Substring_System_Int32 (1 + symbols.item (n - 1).count))
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



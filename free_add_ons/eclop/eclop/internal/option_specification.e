indexing
	description: "Specification of a command line option."
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	
class OPTION_SPECIFICATION
	
inherit
	COMPARABLE
	
creation
	{COMMAND_LINE_SYNTAX} make
   
feature {NONE} -- Initialization
	
	make (spec: STRING) is
			-- Create a new option specification from the textual
			-- specification `spec'. 
		require
			spec_not_void: spec /= Void
			spec_not_empty: spec.count > 0
		do
			specification := spec.twin
			create {LINKED_LIST [OPTION_SPECIFICATION]} exclusive_options.make
			parse
		end
      
feature {COMMAND_LINE_PARSER, COMMAND_LINE_SYNTAX, OPTION_SPECIFICATION, PARSED_COMMAND_LINE_ARGUMENT} -- Access
	
	is_valid: BOOLEAN is
			-- Is this specification valid?
		do
			Result := (invalid_reason = Void)
		end
	
	invalid_reason: STRING
			-- If invalid, this is the reason
	
	invalid_position: INTEGER
			-- If invalid, this is the position in the textual
			-- specification that it is invalid
	
	specification: STRING
			-- The textual form of the specification
	
	matches_name (s: STRING): BOOLEAN is
			-- Does `s' match either the short_name' or the `long_name'?
		require
			s_not_void: s /= Void
		do
			if has_short_name then
				if s.is_equal (short_name) then
					Result := True
				end
			end
			if not Result and has_long_name then
				if s.is_equal (long_name) then
					Result := True
				end
			end
		end
	
	has_abbreviation (s: STRING): BOOLEAN is
			-- Can the option name be abbreviated with `s'?
		require
			s_not_void: s /= Void
			has_long_name: has_long_name
		local
			i: INTEGER
		do
			i := long_name.fuzzy_index (s, 1, s.count)
			if i = 1 then
				Result := True
			end
		end
		
	name: STRING is
			-- Short name if it exists, otherwise the long name
		do
			if has_short_name then
				Result:= short_name
			else
				Result := long_name
			end
		end
	
	has_short_name: BOOLEAN is
			-- Does this option have a short name?
		do
			Result := short_name /= Void
		end
		
	short_name: STRING
			-- The short name
	
	has_long_name: BOOLEAN is
			-- Does this option have a long name?
		do
			Result := long_name /= Void
		end
	
	long_name: STRING
			-- The long name
	
	is_required: BOOLEAN
			-- Is it a required command line option?
	
	has_optional_argument: BOOLEAN
			-- Does it take an optional argument(s)? 
	
	has_required_argument: BOOLEAN
			-- Does it take a required argument(s)?
	
	has_argument_name: BOOLEAN is
			-- Does it have an option argument name?
		do
			Result := (argument_name /= Void)
		end
	
	argument_name: STRING
			-- The name of the option argument
	
	has_description: BOOLEAN is
			-- Is there a description?
		do
			Result := description /= Void
		end
	
	description: STRING
			-- Description
	
	is_mutually_exclusive: BOOLEAN is
			-- Is this an mutually exclusive option?
		do
			Result := exclusive_options /= Void
		end
	
	is_exclusive_with (od_name: STRING): BOOLEAN is
			-- Is this option exclusive with the option named
			-- `od_name'? 
		require
			od_name_not_void: od_name /= Void
			od_name_not_empty: od_name.count > 0
		do
			from
				exclusive_options.start
			until
				Result or exclusive_options.after
 			loop
				Result := exclusive_options.item.name.is_equal (od_name)
				exclusive_options.forth
			end
		end
		
feature {MUTUAL_EXCLUSIVITY_SPECIFICATION, OPTION_SPECIFICATION}-- Status setting	
	
	set_mutually_exclusive_with (os: like current) is
			-- Make this option mutually exclusive with `os'.
		require
			os_not_void: os /= Void
		do
			exclusive_options.extend (os)
			if not os.is_exclusive_with (name) then
				os.set_mutually_exclusive_with (Current)
			end
		ensure
			is_exclusive_with_os: is_exclusive_with (os.name)
			mutual_exclusivity: os.is_exclusive_with (name)
		end
	
feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN is
		local
			s1, s2: STRING
		do
			if has_short_name or has_long_name then
				s1 := name.twin
				s1.to_lower
				s1.prune_all_leading ('-')
			else
				s1 := ""
			end
			if other.has_short_name or other.has_long_name then
				s2 := other.name.twin
				s2.to_lower
				s2.prune_all_leading ('-')
			else
				s2 := ""
			end
			Result := (s1 < s2)
		end	
	
feature {NONE} -- Implementation
	
	exclusive_options: LIST [like Current] 
			-- List of options with which this option is mutually
			-- exclusive 
	
	parse is
			--  Parse the textual `specification'.
		require
			specification_not_void: specification /= Void
		local
			i: INTEGER
			name_and_rules_part: STRING
			names_part: STRING
			rules_part: STRING
		do
			-- Everything precceding the first '#' is regarded as
			-- the name and rules part and everything coming after
			-- is regarded description part 
			i := specification.index_of ('#', 1)
			if i > 0 then
				name_and_rules_part := specification.substring (1, i - 1)
				description := specification.substring (i + 1, specification.count)
			else
				name_and_rules_part := specification.twin
			end
			
			-- Everything preeceding the first '!' or '=',
			-- whichever comes first, is regarded as the names part
			-- and everything coming after is regarded as the rules
			-- part 
			i := first_occurance_of ("!=", name_and_rules_part, 1)
			if i > 0 then
				names_part := name_and_rules_part.substring (1, i - 1)
				rules_part := name_and_rules_part.substring (i, name_and_rules_part.count)
			else
				names_part := name_and_rules_part
			end
			
			parse_names_part (names_part)
			if rules_part /= Void then
				parse_rules_part (rules_part, i + 1)
			end
		end
	
	parse_names_part (s: STRING) is
			-- Parse the names part `s'.
		require
			s_not_void: s /= Void 
			s_not_empty: s.count > 0
		local
			i: INTEGER
			names: LIST [STRING]
		do
			names := s.split (',')
			inspect names.count
			when 1 then
				parse_name (names @ 1, 1)
			when 2 then
				parse_name (names @ 1, 1)
				i := s.index_of (',', 1)
				parse_name (names @ 2, i + 1)
			else -- >= 3
         			invalid_reason := "Only one ',' character allowed to separate the short name from the long name."
				i := s.index_of (',', 1)
				i := s.index_of (',', i)
				invalid_position := i
			end
		end
	
	parse_name (s: STRING; pos: INTEGER) is
			-- Parse the name `s'. `pos' denotes the starting index
			-- of the name in the textual specification. It is used
			-- for error messages.
		require
			s_not_void: s /= Void 
			s_not_empty: s.count > 0
			pos_positive: pos > 0
		local
			i: INTEGER
		do
			if s @ 1 = '-' then
				if s @ 2 = '-' then
					-- We have a potential long
					-- name. Lets just check the
					-- characters 
					i := index_of_non_alphanumerichyphen_character (s) 
					if i = 0 then
						if not has_long_name then
							long_name := s
						else
							invalid_reason := "Two long option names specified for the same option"
							invalid_position := pos + i - 1
						end
					else
						invalid_reason := "Long option name contains invalid character(s)"
						invalid_position := pos + i - 1
					end
				else
					-- We have a potential short name. 
					if s.count = 2 and then ((s @ 2).is_alpha or (s @ 2).is_digit) then
						if not has_short_name then
							short_name := s
						else
							invalid_reason := "Two short option names specified for the same option"
							invalid_position := pos
						end
					else
						invalid_reason := "Short option name can only contain a single alphanumeric character"
						invalid_position := pos + 1
					end
				end
			else
				invalid_reason := "Option name must begin with a '-' character."
				invalid_position := pos 			
			end
		end
	
	old_parse_rules_part (s: STRING; pos: INTEGER) is
			-- Parse the rule `s'. `pos' denotes the starting index
			-- of the name in the textual specification. It is used
			-- for error messages.
		require
			s_not_void: s /= Void 
			s_not_empty: s.count > 0
			pos_positive: pos > 0
		do
			if s.is_equal ("!") then
				is_required := True
			elseif s.is_equal ("=") then
				has_optional_argument := True
			elseif s.is_equal ("!=") then
				is_required := True
				has_optional_argument := True
			elseif s.is_equal ("=!") then
				has_required_argument := True
			elseif s.is_equal ("!=!") then
				is_required := True
				has_required_argument := True
			else
				invalid_reason := "Invalid characters in qualifiers part of option specification."
				invalid_position := pos
			end
		end	
	
	parse_rules_part (s: STRING; pos: INTEGER) is
			-- Parse the rule `s'. `pos' denotes the starting index
			-- of the name in the textual specification. It is used
			-- for error messages.
		require
			s_not_void: s /= Void 
			s_not_empty: s.count > 0
			pos_positive: pos > 0
		do
			if s @ 1 = '!' then
				is_required := True			
				if s.count > 1 then
					if s @ 2 = '=' then
						has_optional_argument := True
						if s.count > 3 then
							if s @ 3 = '!' then
								has_optional_argument := False
								has_required_argument := True
							else
								parse_argument_name (s, 3, pos)
							end
						end
					else
						invalid_reason := "Invalid characters in qualifiers part of option specification."
						invalid_position := pos + 1
					end
				end
			elseif s @ 1 = '=' then
				has_optional_argument := True
				if s.count > 1 then
					if s @ 2 = '!' then
						has_optional_argument := False
						has_required_argument := True
					else
						parse_argument_name (s, 2, pos)
					end
				end
			end
		end	
	
	parse_argument_name (s: STRING; i, pos: INTEGER) is
			-- Parse the argument name from `s' beginning at
			-- `i'. `pos' denotes the starting index of the name in
			-- the textual specification. It is used for error
			-- messages. 
		require
			s_not_void: s /= Void
			s_has_valid_size: s.count >= i
		local
			k: INTEGER
		do
			k := s.index_of ('!', i)
			if k > 0 then
				-- '!' character must be last character
				if k = s.count then
					has_optional_argument := False
					has_required_argument := True
					argument_name := s.substring (i, k - 1)
				else
					invalid_reason := "Invalid characters in argument name part of option specification."
					invalid_position := pos + k + 1
				end
			else
				argument_name := s.substring (i, s.count)
			end
		end
	
feature {NONE} -- Implementation (Utility)
	
	first_occurance_of (char_set, s: STRING; start: INTEGER): INTEGER is
			-- The position in `s' where the first occurance of any
			-- character in `char_set' is found. Scanning begins at
			-- position `start' in `s'. Returns 0 if no occurance
			-- is found
		require
			char_set_not_void: char_set /= Void
			char_set_not_empty: char_set.count > 0
			s_not_void: s /= Void
			start_is_positive: start >= 1
		local
			i, j: INTEGER 
		do
			from
				i := 1
			until 
				i > char_set.count
			loop
				j := s.index_of (char_set @ i, 1)
				if j > 0 and (j < Result or Result = 0) then
					Result := j
				end
				i := i + 1
			end
		ensure
			non_negative_result: Result >= 0
		end
	
	index_of_non_alphanumerichyphen_character (s: STRING): INTEGER is
			-- Index of first non-alphanumeric or non-hyphen
			-- character in `s'. Returns 0 if none found.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				Result > 0 or else i > s.count
			loop
				if not (s @ i).is_alpha and then not (s @ i).is_digit and then (s @ i) /= '-' then
					Result := i
				else
					i := i + 1
				end
			end
		end
	
end -- class OPTION_SPECIFICATION

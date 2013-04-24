note

	description:
		"Access to information provided by a user through an HTML form. This %
		%class may be used as ancestor by classes needing its facilities."
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CGI_INTERFACE

inherit
	CGI_ENVIRONMENT

	BASIC_ROUTINES
		export
			{NONE} all
		end

	CGI_FORMS

	CGI_ERROR_HANDLING

feature -- Initialization

	make
			-- Initiate input data parsing and process information.
		local
			retried: BOOLEAN
		do
			if not retried then
				parse_input
				execute
			else
				create form_data.make (0)
				if debug_mode then
					handle_exception
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Miscellanous

	execute
			-- Process user provided information.
		deferred
		end

	set_environment
			-- Set environment variable to user value.
		do
		end

feature {CGI_INTERFACE} -- Access	

	debug_mode: BOOLEAN
			-- Is Current application executed in debug mode?
		deferred
		end

feature {CGI_FORMS}-- Access

	form_data: HASH_TABLE [LINKED_LIST [STRING], STRING]
			-- User provided data.

	hexa_to_ascii (s: STRING)
			-- Replace %xy by the corresponding ASCII character.
		local
			c, c1, c2: CHARACTER;
			new: STRING;
			i: INTEGER
		do
			create new.make (s.count)
			from
				i := 1
			until
				i > s.count
			loop
				c := s.item (i)
				if c = '%%' then
					if s.valid_index (i + 1) and s.valid_index (i + 2) then
						c1 := s.item (i + 1)
						c2 := s.item (i + 2)
						if is_valid_hexa_character (c1) and is_valid_hexa_character (c2) then
							c := charconv (16 * hexa_value (c1) + hexa_value (c2))
							i := i + 2
						end
					end
				end
				new.append_character (c)
				i := i + 1
			end
			s.make_from_string (new)
		end

	is_valid_hexa_character (c: CHARACTER): BOOLEAN
			-- Is `c' a valid hexadecimal character
			-- (and uppercase if it is alphabetic)?
		local
			l_upper: CHARACTER
		do
			l_upper := c.as_upper
			Result := (l_upper >= '0' and l_upper <= '9') or (l_upper >= 'A' and l_upper <= 'F')
		end

	hexa_value (c: CHARACTER): INTEGER
			-- Hexadecimal value of a character from the hexa alphabet.
		require
			valid_hexa_character: is_valid_hexa_character (c)
		do
			inspect
				c.as_upper
			when '0'..'9' then
				Result := c.code - ('0').code
			when 'A'..'F' then
				Result := c.code - ('A').code + 10
			end
		end

	Input_data: STRING
			-- Data sent by the server.
		local
			l_result: detachable STRING
		once
				-- Default method is "GET".
			if Request_method.is_equal ("POST") then
				if Content_length.is_empty then
					create Result.make_empty
				elseif Content_length.is_integer then
					stdin.read_stream (Content_length.to_integer)
					l_result := stdin.last_string
						-- Per postcondition of `stdin.read_stream'.
					check l_result_attached: l_result /= Void end
					Result := l_result
				else
					create Result.make_empty
					raise_error ("Incorrect value for CONTENT_LENGTH")
				end
			else
				Result := Query_string
			end
		ensure
			input_data_exists: Result /= Void
		end

	insert_pair (name, val: STRING)
			-- Insert pair (name,value) into form_data; take care of collisions.
		do
				-- Convert strings to plain ASCII
			hexa_to_ascii (name)
			hexa_to_ascii (val)
			insert_pair_without_encoding (name, val)
		end

	insert_pair_without_encoding (name, val: STRING)
			-- Insert pair (name,value) into form_data; take care of collisions.
		local
			vl: LINKED_LIST [STRING]
		do
				-- Is there already a value for `name'?
			if form_data.has (name) and then attached {LINKED_LIST [STRING]} form_data.item (name) as l_list then
				l_list.extend (val)
				l_list.start
			else
				create vl.make
				vl.extend (val)
				vl.start
				form_data.put (vl, name)
			end
		end

	parse_arguments (args: ARRAY[STRING])
			-- Parse arguments array and set environment variables.
		local
			i, sep_index: INTEGER
			lh, rh, l_item: STRING
		do
			from
				i := args.lower
			until
				i > args.upper
			loop
				l_item := args.item (i)
				sep_index := l_item.index_of ('=', 1)
				if sep_index > 1 then
					lh := l_item.substring (1, sep_index - 1)
					if sep_index < l_item.count then
						rh := l_item.substring (sep_index + 1, l_item.count)
					else
						rh := ""
					end
					set_environment_variable (lh, rh)
				end;
				i := i + 1
			end
		end

	parse_input
			-- Split input string and build (name,value) pairs.
		do
			parse_urlencoded_input
		end

	parse_urlencoded_input
			-- Split input string and build (name,value) pairs.
		local
			data, pair, key, val: STRING;
			nb_pairs, c, sep_index, field_sep_index: INTEGER;
			done: BOOLEAN
		do
			data := Input_data.twin
			if not data.is_empty then
					-- Convert +'s to spaces
				data.replace_substring_all ("+", " ")

					-- Build the (name,value) pairs
				nb_pairs := data.occurrences (Pair_separator) + 1
				create form_data.make (nb_pairs)
				from
					c := 1
				until
					done or else c > data.count
				loop
					sep_index := data.index_of (Pair_separator, c)
					if sep_index = 1 then
						c := 2
					else
						if sep_index = 0 then
								-- Last pair reached
							pair := data.substring (c, data.count)
							done := True
						else
							pair := data.substring (c, sep_index - 1)
						end
						field_sep_index := pair.index_of (Value_separator, 1)
						key := pair.substring (1, field_sep_index - 1)
						if pair.count >= field_sep_index + 1 then
							val := pair.substring (field_sep_index + 1, pair.count)
						else
							val := ""
						end
						insert_pair (key, val)
						c := sep_index + 1
					end
				end
			else
				create form_data.make (0)
			end
		end

feature {NONE} -- Implementation constants

	Pair_separator: CHARACTER = '&'
			-- Name / value pairs separator.

	Value_separator: CHARACTER = '=';
			-- Name / value separator.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CGI_INTERFACE


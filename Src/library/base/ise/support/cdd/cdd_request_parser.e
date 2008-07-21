indexing
	description: "Parser for language understood by cdd interpreter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_REQUEST_PARSER

feature {NONE} -- Initialization

	make is
			-- Create new request parser.
		do
			create last_string.make (100)
		end

feature -- Access

	input: STRING
			-- Input string

feature -- Status

	position: INTEGER
			-- Current position in input string

	has_error: BOOLEAN
			-- Has an error occured while parsing?

	end_of_input: BOOLEAN is
			-- Has parsing reached end of input?
		require
			input: input /= Void
		do
			Result := position > input.count
		ensure
			definition: Result = (position > input.count)
		end

feature -- Status Setting

	set_input (an_input: like input) is
			-- Make `an_input' the new `input'.
		require
			an_input_not_void: an_input /= Void
		do
			input := an_input
			position := 1
			has_error := False
		ensure
			input_set: input = an_input
			position_initialized: position = 1
			no_error: not has_error
		end

feature -- Parsing

	parse is
			-- Parse input and call corresponing handler routines (`report_*').
		require
			input: input /= Void
			no_error: not has_error
		local
			l_class_name: STRING
			l_feature_name: STRING
		do
			if end_of_input then
				report_and_set_error_at_position ("Expected something, not end of input. Don't be so stingy!", position)
			elseif item = ':' then
				forth
				if end_of_input then
					report_and_set_error_at_position ("Expected meta request ('quit' or 'list'), not end of input.", position)
				else
					if matches (quit_keyword) then
						skip (quit_keyword.count)
						skip_whitespace
						if end_of_input then
							report_quit_request
						else
							report_and_set_error_at_position ("Expected end of input.", position)
						end
					elseif matches (all_keyword) then
						skip (all_keyword.count)
						if end_of_input then
							report_execute_all_test_routines_request
						else
							report_and_set_error_at_position ("Expected end of input.", position)
						end
					elseif matches (list_keyword) then
						skip (list_keyword.count)
						if not end_of_input then
							if not is_whitespace (item) then
								report_and_set_error_at_position ("Expected end of input.", position)
							else
								skip_whitespace
								if not end_of_input then
									parse_identifier
									if has_error then
										report_and_set_error_at_position ("Expected valid class name.", position)
									else
										report_list_of_class_request (last_string)
									end
								else
									report_list_test_classes_request
								end
							end
						else
							report_list_test_classes_request
						end
					else
						report_and_set_error_at_position ("Unknown meta request.", position)
					end
				end
			else
				parse_identifier
				if not has_error then
					l_class_name := last_string.twin
					skip_whitespace
					if not end_of_input then
						if item = '.' then
							forth
							parse_identifier
							if not has_error then
								l_feature_name := last_string.twin
								report_execute_test_routine_request (l_class_name, l_feature_name)
							end
						else
							report_and_set_error_at_position ("Expected '.' but got " + item.out, position)
						end
					else
						report_execute_test_class_request (l_class_name)
					end
				end
			end
		end

feature {NONE} -- Parsing

	parse_identifier is
			-- Parse next identifier ([A-Za-z][A-Za-z_0-9]*) and make it available via `last_string' or
			-- set error if no identifier could be parsed.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
		do
			last_string.wipe_out
			if not is_letter (item) then
				report_and_set_error_at_position ("Expected letter but got '" + item.out + "'.", position)
			else
				from
					last_string.append_character (item)
					forth
				until
					end_of_input or else not is_letter_number_underscore (item)
				loop
					last_string.append_character (item)
					forth
				end
			end
		ensure
			error_or_identifier: not has_error implies is_valid_identifier (last_string)
		end

feature {NONE} -- Error Reporting

	report_error (a_reason: STRING) is
			-- Report error `a_reason'.
		require
			a_reason_not_void: a_reason /= Void
			a_reason_not_empty: not a_reason.is_empty
		deferred
		end

	report_and_set_error (a_reason: STRING) is
			-- Report error `a_reason' and set `has_error'.
		require
			a_reason_not_void: a_reason /= Void
			a_reason_not_empty: not a_reason.is_empty
		do
			has_error := True
			report_error (a_reason)
		ensure
			has_error: has_error
		end

	report_and_set_error_at_position (a_reason: STRING; a_position: INTEGER) is
			-- Report error `a_reason' at position `a_position' and set `has_error'.
		require
			a_reason_not_void: a_reason /= Void
			a_reason_not_empty: not a_reason.is_empty
			a_position_valid: a_position > 0 and a_position <= input.count + 1
		do
			report_and_set_error (a_reason + " (pos: " + a_position.out + ")")
		ensure
			has_error: has_error
		end

feature  {NONE}-- Request handling

	report_quit_request is
			-- Resport a "quit" request.
		deferred
		end

	report_list_test_classes_request is
			-- Report a request, that should list all test classes available.
		deferred
		end

	report_list_of_class_request (a_class_name: STRING) is
			-- Report a request, that should list all test routines of test class `a_class_name'.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_valid: is_valid_class_name (a_class_name)
		deferred
		end

	report_execute_all_test_routines_request is
			-- Report a request, that should execute all test routines from all test classes available.
		deferred
		end

	report_execute_test_class_request (a_class_name: STRING) is
			-- Report a request, that should execute all test routines from test class `a_class_name'.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_valid: is_valid_class_name (a_class_name)
		deferred
		end

	report_execute_test_routine_request (a_class_name, a_routine_name: STRING) is
			-- Report a request, that should execute test routine `a_routine_name' from test class `a_test_class'.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_valid: is_valid_class_name (a_class_name)
			a_routine_name_not_void: a_routine_name /= Void
			a_routine_name_valid: is_valid_feature_name (a_routine_name)
		deferred
		end

feature -- Cursor movement

	skip_whitespace is
			-- Move current parsing position to next non whitespace character.
		require
			input: input /= Void
			no_error: not has_error
		do
			from
			until
				end_of_input or else not is_whitespace (item)
			loop
				forth
			end
		ensure
			no_whitespace: not end_of_input implies not is_whitespace (item)
			no_error: not has_error
		end

	skip (n: INTEGER) is
			-- Move current parsing position `n' characters forward
		require
			n_not_negative: n >= 0
		do
			position := position + n
		ensure
			skipped: position = old position + n
		end

	forth is
			-- Move position one character forth
		require
			input: input /= Void
			not_end_of_input: not end_of_input
		do
			position := position + 1
		ensure
			definition: position = old position + 1
		end

feature {NONE} -- Constants

	quit_keyword: STRING is "quit"
			-- Keyword for "quit" request

	list_keyword: STRING is "list"
			-- Keyword for "list" request

	all_keyword: STRING is "all"
			-- Keyword for "all" request

feature -- Lexical validity

	is_valid_class_name (a_class_name: STRING): BOOLEAN is
			-- Is `a_class_name' a valid name for a class?
		require
			a_class_name_not_void: a_class_name /= Void
		local
			i: INTEGER
		do
			Result := not a_class_name.is_empty
			from
				i := 1
			until
				i > a_class_name.count or not Result
			loop
				if
					a_class_name.item (i).is_alpha or
					a_class_name.item (i).is_digit or
					a_class_name.item (i) = '_'
				then
					i := i + 1
				else
					Result := False
				end
			end
		end

	is_valid_feature_name (a_feature_name: STRING): BOOLEAN is
			-- Is `a_feature_name' a valid name for a feature?
		require
			a_feature_name_not_void: a_feature_name /= Void
		local
			i: INTEGER
		do
			Result := not a_feature_name.is_empty
			from
				i := 1
			until
				i > a_feature_name.count or not Result
			loop
				if a_feature_name.item (i).is_alpha or
				a_feature_name.item (i).is_digit or
				a_feature_name.item (i) = '_' then
					i := i + 1
				else
					Result := False
				end
			end
		end

	is_valid_identifier (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid identifier?
			-- TODO: Implement more strict rules ([a-zA-Z][a-zA-Z0-9_]*)
		do
			Result := a_name.count > 0
		end

feature {NONE} -- Implementation

	last_string: STRING

	item: CHARACTER is
			-- Character at current position
		require
			input: input /= Void
			not_end_of_input: not end_of_input
		do
			Result := input.item (position)
		ensure
			definition: Result = input.item (position)
		end

	matches (a_string: STRING): BOOLEAN is
			-- `True' only if the next characters in the input match
			-- `a_string' followed by a non letter or digit or end of intput. Case is irrelevant.
		require
			no_error: not has_error
			input: input /= Void
			not_end_of_input: not end_of_input
		local
			i: INTEGER
			nb: INTEGER
		do
			from
				i := 1
				nb := a_string.count
				Result := True
			until
				has_error or position + i - 1 > input.count or else i > nb
			loop
				if input.item (position + i - 1).as_lower /= a_string.item (i).as_lower then
					Result := False
				end
				i := i + 1
			end
			if i - 1 /= nb then
				Result := False
			elseif not (position + i - 1 > input.count) and then is_letter_number_underscore (input.item (position + i - 1)) then
				Result := False
			end
		end


	is_letter_number_underscore (a_char: CHARACTER): BOOLEAN is
			-- Is `a_char' a letter, a number or an underscore ('_') character?
		do
			Result := True
			inspect a_char
			when 'A'..'Z' then
			when 'a'..'z' then
			when '0'..'9' then
			when '_' then
			else
				Result := False
			end
		end

	is_number (a_char: CHARACTER): BOOLEAN is
			-- Is `a_char' a a number character?
		do
			Result := True
			inspect a_char
			when '0'..'9' then
			else
				Result := False
			end
		end

	is_letter (a_char: CHARACTER): BOOLEAN is
			-- Is `a_char' a letter character?
		do
			Result := True
			inspect a_char
			when 'A'..'Z' then
			when 'a'..'z' then
			else
				Result := False
			end
		end

	is_whitespace (a_char: CHARACTER): BOOLEAN is
			-- Is `a_char' a whitespace character?
		do
			Result := True
			inspect a_char
			when ' ' then
			when '%T' then
			else
				Result := False
			end
		end

invariant
	last_string_not_void: last_string /= Void

end

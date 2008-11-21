indexing
	description: "Parser for requests stored in text form"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_TEXT_REQUEST_PARSER

inherit

	AUT_SHARED_CONSTANTS

	ITP_VARIABLE_CONSTANTS

	ERL_G_TYPE_ROUTINES

	AUT_SHARED_INTERPRETER_INFO

feature{NONE} -- Initialization
	make is
			-- Create new parser.
		do
			create last_string.make (200)
			create last_argument_list.make_with_capacity (100)
		end

feature -- Access

	position: INTEGER
			-- Current position in input string

	input: STRING
			-- Input string

feature -- Status report

	has_error: BOOLEAN
			-- Has an error occured while parsing?

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

	end_of_input: BOOLEAN is
			-- Has parsing reached end of input?
		require
			input: input /= Void
		do
			Result := position > input.count
		ensure
			definition: Result = (position > input.count)
		end

feature -- Lexical validity

	is_valid_identifier (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid identifier?
			-- TODO: Implement more strict rules ([a-zA-Z][a-zA-Z0-9_]*)
		do
			Result := a_name.count > 0
		end

	is_valid_entity_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid variable/feature name?
			-- TODO: Implement more strict rules ([a-zA-Z][a-zA-Z0-9_]*) minus keywords
		do
			Result := a_name.count > 0
		end

	is_valid_type_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid type name?
			-- TODO: Implement more strict rules:
				-- type_name 		:= 	class_name 	| 	class_name gen_list
				-- gen_list 		:=	'[' type_name_list ']'
				-- type_name_list	:=	type_name	|	type_name ',' type_name_list
		do
			Result := a_name.count > 0
		end

	is_input_ready: BOOLEAN is
			-- Is input ready to be parsed?
		do
			Result := input /= Void
		ensure then
			good_result: Result = (input /= Void)
		end

feature -- Parsing

	parse is
			-- Parse input and call corresponing handler routines (`report_*').
		require
			input_ready: input /= Void
			not_has_error: not has_error
		local
			comment_prefix_count: INTEGER
			quit_keyword_count: INTEGER
			type_keyword_count: INTEGER
			execute_keyword_count: INTEGER
		do
			if end_of_input then
				report_and_set_error_at_position ("Expected something, not end of input. Don't be so stingy!", position)
			elseif item = ':' then
				forth
				if end_of_input then
					report_and_set_error_at_position ("Expected meta request ('quit' or 'type'), not end of input.", position)
				else
					quit_keyword_count := quit_keyword.count
					type_keyword_count := type_keyword.count
					execute_keyword_count := execute_keyword.count
					if
							-- Process ":quit" request.
						input.count - 1 = quit_keyword_count and then
						substring (2, 1 + quit_keyword_count).is_case_insensitive_equal (quit_keyword)
					then
						report_quit_request
					elseif
							-- Process ":execute" request.
						input.count > execute_keyword_count and then
						substring (2, 1 + execute_keyword_count).is_case_insensitive_equal (execute_keyword)
					then
						position := position + execute_keyword_count
						if not has_error then
							report_execute_request
						end
					elseif
							-- Process ":type" request.
						input.count > type_keyword_count and then
						substring (2, 1 + type_keyword_count).is_case_insensitive_equal (type_keyword)
					then
						position := position + type_keyword_count
						skip_whitespace
						if end_of_input then
							report_and_set_error_at_position ("Expected type name, not end of input.", position)
						else
							parse_identifier
							if not has_error then
								report_type_request (last_string.twin)
							end
						end
					else
						report_and_set_error_at_position ("Unknown meta request.", position)
					end
				end
			elseif input.is_equal (proxy_has_started_and_connected_message) then
				report_start_request
			else

				skip_whitespace
				comment_prefix_count := comment_prefix.count
				if matches (comment_prefix) then
					-- Process comment.
				else
					report_and_set_error_at_position ("Unrecognized input", position)
				end
			end
		end

feature {NONE} -- Handlers

	report_create_request (a_type_name: STRING; a_target_variable_name: STRING; a_creation_procedure_name: STRING; an_argument_list: ERL_LIST [ITP_EXPRESSION]) is
			-- Report "create" request. Note that a void `a_creation_procedure_name'
			-- represents the default creation procedure.
		require
			a_type_name_not_void: a_type_name /= Void
			a_type_name_valid: is_valid_type_name (a_type_name)
			a_target_variable_name_not_void: a_target_variable_name /= Void
			a_target_variable_name_valid: is_valid_entity_name (a_target_variable_name)
			a_creation_procedure_name_valid: a_creation_procedure_name /= Void implies is_valid_entity_name (a_creation_procedure_name)
			an_argument_list_not_void: an_argument_list /= Void
		deferred
		end

	report_invoke_request (a_target_variable_name: STRING; a_feature_name: STRING; an_argument_list: ERL_LIST [ITP_EXPRESSION]) is
			-- Report an "invoke" request.
		require
			a_target_variable_name_not_void: a_target_variable_name /= Void
			a_target_variable_name_valid: is_valid_entity_name (a_target_variable_name)
			a_feature_name_valid: is_valid_entity_name (a_feature_name)
			an_argument_list_not_void: an_argument_list /= Void
		deferred
		end

	report_invoke_and_assign_request (a_left_hand_variable_name: STRING; a_target_variable_name: STRING; a_feature_name: STRING; an_argument_list: ERL_LIST [ITP_EXPRESSION]) is
			-- Report an "invoke_and_assign" request.
		require
			a_left_hand_variable_name_not_void: a_left_hand_variable_name /= Void
			a_left_hand_variable_name_valid: is_valid_entity_name (a_left_hand_variable_name)
			a_target_variable_name_not_void: a_target_variable_name /= Void
			a_target_variable_name_valid: is_valid_entity_name (a_target_variable_name)
			a_feature_name_valid: is_valid_entity_name (a_feature_name)
			an_argument_list_not_void: an_argument_list /= Void
		deferred
		end

	report_execute_request is
			-- Report execute request.
		deferred
		end

	report_assign_request (a_left_hand_variable_name: STRING; an_expression: ITP_EXPRESSION) is
			-- Report an "assign" request.
		require
			a_left_hand_variable_name_not_void: a_left_hand_variable_name /= Void
			a_left_hand_variable_name_valid: is_valid_entity_name (a_left_hand_variable_name)
			an_expression_not_void: an_expression /= Void
		deferred
		end

	report_type_request (a_variable_name: STRING) is
			-- Report type of object assigned to variable named `a_variable_name'.
		require
			a_variable_name_not_void: a_variable_name /= Void
			a_variable_name_valid: is_valid_entity_name (a_variable_name)
		deferred
		end

	report_quit_request is
			-- Report a "quit" request.
		deferred
		end

	report_start_request
			-- Report a "start" request.
		deferred
		end

feature -- Error reporting

	report_error (a_reason: STRING) is
			-- Report error `a_reason'.
		require
			a_reason_not_void: a_reason /= Void
			a_reason_not_empty: not a_reason.is_empty
		deferred
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
			report_error (a_reason + " (pos: " + a_position.out + ")")
		ensure
			has_error: has_error
		end

feature {NONE} -- Parsing

	parse_create_request is
			-- Parse "create" request and call `report_create_request' or `report_and_set_error'.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
		local
			a_type_name: STRING;
			a_target_variable_name: STRING;
			a_creation_procedure_name: STRING;
		do
			parse_type_name_in_braces
			if not has_error then
				a_type_name := last_string.twin
				if end_of_input then
					report_and_set_error_at_position ("Expected target variable name, not end of input.", position)
				else
					skip_whitespace
					parse_identifier
					if not has_error then
						a_target_variable_name := last_string.twin
						skip_whitespace
						if end_of_input then
							report_create_request (a_type_name,
													a_target_variable_name,
													Void,
													create {ERL_LIST [ITP_EXPRESSION]}.make)
						else
							if item /= '.' then
								report_and_set_error_at_position ("Expected '.', but got '" + item.out + "'.", position)
							else
								forth
								skip_whitespace
								parse_identifier
								if not has_error then
									a_creation_procedure_name := last_string.twin
									skip_whitespace
									if not end_of_input then
										parse_optional_argument_list_in_parethesis
									else
										last_argument_list.wipe_out
									end
									if not has_error then
										report_create_request (a_type_name,
																a_target_variable_name,
																a_creation_procedure_name,
																last_argument_list)
									end
								end
							end
						end
					end
				end
			end
		end

	parse_invoke_or_invoke_and_assign_or_assign_request is
			-- Parse "invoke", "invoke_and_assign", "assign" request and call
			-- corresponding `report_' routines.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
		local
			an_identifier: STRING
		do
			parse_identifier
			if not has_error then
				an_identifier := last_string.twin
				skip_whitespace
				if end_of_input then
					report_and_set_error_at_position ("Expected ':=' or '.', not end of input.", position)
				else
					if item = ':' then
						forth
						if end_of_input then
							report_and_set_error_at_position ("Expected '=', not end of input.", position)
						elseif item = '=' then
							forth
							skip_whitespace
							if end_of_input then
								report_and_set_error_at_position ("Expected right hand side, not end of input", position)
							else
								parse_invoke_and_assign_or_assign_request (an_identifier)
							end
						else
							report_and_set_error_at_position ("Expected '=' but got '" + item.out + "'.", position)
						end
					elseif item = '.' then
						forth
						skip_whitespace
						if end_of_input then
							report_and_set_error_at_position ("Expected feature name, not end of input.", position)
						else
							parse_invoke_request (an_identifier)
						end
					else
						report_and_set_error_at_position ("Expected ':=' or '.' but got '" + item.out + "'.", position)
					end
				end
			end
		end

	parse_invoke_request (a_target_variable_name: STRING) is
			-- Parse "invoke" request with the target variable name
			-- already parsed and being `a_target_variable_name'.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
			a_target_variable_name_not_void: a_target_variable_name /= Void
			a_target_variable_name_not_empty: not a_target_variable_name.is_empty
		local
			a_feature_name: STRING
		do
			parse_identifier
			if not has_error then
				a_feature_name := last_string.twin
				skip_whitespace
				if not end_of_input then
					parse_optional_argument_list_in_parethesis
				else
					last_argument_list.wipe_out
				end
				if not has_error then
					report_invoke_request (a_target_variable_name, a_feature_name, last_argument_list)
				end
			end
		end

	parse_invoke_and_assign_or_assign_request (a_left_hand_variable_name: STRING) is
			-- Parse "invoke_and_assign" request with the left hand side variable variable name
			-- already parsed and being `a_left_hand_variable_name'.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
			a_left_hand_variable_name_not_void: a_left_hand_variable_name /= Void
			a_left_hand_variable_name_not_empty: not a_left_hand_variable_name.is_empty
		local
			an_expression: ITP_EXPRESSION
			a_variable: ITP_VARIABLE
			a_feature_name: STRING
		do
			parse_expression
			if not has_error then
				an_expression := last_expression
				skip_whitespace
				if end_of_input then
					report_assign_request (a_left_hand_variable_name,
											an_expression)
				else
					a_variable ?= an_expression
					if a_variable = Void then
						report_and_set_error_at_position ("Target of feature call must be variable, not constant", position)
					elseif item = '.' then
						forth
						skip_whitespace
						if end_of_input then
							report_and_set_error_at_position ("Expected feature name, not end of input.", position)
						else
							parse_identifier
							if not has_error then
								a_feature_name := last_string.twin
								skip_whitespace
								if not end_of_input then
									parse_optional_argument_list_in_parethesis
								else
									last_argument_list.wipe_out
								end
								if not has_error then
									report_invoke_and_assign_request (a_left_hand_variable_name,
																		a_variable.name (variable_name_prefix),
																		a_feature_name,
																		last_argument_list)
								end
							end
						end
					else
						report_and_set_error_at_position ("Expected '.' but got '" + item.out + "'.", position)
					end
				end
			end
		end

	parse_type_name_in_braces is
			-- Parse type name in braces (e.g.: "{STRING}") and
			-- make resulting type name available via `last_string' or
			-- call any of the `report_and_set_error_*' routines on error.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
		local
			l_type: TYPE_A
		do
			if item /= '{' then
				report_and_set_error_at_position ("Expected '{' but got '" + item.out + "'.", position)
			else
				forth
				if end_of_input then
					report_and_set_error_at_position ("Expected type name, not end of input.", position)
				else
					last_string.wipe_out
					from
					until
						end_of_input or else item = '}'
					loop
						last_string.append_character (item)
						forth
					end
					if end_of_input then
						report_and_set_error_at_position ("Expected '}', not end of input.", position)
					else
						l_type := base_type (last_string.twin)
						if l_type = Void then
							report_and_set_error_at_position ("Unknown type {" + last_string + "}.", position)
						else
							forth
						end
					end
				end
			end
		ensure
			error_or_type_name: not has_error implies (is_valid_type_name (last_string))
		end

	parse_optional_argument_list_in_parethesis is
			-- Parse optional argument list in parenthesis (e.g.: "(1, foo, True)") and
			-- make resulting type name available via `last_argument_list' or
			-- call any of the `report_and_set_error_*' routines on error.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
		local
			open_bracket: BOOLEAN
		do
			last_argument_list.wipe_out
			if item = '(' then
				forth
				open_bracket := True
				if end_of_input then
					report_and_set_error_at_position ("Expected variable name, not end of input.", position)
				else
					from
					until
						has_error or not open_bracket
					loop
						skip_whitespace
						if end_of_input then
							report_and_set_error_at_position ("Expected variable name, not end of input.", position)
						else
							parse_expression
							if not has_error then
								last_argument_list.force_last (last_expression)
								skip_whitespace
								if end_of_input then
									report_and_set_error_at_position ("Expected ')', not end of input.", position)
								elseif item = ')' then
									open_bracket := False
									forth
								elseif item = ',' then
									forth
								else
									report_and_set_error_at_position ("Expected ')' or ',' but got '" + item.out + "'.", position)
									forth
								end
							end
						end
					end
				end
			end
		end

	parse_expression is
			-- Parse expression (e.g: "{INTEGER_8} 7") and
			-- make resulting expression available via `last_expresson' or call
			-- any of the `report_and_set_error_*' routines on error.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
		local
			a_type_name, l_var_name: STRING
		do
			if item = '{' then
				last_string.wipe_out

					-- Get the type part in curly braces.
				forth
				from until
					end_of_input or else item = '}'
				loop
					last_string.append_character (item)
					forth
				end
				if end_of_input then
					report_and_set_error_at_position ("Expected type name, not end of input.", position)
				else
					a_type_name := last_string.twin
					forth
					skip_whitespace
					if end_of_input then
						report_and_set_error_at_position ("Expected constant, not end of input.", position)
					else
						parse_constant_or_variable
						if not has_error then
							if a_type_name.is_case_insensitive_equal ("INTEGER_8") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_integer_8)
								end
							elseif a_type_name.is_case_insensitive_equal ("INTEGER_16") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_integer_16)
								end
							elseif a_type_name.is_case_insensitive_equal ("INTEGER_32") or a_type_name.is_case_insensitive_equal ("INTEGER") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_integer)
								end
							elseif a_type_name.is_case_insensitive_equal ("INTEGER_64") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_integer_64)
								end
							elseif a_type_name.is_case_insensitive_equal ("NATURAL_8") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_natural_8)
								end
							elseif a_type_name.is_case_insensitive_equal ("NATURAL_16") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_natural_16)
								end
							elseif a_type_name.is_case_insensitive_equal ("NATURAL_32") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_natural_32)
								end
							elseif a_type_name.is_case_insensitive_equal ("NATURAL_64") then
								if last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected integer constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_natural_64)
								end
							elseif a_type_name.is_case_insensitive_equal ("BOOLEAN") then
								if last_token /= true_token_code and last_token /= false_token_code then
									report_and_set_error_at_position ("Expected boolean constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_boolean)
								end
							elseif a_type_name.is_case_insensitive_equal ("CHARACTER_8") or a_type_name.is_case_insensitive_equal ("CHARACTER") then
								if last_token /= character_token_code then
									report_and_set_error_at_position ("Expected character constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.item (1))
								end
							elseif a_type_name.is_case_insensitive_equal ("CHARACTER_32") then
								if last_token /= character_token_code then
									report_and_set_error_at_position ("Expected character constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.item (1).to_character_32)
								end
							elseif a_type_name.is_case_insensitive_equal ("REAL_32") or a_type_name.is_case_insensitive_equal ("REAL") then
								if last_token /= double_token_code and last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected real constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_real)
								end
							elseif a_type_name.is_case_insensitive_equal ("REAL_64") or a_type_name.is_case_insensitive_equal ("DOUBLE") then
								if last_token /= double_token_code and last_token /= integer_token_code then
									report_and_set_error_at_position ("Expected double constant but got '" + last_string + "'.", position)
								else
									create {ITP_CONSTANT} last_expression.make (last_string.to_double)
								end
							else
								report_and_set_error_at_position ("Expected basic type but got '" + a_type_name + "'.", position)
							end
						end
					end
				end
			else
				parse_constant_or_variable
				if not has_error then
					inspect last_token
					when character_token_code then
						create {ITP_CONSTANT} last_expression.make (last_string.item (1))
					when double_token_code then
						create {ITP_CONSTANT} last_expression.make (last_string.to_double)
					when false_token_code then
						create {ITP_CONSTANT} last_expression.make (False)
					when identifier_token_code then
						l_var_name := last_string.twin
						if l_var_name.substring (variable_name_prefix.count + 1, l_var_name.count).is_integer then
							create {ITP_VARIABLE} last_expression.make (variable_index (last_string.twin, variable_name_prefix))
						else
							report_and_set_error_at_position ("Invalid variable name.", position)
						end
					when integer_token_code then
						create {ITP_CONSTANT} last_expression.make (last_string.to_integer)
					when true_token_code then
						create {ITP_CONSTANT} last_expression.make (True)
					when void_token_code then
						create {ITP_CONSTANT} last_expression.make (Void)
					when default_pointer_token_code then
						create {ITP_CONSTANT} last_expression.make (default_pointer)
					else
						report_and_set_error_at_position ("Invalid constant or variable.", position)
					end
				end
			end
		ensure
			error_or_type_name: not has_error implies last_expression /= Void
		end

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

	parse_integer is
			-- Parse next integer ([1-9][0-9]*) and make it available via `last_string' or
			-- set error if no integer could be parsed.
		require
			input: input /= Void
			not_end_of_input: not end_of_input
			no_error: not has_error
		do
			last_string.wipe_out
			from
			until
				end_of_input
			loop
				last_string.append_character (item)
				forth
			end
			if not last_string.is_integer then
				report_and_set_error_at_position ("Exprected an integer.", position)
			end
		end

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
				if
					matches (void_keyword) or
					matches (create_keyword) or
					matches (true_keyword) or
					matches (false_keyword) or
					matches (itp_default_pointer_keyword)
				then
					report_and_set_error_at_position ("Expected identifier, but got keyword.", position)
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
			end
		ensure
			error_or_type_name: not has_error implies is_valid_identifier (last_string)
		end

	parse_constant_or_variable is
			-- Read next token. Make result available via `last_string'
			-- and `last_token'. Set `has_error' to `True' if an
			-- error occurs.
		require
			no_error: not has_error
			input: input /= Void
			not_end_of_input: not end_of_input
		do
			last_string.wipe_out
			-- Possible tokens:
			--   double
			--   char
			--   false
			--   integer
			--   identifier
			--   true
			--   void
			inspect item
			when '0'..'9', '-', '.' then
					-- Possible tokens:
					--   integer
					--   double
				if item /= '.' then
					from
						last_string.append_character (item)
						forth
						skip_whitespace
					until
						end_of_input or else not is_number (item)
					loop
						last_string.append_character (item)
						forth
					end
				end
				if not end_of_input and then item = '.' then
					from
						last_string.append_character (item)
						forth
					until
						end_of_input or else not is_number (item)
					loop
						last_string.append_character (item)
						forth
					end
					last_token := double_token_code
					if not end_of_input and then item = 'e' then
						last_string.append_character ('e')
						forth
						if end_of_input then
							report_and_set_error_at_position ("Expected '+' or '-', not end of input.", position)
						elseif item /= '+' and item /= '-' then
							report_and_set_error_at_position ("Expected '+' or '-', not '" + item.out + "'.", position)
						else
							from
								last_string.append_character (item)
								forth
							until
								end_of_input or else not is_number (item)
							loop
								last_string.append_character (item)
								forth
							end
						end
					end
					if not last_string.is_double then
						has_error := True
					end
				else
					last_token := integer_token_code
				end
			when 'f','F' then
					-- Possible tokens:
					--   false
					--   identifier
				if matches (false_keyword) then
					last_token := false_token_code
					parse_string (false_keyword)
				else
					parse_identifier
					if not has_error then
						last_token := identifier_token_code
					end
				end
			when 'd', 'D' then
					-- Possible tokens:
					--	 default_pointer
				if matches (default_pointer_keyword) then
					last_token := default_pointer_token_code
					parse_string (default_pointer_keyword)
				end
			when 'i','I' then
					-- Possible tokens:
					--   itp_default_pointer
					--   identifier
				if matches (itp_default_pointer_keyword) then
					last_token := default_pointer_token_code
					parse_string (itp_default_pointer_keyword)
				else
					parse_identifier
					if not has_error then
						last_token := identifier_token_code
					end
				end
			when 't','T' then
					-- Possible tokens:
					--   true
					--   identifier
				if matches (true_keyword) then
					last_token := true_token_code
					parse_string (true_keyword)
				else
					parse_identifier
					if not has_error then
						last_token := identifier_token_code
					end
				end
			when '%'' then
					-- Possible tokens:
					--   char
				last_token := character_token_code
				parse_character
			when 'v', 'V' then
					-- Possible tokens:
					--   void
					--   identifier
				if matches (void_keyword) then
					last_token := void_token_code
					parse_string (void_keyword)
				else
					parse_identifier
					if not has_error then
						last_token := identifier_token_code
					end
				end
			else
				parse_identifier
				if not has_error then
					last_token := identifier_token_code
				end
			end
		ensure
			valid_character: has_error or (last_token = character_token_code implies (last_string.count = 1))
			valid_double: has_error or (last_token = double_token_code implies last_string.is_double)
			valid_identifier: has_error or (last_token = identifier_token_code implies is_valid_identifier (last_string))
			valid_integer: has_error or (last_token = integer_token_code implies last_string.is_integer_64 or last_string.is_natural_64)
		end

	parse_character is
			-- Parse next token and try to interpret it as character. Make it available via the first item of `last_string'.
			-- Set `has_error' to `True' if an error occurs.
		require
			no_error: not has_error
			input: input /= Void
			not_end_of_input: not end_of_input
			item_is_tick: item = '%''
		local
			code: INTEGER
		do
			last_string.wipe_out
			forth
			if end_of_input then
				report_and_set_error_at_position ("Expected character constant, not end of input.", position)
			elseif item /= '%%' then
				last_string.append_character (item)
			else
				forth
				if end_of_input then
					report_and_set_error_at_position ("Expected escaped character constant, not end of input.", position)
				else
					inspect item
					when 'A' then
						last_string.append_character ('%A')
					when 'B' then
						last_string.append_character ('%B')
					when 'C' then
						last_string.append_character ('%C')
					when 'D' then
						last_string.append_character ('%D')
					when 'F' then
						last_string.append_character ('%F')
					when 'H' then
						last_string.append_character ('%H')
					when 'L' then
						last_string.append_character ('%L')
					when 'N' then
						last_string.append_character ('%N')
					when 'Q' then
						last_string.append_character ('%Q')
					when 'R' then
						last_string.append_character ('%R')
					when 'S' then
						last_string.append_character ('%S')
					when 'T' then
						last_string.append_character ('%T')
					when 'U' then
						last_string.append_character ('%U')
					when 'V' then
						last_string.append_character ('%V')
					when '%%' then
						last_string.append_character ('%%')
					when '%'' then
						last_string.append_character ('%'')
					when '%"' then
						last_string.append_character ('%"')
					when '%(' then
						last_string.append_character ('%(')
					when '%)' then
						last_string.append_character ('%)')
					when '%<' then
						last_string.append_character ('%<')
					when '%>' then
						last_string.append_character ('%>')
					when '/' then
						from
							forth
						until
							end_of_input or else not is_number (item)
						loop
							last_string.append_character (item)
							forth
						end
						if end_of_input then
							report_and_set_error_at_position ("Expected '/' , but got end of input.", position)
						elseif item /= '/' then
							report_and_set_error_at_position ("Expected '/' , but got '" + item.out + "'.", position)
						else
							code := last_string.to_integer
							last_string.wipe_out
								-- TODO: In order to also handle CHARACTER_32 we probably need to make `last_string' a STRING_32 and use `code.to_character_32'
							last_string.append_character (code.to_character_8)
						end
					else
						report_and_set_error_at_position ("Expected character constant, but got '" + item.out + "'.", position)
					end
				end
			end
			forth
			if end_of_input then
				report_and_set_error_at_position ("Expected character constant, not end of input.", position)
			elseif item /= '%'' then
				report_and_set_error_at_position ("Expected ''', not end of input.", position)
			else
				forth
			end
		end

	last_token: INTEGER
			-- Type of last token; See `*_token_code' for possible values.

	character_token_code: INTEGER is unique
			-- Token code for characters

	double_token_code: INTEGER is unique
			-- Token code for doubles

	identifier_token_code: INTEGER is unique
			-- Token code for indentifiers

	integer_token_code: INTEGER is unique
			-- Token code for integers

	false_token_code: INTEGER is unique
			-- Token code for false

	true_token_code: INTEGER is unique
			-- Token code for true

	void_token_code: INTEGER is unique
			-- Token code for void

	default_pointer_token_code: INTEGER is unique
			-- Token code for void

	parse_string (a_string: STRING) is
			-- Read `a_string.count' characters from `input'.
			-- Set `has_error' to `True' if the read string and
			-- `a_string' do not match or end of input is reached
			-- before reading all characters. Case is irrelevant.
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
			until
				has_error or end_of_input or else i > nb
			loop
				if item.as_lower /= a_string.item (i).as_lower then
					has_error := True
				end
				i := i + 1
				forth
			end
			if i - 1 /= nb then
				has_error := True
			end
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

feature {NONE} -- Implementation

	last_string: STRING

	last_expression: ITP_EXPRESSION

	last_argument_list: ERL_LIST [ITP_EXPRESSION]

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

	substring (a_start_index, an_end_index: INTEGER): STRING is
			-- Substring of index from `a_start_index' to `an_end_index'
		require
			input: input /= Void
			valid_start_index: is_valid_position (a_start_index)
			valid_end_index: is_valid_position (an_end_index)
		do
			Result := input.substring (a_start_index, an_end_index)
		end

	is_valid_position (an_index: INTEGER): BOOLEAN is
			-- Is `an_index' a valid position in `index'?
		require
			input: input /= Void
		do
			Result := an_index > 0 and an_index <= input.count
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

	create_keyword: STRING is "create"
			-- 'create' keyword

	quit_keyword: STRING is "quit"
			-- 'quit' keyword

	type_keyword: STRING is "type"
			-- 'type' keyword

	execute_keyword: STRING is "execute"
		-- 'execute' keyword

	default_pointer_keyword: STRING = "default_pointer"
			-- 'default_pointer' keyword

	itp_default_pointer_keyword: STRING is "itp_default_pointer"
			-- 'itp_default_pointer' keyword

	void_keyword: STRING is "void"
			-- 'void' keyword

	true_keyword: STRING is "true"
			-- 'true' keyword

	false_keyword: STRING is "false"
			-- 'false' keyword

	comment_prefix: STRING is "--"
			-- Line comment prefix

invariant

	valid_position: input /= Void implies (position >= 0 and position <= input.count + 1)
	last_string_not_void: last_string /= Void
	last_argument_list_not_void: last_argument_list /= Void


end

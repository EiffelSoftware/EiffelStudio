indexing
	description: "[
		Request language parser for line based Eiffel like interpreter language.
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class AUT_REQUEST_PARSER

inherit

	AUT_TEXT_REQUEST_PARSER
		rename
			make as make_parser
		end

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

	AUT_SHARED_INTERPRETER_INFO

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; an_error_handler: like error_handler) is
			-- Create new parses for requests that deal in `system'.
		require
			a_system_not_void: a_system /= Void
			error_handler_not_void: an_error_handler /= Void
		do
			make_parser
			system := a_system
			error_handler := an_error_handler
			line_number :=1
			filename := "*unknown*"
		ensure
			system_set: system = a_system
			error_handler_set: error_handler = an_error_handler
		end

feature -- Access

	last_request: AUT_REQUEST
			-- Last request parse

	system: SYSTEM_I
			-- system

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	line_number: INTEGER
			-- Line number of currently parsed file

	filename: STRING
			-- Filename of currently parsed file

feature -- Setting

	set_line_number (a_line_number: like line_number) is
			-- Set `line_number' to `a_line_number'.
		require
			a_line_number_positive: a_line_number > 0
		do
			line_number := a_line_number
		ensure
			line_number_set: line_number = a_line_number
		end

	set_filename (a_filename: like filename) is
			-- Set `filename' to `a_filename'.
		require
			a_filename_not_void: a_filename /= Void
		do
			filename := a_filename
		ensure
			filname_set: filename = a_filename
		end

	unset_filename is
			-- Set `filename' to `Void'.
		do
			filename := Void
		ensure
			filename_void: filename = Void
		end

	clear_last_request is
			-- Set `last_request' to Void.
		do
			last_request := Void
		ensure
			last_request_cleared: last_request = Void
		end

feature {NONE} -- Handlers

	report_create_request (a_type_name: STRING;
							a_target_variable_name: STRING;
							a_creation_procedure_name: STRING;
							an_argument_list: ERL_LIST [ITP_EXPRESSION]) is
		local
			receiver: ITP_VARIABLE
			type: TYPE_A
			procedure: FEATURE_I
			argument_list: DS_LINEAR [ITP_EXPRESSION]
		do
			create receiver.make (variable_index (a_target_variable_name, variable_name_prefix))
			type := base_type (a_type_name)
			if type = Void then
				report_error ("Unknown type " + a_type_name + ".")
			elseif type.is_none then
				report_error ("Cannot create object of NONE type.")
			else
				argument_list := arrayed_list_from_erl_list (an_argument_list)
				if a_creation_procedure_name = Void then
					create {AUT_CREATE_OBJECT_REQUEST} last_request.make (system, receiver, type, type.associated_class.default_create_feature, create {DS_LINKED_LIST [ITP_EXPRESSION]}.make)
				else
					procedure := type.associated_class.feature_named (a_creation_procedure_name)
					if procedure = Void then
						report_error ("Unknown procedure `" + a_creation_procedure_name + "' of type " + a_type_name + ".")
					else
						create {AUT_CREATE_OBJECT_REQUEST} last_request.make (system, receiver,
																				type, procedure,
																				argument_list)
					end
				end
			end
		end

	report_invoke_request (a_target_variable_name: STRING;
							a_feature_name: STRING;
							an_argument_list: ERL_LIST [ITP_EXPRESSION]) is
		local
			target: ITP_VARIABLE
			argument_list: DS_LINEAR [ITP_EXPRESSION]
		do
			create target.make (variable_index (a_target_variable_name, variable_name_prefix))
			argument_list := arrayed_list_from_erl_list (an_argument_list)
			create {AUT_INVOKE_FEATURE_REQUEST} last_request.make (system, a_feature_name, target, argument_list)
		end

	report_invoke_and_assign_request (a_left_hand_variable_name: STRING;
										a_target_variable_name: STRING;
										a_feature_name: STRING;
										an_argument_list: ERL_LIST [ITP_EXPRESSION]) is
		local
			receiver: ITP_VARIABLE
			target: ITP_VARIABLE
			argument_list: DS_LINEAR [ITP_EXPRESSION]
		do
			create receiver.make (variable_index (a_left_hand_variable_name, variable_name_prefix))
			create target.make (variable_index (a_target_variable_name, variable_name_prefix))
			argument_list := arrayed_list_from_erl_list (an_argument_list)
			create {AUT_INVOKE_FEATURE_REQUEST} last_request.make_assign (system, receiver,
																			a_feature_name, target,
																			argument_list)
		end

	report_assign_request (a_left_hand_variable_name: STRING;
							an_expression: ITP_EXPRESSION) is
		local
			receiver: ITP_VARIABLE
		do
			create receiver.make (variable_index (a_left_hand_variable_name, variable_name_prefix))
			create {AUT_ASSIGN_EXPRESSION_REQUEST} last_request.make (system, receiver,
																		an_expression)
		end

	report_type_request (a_variable_name: STRING) is
		local
			variable: ITP_VARIABLE
		do
			create variable.make (variable_index (a_variable_name, variable_name_prefix))
			create {AUT_TYPE_REQUEST} last_request.make (system, variable)
		end

	report_quit_request is
		do
			create {AUT_STOP_REQUEST} last_request.make (system)
		end

	report_start_request
			-- Report a "start" request.
		do
			create {AUT_START_REQUEST} last_request.make (system)
			last_request.set_response (create {AUT_NORMAL_RESPONSE}.make (""))
		end

	report_execute_request is
			-- Report execute request.
		local
			create_keyword_count: INTEGER
			comment_prefix_count: INTEGER
		do
			skip_whitespace
			create_keyword_count := create_keyword.count
			comment_prefix_count := comment_prefix.count
			if matches (comment_prefix) then
				 -- Process comment.
			elseif matches (create_keyword) then
				parse_string (create_keyword)
				skip_whitespace
				if end_of_input then
					report_and_set_error_at_position ("Expected open curly brace, not end of input", position)
				else
					parse_create_request
				end
			else
				parse_invoke_or_invoke_and_assign_or_assign_request
			end
		end

feature {NONE} -- Error Reporting

	report_error (a_reason: STRING) is
		do
			error_handler.report_log_parsing_error (filename, line_number, a_reason)
			has_error := True
		end

feature {NONE} -- Implementation

	arrayed_list_from_erl_list (an_erl_list: ERL_LIST [ITP_EXPRESSION]): DS_ARRAYED_LIST [ITP_EXPRESSION] is
		require
			an_erl_list_not_void: an_erl_list /= Void
		local
			i: INTEGER
		do
			from
				i := 1
				create Result.make (an_erl_list.count)
			until
				i > an_erl_list.count
			loop
				Result.force_last (an_erl_list.item (i))
				i := i + 1
			end
		ensure
			arrayed_list_not_void: Result /= Void
		end

invariant

	system_not_void: system /= Void
	error_handler_not_void: error_handler /= Void
	line_number_positive: line_number > 0
	filename_not_void: filename /= Void

end

indexing

	description:

		"Serializes test cases (list of requests) as an Eiffel unit test case"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_TEST_CASE_PRINTER

inherit

	AUT_REQUEST_PROCESSOR

	KL_SHARED_STREAMS
		export {NONE} all end

	AUT_SHARED_TYPE_FORMATTER

	AUT_SHARED_INTERPRETER_INFO

	ERL_CONSTANTS

	ITP_VARIABLE_CONSTANTS

create

	make,
	make_null

feature {NONE} -- Initialization

	make (a_system: like system; an_output_stream: like output_stream) is
			-- Create new request.
		require
			a_system_not_void: a_system /= Void
			an_output_stream_not_void: an_output_stream /= Void
			an_output_stream_is_writable: an_output_stream.is_open_write
		do
			system := a_system
			output_stream  := an_output_stream
			create expression_printer.make (output_stream)
		ensure
			system_set: system = a_system
			output_stream_set: output_stream = an_output_stream
		end

	make_null (a_system: like system) is
			-- Create a new AST printer, initialized with a null output stream.
		do
			make (a_system, null_output_stream)
		ensure then
			output_stream_set: output_stream = null_output_stream
		end

feature -- Access

	system: SYSTEM_I
			-- System

	output_stream: KI_TEXT_OUTPUT_STREAM
			-- Stream that printer writes to

feature -- Status setting

	set_output_stream (an_output_stream: like output_stream) is
			-- Set `output_stream' to `an_output_stream'.
		require
			an_output_stream_not_void: an_output_stream /= Void
		do
			output_stream := an_output_stream
			expression_printer.set_output_stream (output_stream)
		ensure
			output_stream_set: output_stream = an_output_stream
		end

feature -- Basic operations

	print_test_case (a_request_list: DS_LINEAR [AUT_REQUEST]; a_var_list: DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE]) is
			-- Print the request list `a_list' as an Eiffel test case.
		require
			a_request_list_not_void: a_request_list /= Void
			no_request_void: not a_request_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [AUT_REQUEST]
		do
			used_vars := a_var_list
			print_header
			indent
			print_indentation
			print_routine_name
			output_stream.put_line (" is")
			indent
			print_indentation
			output_stream.put_line ("local")
			indent
			if a_var_list /= Void then
				from
					a_var_list.start
				until
					a_var_list.after
				loop
					print_indentation
					output_stream.put_line (a_var_list.key_for_iteration.name (variable_name_prefix) + ": " + a_var_list.item_for_iteration.item (1).out)
					a_var_list.forth
				end
			else
				print_indentation
				output_stream.put_line ("-- TODO: add variable declarations for not failing and not minimized TCs.")
			end
			dedent
			print_indentation
			output_stream.put_line ("do")
			indent
			from
				cs := a_request_list.new_cursor
				cs.start
			until
				cs.off
			loop
				cs.item.process (Current)
				cs.forth
			end
			dedent
			print_indentation
			output_stream.put_line ("end")
			dedent
			dedent
			output_stream.put_new_line
		end

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			-- Do nothing.
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
		do
			-- Do nothing.
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		do
			print_indentation
			output_stream.put_string ("create {")
			output_stream.put_string (type_name (a_request.target_type, a_request.creation_procedure))
			output_stream.put_string ("} ")
			output_stream.put_string (a_request.target.name (variable_name_prefix))
			if not a_request.is_default_create_used then
				output_stream.put_string (".")
				output_stream.put_string (a_request.creation_procedure.feature_name)
				print_argument_list (a_request.argument_list)
			end
			output_stream.put_new_line
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		do
			print_indentation
			if a_request.is_feature_query then
				output_stream.put_string (a_request.receiver.name (variable_name_prefix))
				output_stream.put_character (' ')
				output_stream.put_character (':')
				output_stream.put_character ('=')
				output_stream.put_character (' ')
			end
			output_stream.put_string (a_request.target.name (variable_name_prefix))
			output_stream.put_string (".")
			output_stream.put_string (a_request.feature_name)
			print_argument_list (a_request.argument_list)
			output_stream.put_new_line
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		do
			print_indentation
			output_stream.put_string (a_request.receiver.name (variable_name_prefix))
			output_stream.put_character (' ')
			output_stream.put_character (':')
			output_stream.put_character ('=')
			output_stream.put_character (' ')
			a_request.expression.process (expression_printer)
			output_stream.put_new_line
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		do
			-- Do nothing.
		end

feature {NONE} -- Printing

	print_routine_name
			-- Print new test routine name
		do
			output_stream.put_string ("test")
		end

	print_argument_list (an_argument_list: DS_LINEAR [ITP_EXPRESSION]) is
			-- Print argument list `an_arinstruction' to `output_stream'.
		require
			an_argument_list_not_void: an_argument_list /= Void
			no_argument_void: not an_argument_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			l_var: ITP_VARIABLE
		do
			if an_argument_list.count > 0 then
				output_stream.put_character (' ')
				output_stream.put_character ('(')
				from
					cs := an_argument_list.new_cursor
					cs.start
				until
					cs.off
				loop
					l_var ?= cs.item
					if used_vars /= Void and then l_var /= Void and then used_vars.item (l_var) /= Void and then used_vars.item (l_var).item (1).is_equal (none_type_name) then
							-- Replace variables whose type is NONE by Void
						output_stream.put_string ("Void")
					else
						cs.item.process (expression_printer)
					end
					cs.forth
					if not cs.after then
						output_stream.put_character  (',')
						output_stream.put_character  (' ')
					end
				end
				output_stream.put_character  (')')
			end
		end

	print_header
			-- Print class text before actual test routine.
		do
			output_stream.put_line ("class GENERATED_TEST_CASE")
			output_stream.put_new_line
			output_stream.put_line ("inherit")
			output_stream.put_new_line
			indent
			print_indentation
			output_stream.put_line ("AUT_TEST_CASE")
			dedent
			output_stream.put_new_line
			output_stream.put_line ("feature")
			output_stream.put_new_line
		end

	print_footer
			-- Print class text after actual test routine.
		do
			output_stream.put_line ("end")
			output_stream.put_new_line
		end

feature {NONE} -- Indentation

	indentation: INTEGER
			-- Indentation in `output_stream'

	indent is
			-- Increment indentation.
		do
			indentation := indentation + 1
		end

	dedent is
			-- Decrement indentation.
		do
			indentation := indentation - 1
		end

	print_indentation is
			-- Print indentation to `output_stream'.
		local
			i, nb: INTEGER
		do
			nb := indentation
			from i := 1 until i > nb loop
				output_stream.put_character ('%T')
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	expression_printer: AUT_EXPRESSION_PRINTER
			-- Expression printer

	used_vars: DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE]
			-- Variables used in the instructions of the test case, with their types names recorded as strings

invariant

	system_not_void: system /= Void
	output_stream_not_void: output_stream /= Void
	output_stream_is_writable: output_stream.is_open_write
	expression_printer_not_void: expression_printer /= Void
	valid_expression_printer_output_stream: expression_printer.output_stream = output_stream

end

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

	ERL_G_TYPE_ROUTINES

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

feature {NONE} -- Access

	used_vars: ?DS_HASH_TABLE [TUPLE [type: ?TYPE_A; name: ?STRING; check_dyn_type: BOOLEAN], ITP_VARIABLE]
			-- Set of used variables: keys are variables, items are tuples of static type of variable
			-- and a boolean flag showing if the static type should be checked against dynamic type
			-- (is only the case for variables returned as results of function calls and those whose type
			-- is left Void)

	ot_counter: NATURAL
			-- Counter vor object test locals

feature {NONE} -- Status report

	is_last_request: BOOLEAN
			-- Is current request last in list?

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

feature {NONE} -- Query

	variable_name (a_var: ITP_VARIABLE): STRING
		do
			Result := a_var.name (variable_name_prefix)
		ensure
			result_attached: Result /= Void
		end

	variable_type_name (a_var: ITP_VARIABLE): STRING
			-- Type name of `a_var'.
		local
			l_result: ?like variable_type_name
		do
			if used_vars /= Void then
				used_vars.search (a_var)
				if used_vars.found and then used_vars.found_item.type /= none_type then
					l_result := used_vars.found_item.name.twin
				end
			end
			if l_result = Void then
				Result := "ANY"
			else
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
		end

	variable_type (a_var: ITP_VARIABLE): TYPE_A
			-- Type of `a_var'.
		local
			l_result: ?like variable_type
			l_name: STRING
		do
			if used_vars /= Void then
				used_vars.search (a_var)
				if used_vars.found then
					l_result := used_vars.found_item.type
					if l_result = Void then
						l_name := used_vars.found_item.name
						if l_name.is_equal (none_type_name) then
							l_result := none_type
						else
							l_result := base_type (l_name)
						end
						used_vars.found_item.type := l_result
					end
				end
			end
			if l_result = Void then
				Result := system.any_type
			else
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	print_test_case (a_request_list: DS_BILINEAR [AUT_REQUEST]; a_var_list: like used_vars)
			-- Print the request list `a_list' as an Eiffel test case.
		require
			a_request_list_not_void: a_request_list /= Void
			no_request_void: not a_request_list.has (Void)
		local
			cs: DS_BILINEAR_CURSOR [AUT_REQUEST]
			l_cursor: DS_HASH_TABLE_CURSOR [TUPLE [type: ?TYPE_A; name: ?STRING; check_dyn_type: BOOLEAN], ITP_VARIABLE]
			l_type: TYPE_A
		do
			used_vars := a_var_list
			ot_counter := 1
			print_header
			print_routine_header
			indent
			print_indentation
			output_stream.put_line ("local")
			indent
			if used_vars /= Void then
				l_cursor := used_vars.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					l_type := variable_type (l_cursor.key)
					print_indentation
					output_stream.put_string (variable_name (l_cursor.key))
					output_stream.put_string (": ")
					output_stream.put_string (variable_type_name (l_cursor.key))
					if l_type = none_type then
						output_stream.put_string (" -- Placeholder for queries returning Void")
					end
					output_stream.put_new_line
					l_cursor.forth
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
				is_last_request := cs.is_last
				cs.item.process (Current)
				cs.forth
			end
			dedent
			print_indentation
			output_stream.put_line ("end")
			dedent
			dedent
			output_stream.put_new_line
			used_vars := Void
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
		local
			l_args: ?DS_LINEAR [ITP_EXPRESSION]
			l_type: STRING
			i: INTEGER
		do
			l_args := a_request.argument_list
			l_type := type_name (a_request.target_type, a_request.creation_procedure)
			print_indentation
			output_stream.put_string ("execute_safe (agent")
			if l_args /= Void then
				print_argument_list (l_args, True)
			end
			output_stream.put_string (": ")
			output_stream.put_line (l_type)
			indent
			print_indentation
			output_stream.put_line ("do")
			indent
			print_indentation
			output_stream.put_string ("create {")
			output_stream.put_string (l_type)
			output_stream.put_string ("} Result")
			if not a_request.is_default_create_used then
				output_stream.put_string (".")
				output_stream.put_string (a_request.creation_procedure.feature_name)
				if l_args /= Void and then not l_args.is_empty then
					output_stream.put_string (" (")
					from
						l_args.start
					until
						l_args.after
					loop
						output_stream.put_string ("a_arg")
						output_stream.put_integer (i)
						l_args.forth
						if not l_args.after then
							output_stream.put_string (", ")
						end
					end
					output_stream.put_string (")")
				end
			end
			output_stream.put_new_line
			dedent
			print_indentation
			output_stream.put_string ("end")
			if l_args /= Void then
				print_argument_list (l_args, False)
			end
			output_stream.put_line (")")
			dedent
			print_indentation
			output_stream.put_string ("if {l_ot")
			output_stream.put_integer (ot_counter.to_integer_32)
			output_stream.put_string (": ")
			output_stream.put_string (l_type)
			--output_stream.put_string (variable_type_name (a_request.target))
			output_stream.put_line ("} last_object then")
			indent
			print_indentation
			output_stream.put_string (variable_name (a_request.target))
			output_stream.put_string (" := l_ot")
			output_stream.put_integer (ot_counter.to_integer_32)
			output_stream.put_new_line
			dedent
			print_indentation
			output_stream.put_line ("end")
			ot_counter := ot_counter + 1
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		local
			l_rec_type: TYPE_A
			l_use_ot: BOOLEAN
		do

			if is_last_request then
				output_stream.put_new_line
				indent
				print_indentation
				output_stream.put_line ("-- Final routine call")
				dedent
				print_indentation
				output_stream.put_line ("set_is_recovery_enabled (False)")
			end

			print_indentation
			output_stream.put_string ("execute_safe (agent ")
			output_stream.put_string (variable_name (a_request.target))
			output_stream.put_character ('.')
			output_stream.put_string (a_request.feature_name)
			print_argument_list (a_request.argument_list, False)
			output_stream.put_line (")")

			if a_request.is_feature_query then
				print_indentation
				l_rec_type := variable_type (a_request.receiver)
				l_use_ot := not (l_rec_type.is_basic or l_rec_type.name.is_equal (system.any_type.name))
				if l_use_ot then
					output_stream.put_string ("if {l_ot")
					output_stream.put_integer (ot_counter.to_integer_32)
					output_stream.put_string (": ")
					output_stream.put_string (variable_type_name (a_request.receiver))
					output_stream.put_string ("} ")
				else
					output_stream.put_string (variable_name (a_request.receiver))
					output_stream.put_string (" := ")
				end
				if l_rec_type.is_basic then
					if l_rec_type.is_boolean then
						output_stream.put_string ("last_boolean")
					elseif l_rec_type.is_character then
						output_stream.put_string ("last_character_8")
					elseif l_rec_type.is_character_32 then
						output_stream.put_string ("last_character_32")
					elseif l_rec_type.is_pointer then
						output_stream.put_string ("last_pointer")
					elseif l_rec_type.is_real_32 then
						output_stream.put_string ("last_real_32")
					elseif l_rec_type.is_real_64 then
						output_stream.put_string ("last_real_64")
					elseif {l_int_type: INTEGER_A} l_rec_type then
						output_stream.put_string ("last_integer_")
						output_stream.put_integer (l_int_type.size)
					elseif {l_nat_type: NATURAL_A} l_rec_type then
						output_stream.put_string ("last_natural_")
						output_stream.put_integer (l_nat_type.size)
					else
						output_stream.put_string ("Void")
					end
				else
					output_stream.put_string ("last_object")
				end
				if l_use_ot then
					output_stream.put_line (" then")
					indent
					print_indentation
					output_stream.put_string (variable_name (a_request.receiver))
					output_stream.put_string (" := l_ot")
					output_stream.put_integer (ot_counter.to_integer_32)
					output_stream.put_new_line
					dedent
					print_indentation
					output_stream.put_string ("end")
					ot_counter := ot_counter + 1
				end
				output_stream.put_new_line
			end
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		local
			l_use_ot: BOOLEAN
			l_type: TYPE_A
		do
			l_type := variable_type (a_request.receiver)
			if l_type /= none_type then
				if {l_var: ITP_VARIABLE} a_request.expression then
					l_use_ot := not variable_type (l_var).conform_to (l_type)
				end
			end
			print_indentation
			if l_use_ot then
				output_stream.put_string ("if {l_ot")
				output_stream.put_integer (ot_counter.to_integer_32)
				output_stream.put_string (": ")
				output_stream.put_string (variable_type_name (a_request.receiver))
				output_stream.put_string ("} ")
			else
				output_stream.put_string (variable_name (a_request.receiver))
				output_stream.put_string (" := ")
			end
			a_request.expression.process (expression_printer)
			if l_use_ot then
				output_stream.put_line (" then")
				indent
				print_indentation
				output_stream.put_string (variable_name (a_request.receiver))
				output_stream.put_string (" := l_ot")
				output_stream.put_integer (ot_counter.to_integer_32)
				output_stream.put_new_line
				dedent
				print_indentation
				output_stream.put_string ("end")
				ot_counter := ot_counter + 1
			end
			output_stream.put_new_line
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		do
			-- Do nothing.
		end

feature {NONE} -- Printing

	print_routine_header
			-- Print new test routine name
		do
			indent
			print_indentation
			output_stream.put_line ("test")
		end

	print_argument_list (an_argument_list: DS_LINEAR [ITP_EXPRESSION]; a_print_types: BOOLEAN) is
			-- Print argument list `an_arinstruction' to `output_stream'.
			--
			-- If `a_print_types' is true, the argument definition will be printed instead.
		require
			an_argument_list_not_void: an_argument_list /= Void
			no_argument_void: not an_argument_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			l_var: ITP_VARIABLE
			i: INTEGER
			l_type: TYPE_A
		do
			if an_argument_list.count > 0 then
				output_stream.put_character (' ')
				output_stream.put_character ('(')
				from
					cs := an_argument_list.new_cursor
					cs.start
					i := 1
				until
					cs.off
				loop
					l_var ?= cs.item
					l_type := variable_type (l_var)
					if a_print_types then
						output_stream.put_string ("a_arg")
						output_stream.put_integer (i)
						output_stream.put_string (": ")
						if l_type = none_type then
							output_stream.put_string ("?ANY")
						else
							if not l_type.is_basic then
								output_stream.put_string ("?")
							end
							output_stream.put_string (l_type.name)
						end
					else
						if l_type = none_type then
								-- Replace variables whose type is NONE by Void
							output_stream.put_string ("Void")
						else
							cs.item.process (expression_printer)
						end
					end
					cs.forth
					i := i + 1
					if not cs.after then
						if a_print_types then
							output_stream.put_character  (';')
						else
							output_stream.put_character  (',')
						end
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

invariant

	system_not_void: system /= Void
	output_stream_not_void: output_stream /= Void
	output_stream_is_writable: output_stream.is_open_write
	expression_printer_not_void: expression_printer /= Void
	valid_expression_printer_output_stream: expression_printer.output_stream = output_stream

end

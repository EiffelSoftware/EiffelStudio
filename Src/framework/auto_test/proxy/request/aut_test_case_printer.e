note

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

	make (a_system: like system; an_output_stream: like output_stream)
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

	make_null (a_system: like system)
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

	used_vars: detachable HASH_TABLE [TUPLE [type: detachable TYPE_A; name: detachable STRING; check_dyn_type: BOOLEAN; use_void: BOOLEAN], ITP_VARIABLE]
			-- Set of used variables: keys are variables, items are tuples of static type of variable
			-- and a boolean flag showing if the static type should be checked against dynamic type
			-- (is only the case for variables returned as results of function calls and those whose type
			-- is left Void)
			-- If `use_void' is True, in the use site, the variable will be replaced by Void. This is OK because
			-- `use_void' is only True if the variable is detached in that use site.

	ot_counter: NATURAL
			-- Counter vor object test locals

	context_class: detachable CLASS_C
			-- Class used for type formatting

	context_feature: detachable FEATURE_I
			-- Feature used for type formatting

	any_type: CL_TYPE_A
			-- Detachable version of ANY type
		local
			l_cache: like any_type_cache
		do
			l_cache := any_type_cache
			if l_cache = Void then
				create l_cache.make (system.any_id)
				l_cache.set_detachable_mark
				any_type_cache := l_cache
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
		end

	any_type_cache: detachable like any_type
			-- Cache for `any_type'

feature -- Status setting

	set_output_stream (an_output_stream: like output_stream)
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
			-- Name of variable in generated test.
		do
			Result := a_var.name (variable_name_prefix)
		ensure
			result_attached: Result /= Void
		end

	variable_type (a_var: ITP_VARIABLE): detachable TYPE_A
			-- Type of `a_var'.
			--
			-- Note: if type is NONE, we return Void.
		local
			l_name: STRING
		do
			if used_vars /= Void then
				used_vars.search (a_var)
				if used_vars.found then
					Result := used_vars.found_item.type
					if Result = Void then
						l_name := used_vars.found_item.name
						if l_name.is_equal (none_type_name) then
							Result := none_type
						else
							Result := base_type (l_name)
						end
						used_vars.found_item.type := Result
					end
				end
			end
			if Result = none_type then
				Result := Void
			end
		ensure
			result_not_none: Result /= none_type
		end

	should_use_void (a_var: ITP_VARIABLE): BOOLEAN
			-- Use use Void instead `a_var' in feature argument?
		do
			if used_vars /= Void then
				used_vars.search (a_var)
				if used_vars.found then
					Result := used_vars.found_item.use_void
				end
			end
		end

	effective_type_name (a_type: TYPE_A): STRING
			-- String representation of a type. If we are unable to retrieve type
			-- information, simply the name of the type is returned.
			--
			-- `a_type': Type.
		require
			a_type_attached: a_type /= Void
		do
			if
				attached context_class as l_class and
				attached context_feature as l_feature
			then
				Result := type_name_with_context (a_type, l_class, l_feature)
			else
				create Result.make (30)
				if not a_type.is_attached then
					Result.append_string ({EIFFEL_KEYWORD_CONSTANTS}.detachable_keyword)
					Result.append_character (' ')
				end
				Result.append_string (a_type.name)
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
			l_type: detachable TYPE_A
			l_root: SYSTEM_ROOT
		do
			if not system.root_creators.is_empty then
				l_root := system.root_creators.first
				if attached l_root.root_class.compiled_class as l_class then
					context_class := l_class
					context_feature := l_class.feature_named_32 (l_root.procedure_name)
				end
			end

			used_vars := a_var_list
			ot_counter := 1
			print_header
			print_routine_header
			indent
			print_indentation
			output_stream.put_line ("local")
			indent
			if used_vars /= Void then
				across used_vars as l_cursor loop
					l_type := variable_type (l_cursor.key)
					print_indentation
					output_stream.put_string (variable_name (l_cursor.key))
					output_stream.put_string (": ")
					if l_type = Void then
						l_type := any_type
					end
					output_stream.put_line (effective_type_name (l_type))
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
				if cs.is_last then
					output_stream.put_new_line
					indent
					print_indentation
					output_stream.put_line ("-- Final routine call")
					dedent
					print_indentation
					output_stream.put_line ("set_is_recovery_enabled (False)")
				end
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
			context_class := Void
			context_feature := Void
			any_type_cache := Void
		end

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST)
		do
			-- Do nothing.
		end

	process_stop_request (a_request: AUT_STOP_REQUEST)
		do
			-- Do nothing.
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST)
		local
			l_args: detachable DS_LINEAR [ITP_EXPRESSION]
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
						i := 1
					until
						l_args.after
					loop
						output_stream.put_string ("a_arg")
						output_stream.put_integer (i)
						l_args.forth
						if not l_args.after then
							output_stream.put_string (", ")
						end
						i := i + 1
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
			output_stream.put_string ("check attached {")
			output_stream.put_string (l_type)
			--output_stream.put_string (variable_type_name (a_request.target))
			output_stream.put_string ("} last_object as l_ot")
			output_stream.put_integer (ot_counter.to_integer_32)
			output_stream.put_line (" then")
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

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST)
		local
			l_rec_type: TYPE_A
			l_use_ot: BOOLEAN
		do
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
				l_use_ot := (l_rec_type /= Void and then attached l_rec_type.base_class as l_base_clase and then l_base_clase.original_class /= system.any_class)
				if l_use_ot then
					output_stream.put_string ("check attached {")
					output_stream.put_string (effective_type_name (l_rec_type))
					output_stream.put_string ("} ")
				else
					output_stream.put_string (variable_name (a_request.receiver))
					output_stream.put_string (" := ")
				end
				if l_rec_type /= Void and then l_rec_type.is_basic then
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
					elseif attached {INTEGER_A} l_rec_type as l_int_type then
						output_stream.put_string ("last_integer_")
						output_stream.put_integer (l_int_type.size)
					elseif attached {NATURAL_A} l_rec_type as l_nat_type then
						output_stream.put_string ("last_natural_")
						output_stream.put_integer (l_nat_type.size)
					else
						output_stream.put_string ("Void -- (Unknown basic type)")
					end
				else
					output_stream.put_string ("last_object")
				end
				if l_use_ot then
					output_stream.put_string (" as l_ot")
					output_stream.put_integer (ot_counter.to_integer_32)
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

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST)
		local
			l_use_ot: BOOLEAN
			l_rtype, l_etype: detachable TYPE_A
		do
			l_rtype := variable_type (a_request.receiver)
			if l_rtype /= Void then
				if attached {ITP_VARIABLE} a_request.expression as l_var then
					check initialized: interpreter_root_class /= Void end
					l_etype := variable_type (l_var)
				elseif attached {ITP_CONSTANT} a_request.expression as l_const then
					l_etype := base_type (l_const.type_name)
				else
					check
						dead_end: False
					end
				end
				l_use_ot := l_etype = Void or else not l_etype.conform_to (interpreter_root_class, l_rtype)
			end
			print_indentation
			if l_use_ot then
				output_stream.put_string ("check attached {")
				if l_rtype = Void then
					output_stream.put_string (effective_type_name (any_type))
				else
					output_stream.put_string (effective_type_name (l_rtype))
				end
				output_stream.put_string ("} ")
			else
				output_stream.put_string (variable_name (a_request.receiver))
				output_stream.put_string (" := ")
			end
			a_request.expression.process (expression_printer)
			if l_use_ot then
				output_stream.put_string (" as l_ot")
				output_stream.put_integer (ot_counter.to_integer_32)
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

	process_type_request (a_request: AUT_TYPE_REQUEST)
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

	print_argument_list (an_argument_list: DS_LINEAR [ITP_EXPRESSION]; a_print_types: BOOLEAN)
			-- Print argument list `an_arinstruction' to `output_stream'.
			--
			-- If `a_print_types' is true, the argument definition will be printed instead.
		require
			an_argument_list_not_void: an_argument_list /= Void
			no_argument_void: not an_argument_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [ITP_EXPRESSION]
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
					l_type := Void
					if attached {ITP_VARIABLE} cs.item as l_var and then not should_use_void (l_var) then
						l_type := variable_type (l_var)
					elseif attached {ITP_CONSTANT} cs.item as l_const then
						l_type := base_type (l_const.type_name)
					end
					if l_type = Void then
						l_type := none_type
					end
					if a_print_types then
						output_stream.put_string ("a_arg")
						output_stream.put_integer (i)
						output_stream.put_string (": ")
						output_stream.put_string (effective_type_name (l_type))
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

	indent
			-- Increment indentation.
		do
			indentation := indentation + 1
		end

	dedent
			-- Decrement indentation.
		do
			indentation := indentation - 1
		end

	print_indentation
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

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

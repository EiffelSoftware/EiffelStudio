note
	description: "[
		Objects providing byte code support for test execution.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_EVALUATOR_BYTE_CODE_FACTORY

inherit
	SHARED_BYTE_CONTEXT

	SHARED_ARRAY_BYTE

	SHARED_TYPES

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	EIFFEL_PARSER_WRAPPER

feature -- Basic operations

	execute_test_code (
			a_test: ETEST;
			a_evaluator_class: EIFFEL_CLASS_C;
			a_evaluator_feature: FEATURE_I
		): STRING
		require
			a_test_attached: a_test /= Void
			a_evaluator_class_attached: a_evaluator_class /= Void
			a_evaluator_feature_attached: a_evaluator_feature /= Void
			a_test_usable: a_test.is_interface_usable
			a_evaluator_class_valid: a_evaluator_class.types.count = 1
		local
			l_feature_checker: like feature_checker
			l_context: like context
			l_byte_array: like byte_array
			l_result: detachable like execute_test_code
			l_ast_context: AST_CONTEXT
			l_body_id: INTEGER
			l_old_ast: detachable FEATURE_AS
		do
			if attached create_feature (a_test, a_evaluator_class) as l_feature then
				l_body_id := a_evaluator_feature.body_index
				l_old_ast := a_evaluator_feature.body
				a_evaluator_feature.tmp_ast_server.body_force (l_feature, l_body_id)

				l_ast_context := a_evaluator_class.ast_context
				l_ast_context.initialize (a_evaluator_class, a_evaluator_class.actual_type, a_evaluator_class.feature_table)
				l_ast_context.set_current_feature (a_evaluator_feature)
				l_feature_checker := feature_checker
				l_feature_checker.init (l_ast_context)
				l_feature_checker.type_check_and_code (a_evaluator_feature, False, False)
				l_ast_context.clear_all
				if attached l_feature_checker.byte_code as l_byte_code then
					l_context := context
					l_byte_array := byte_array

					l_context.init (a_evaluator_class.types.first)
					l_context.set_byte_code (l_byte_code)
					l_context.set_current_feature (a_evaluator_feature)
					l_context.set_workbench_mode

					l_byte_array.clear
					l_byte_code.make_byte_code (l_byte_array)
					l_result := l_byte_array.melted_feature.string_representation
					l_context.clear_feature_data
					l_byte_array.clear
				end

				if l_old_ast /= Void then
					a_evaluator_feature.tmp_ast_server.body_force (l_old_ast, l_body_id)
				end
			end
			if l_result = Void then
				create l_result.make_empty
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Basic operations

	create_feature_text (a_test: ETEST): STRING
			-- Create feature text for {EQA_EVALUATOR}.execute_test for executing `a_test'.
			--
			-- `a_test': Test to be executed.
		do
			create Result.make (1024)
			Result.append ("feature%N")
			Result.append ("	execute_test: EQA_TEST_EVALUATOR [EQA_TEST_SET]%N")
			Result.append ("		local%N")
			Result.append ("			l_evaluator: EQA_TEST_EVALUATOR [" + a_test.eiffel_class.name + "]%N")
			Result.append ("		do%N")
			Result.append ("			create l_evaluator%N")
			Result.append ("			l_evaluator.execute (agent {")
			Result.append (a_test.eiffel_class.name)
			Result.append ("}.")
			Result.append (a_test.routine_name)
			Result.append (")%N")
			Result.append ("			Result := l_evaluator%N")
			Result.append ("		end%N")
		end

	create_feature (a_test: ETEST; a_evaluator_class: EIFFEL_CLASS_C): detachable FEATURE_AS
			-- Create feature AST of {EQA_EVALUATOR}.execute_test for executing given test
			--
			-- `a_test': Test to be executed.
			-- `a_evaluator_class': Compiled representation of {EQA_EVALUATOR}
		local
			l_parser: like entity_feature_parser
		do
			l_parser := entity_feature_parser
			parse (l_parser, create_feature_text (a_test), True, a_evaluator_class)

			if not has_error and attached {FEATURE_AS} ast_node as l_feature then
				Result := l_feature
			end
		end

feature

	new_test_execution (
			a_evaluator_type: CLASS_TYPE;
			a_execute_test_feature: FEATURE_I;
			a_test_evaluator_type: TYPE_A;
			a_test_routine_feature: FEATURE_I
		): STRING
			-- Create byte code for `execute_test' in {EQA_EVALUATOR} which executes given test.
			--
			-- `a_evalautor_type': Type of {EQA_EVALUATOR}
			-- `a_execute_test_feature': Feature representation of `execute_test' in {EQA_EVALUATOR}.
			-- `a_test_evaluator_type': {EQA_TEST_EVALUATOR [EQA_TEST_SET]} type for initializing correct test class.
			-- `a_test_routine_feature': Feature representation of actual test routine.
		require
			a_evaluator_type_attached: a_evaluator_type /= Void
			a_execute_test_feature_attached: a_execute_test_feature /= Void
			a_test_evaluator_type_attached: a_test_evaluator_type /= Void
			a_test_routine_feature_attached: a_test_routine_feature /= Void
			a_test_evaluator_type_has_class: a_test_evaluator_type.has_associated_class
		local
			l_byte_code: STD_BYTE_CODE
			l_context: like context
			l_byte_array: like byte_array
			l_compound: BYTE_LIST [BYTE_NODE]
		do




			l_context := context
			l_byte_array := byte_array
			create l_byte_code
			l_byte_code.set_body_index (a_execute_test_feature.body_index)
			l_byte_code.set_feature_name_id (a_execute_test_feature.feature_name_id)
			l_byte_code.set_pattern_id (a_execute_test_feature.pattern_id)
			l_byte_code.set_real_body_id (a_execute_test_feature.real_body_id (a_evaluator_type))
			l_byte_code.set_result_type (a_execute_test_feature.type)
			l_byte_code.set_rout_id (a_execute_test_feature.rout_id_set.first)
			l_byte_code.set_written_class_id (a_execute_test_feature.written_in)
			l_byte_code.set_locals (<< a_test_evaluator_type >>, 1)

			l_context.init (a_evaluator_type)
			l_context.set_byte_code (l_byte_code)
			l_context.set_current_feature (a_execute_test_feature)
			l_context.set_workbench_mode

				-- Add actual byte code instructions for calling test routine
			create l_compound.make (2)
			add_creation (l_compound, a_test_evaluator_type)
			add_test_invocation (l_compound, a_execute_test_feature, a_test_routine_feature)

			l_byte_code.set_compound (l_compound)
			l_byte_array.clear
			l_byte_code.make_byte_code (l_byte_array)
			l_context.clear_feature_data

			Result := l_byte_array.melted_feature.string_representation
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	add_creation (a_compound: BYTE_LIST [BYTE_NODE]; a_type: TYPE_A)
			-- Add byte code for creating {EQA_TEST_EVALUATOR} of given type.
			--
			-- `a_compound': Compound to which byte code should be added.
			-- `a_type': Actual type of {EQA_TEST_EVALUATOR}.
		require
			a_compound_attached: a_compound /= Void
			a_type_attached: a_type /= Void
			a_type_has_class: a_type.has_associated_class
		local
			l_local: LOCAL_B
			l_creation: CREATION_EXPR_B
			l_assign: ASSIGN_B
			l_default_create: FEATURE_I
		do
				-- Local receiving new {EQA_TEST_EVALUATOR}
			create l_local
			l_local.set_position (1)

				-- Creation expression
			l_default_create := a_type.associated_class.default_create_feature
			create l_creation
			l_creation.set_info (create {CREATE_TYPE}.make (a_type.actual_type))
			l_creation.set_type (a_type)
			if attached {CALL_ACCESS_B} l_default_create.access (void_type, True) as l_call then
				l_creation.set_call (l_call)
			else
				check dead_end: False end
			end
			l_creation.set_creation_instruction (True)

				-- Assignment
			create l_assign
			l_assign.set_source (l_creation)
			l_assign.set_target (l_local)
			a_compound.force (l_assign)
		end

	add_test_invocation (a_compound: BYTE_LIST [BYTE_NODE]; a_execute_routine, a_test_routine: FEATURE_I)
			-- Add byte code for test invocation call.
			--
			-- `a_compound': Compound to which byte code should be added.
			-- `a_execute_routine': Execution routine to be called.
			-- `a_test_routine': Test routine to be called.
		local
			l_params: BYTE_LIST [PARAMETER_B]
			l_agent: AGENT_CALL_B
			l_param: PARAMETER_B
			l_call: ACCESS_B
		do
				-- FIXME: Not sure if this works...
			create l_agent.make (a_test_routine, void_type, Void, False)
			create l_param
			l_param.set_expression (l_agent)
				-- FIXME: Not sure what to pass here
			l_param.set_attachment_type (l_agent.context_type)

			create l_params.make (1)
			l_params.force (l_param)

			l_call := a_execute_routine.access (void_type, True)
			l_call.set_parameters (l_params)
			a_compound.force (l_call)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

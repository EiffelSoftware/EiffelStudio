note
	description: "IV-visitor that generates Boogie code."

class
	IV_BOOGIE_PRINTER

inherit

	IV_UNIVERSE_VISITOR

	IV_CONTRACT_VISITOR

	IV_STATEMENT_VISITOR

	IV_EXPRESSION_VISITOR

	IV_TYPE_VISITOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize universe visitor.
		do
			reset
		end

feature -- Access

	output: E2B_BOOGIE_TEXT
			-- Boogie text output.

feature -- Basic operations

	reset
			-- Reset universe visitor.
		do
			create output
		end

feature -- Universe Visitor

	process_function (a_function: IV_FUNCTION)
			-- <Precursor>
		do
			output.put ("function ")
			if a_function.is_inline then
				output.put ("{ :inline } ")
			end
			output.put (a_function.name)
			output.put ("(")
			across a_function.arguments as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				process_entity_declaration (i)
			end
			output.put (") returns (")
			a_function.type.process (Current)
			output.put (")")
			if attached a_function.body as l_body then
				output.put (" {")
				output.put_new_line
				output.indent
				output.put (output.indentation_string)
				l_body.process (Current)
				output.unindent
				output.put_new_line
				output.put ("}")
			else
				output.put (";")
			end
			output.put_new_line
			output.put_new_line
		end

	process_variable (a_variable: IV_VARIABLE)
			-- <Precursor>
		do
			output.put ("var ")
			process_entity_declaration (a_variable)
			output.put (";")
			output.put_new_line
			output.put_new_line
		end

	process_constant (a_constant: IV_CONSTANT)
			-- <Precursor>
		do
			output.put ("const ")
			if a_constant.is_unique then
				output.put ("unique ")
			end
			output.put (a_constant.name)
			output.put (": ")
			a_constant.type.process (Current)
			output.put (";")
			output.put_new_line
			output.put_new_line
		end

	process_axiom (a_axiom: IV_AXIOM)
			-- <Precursor>
		do
			output.put ("axiom (")
			if attached a_axiom.attribute_string then
				output.put ("{" + a_axiom.attribute_string + "} ")
			end
			a_axiom.expression.process (Current)
			output.put (");")
			output.put_new_line
			output.put_new_line
		end

	process_procedure (a_procedure: IV_PROCEDURE)
			-- <Precursor>
		do
			output.put ("procedure ")
			output.put (a_procedure.name)
			output.put ("(")
			across a_procedure.arguments as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				process_entity_declaration (i)
			end
			output.put (")")
			if not a_procedure.results.is_empty then
				output.put (" returns (")
				across a_procedure.results as i loop
					if @ i.cursor_index /= 1 then
						output.put (", ")
					end
					process_entity_declaration (i)
				end
				output.put (")")
			end
			output.put (";")
			output.put_new_line
			output.indent
			across a_procedure.contracts as i loop
				i.process (Current)
			end
			output.unindent
			output.put_new_line
			across a_procedure.implementations as i loop
				i.process (Current)
			end
			output.put_new_line
			output.put_new_line
		end

	process_implementation (a_implementation: IV_IMPLEMENTATION)
			-- <Precursor>
		do
			output.put ("implementation ")
			output.put (a_implementation.procedure.name)
			output.put ("(")
			across a_implementation.procedure.arguments as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				output.put (i.name)
				output.put (": ")
				i.type.process (Current)
			end
			output.put (")")
			if not a_implementation.procedure.results.is_empty then
				output.put (" returns (")
				across a_implementation.procedure.results as i loop
					if @ i.cursor_index /= 1 then
						output.put (", ")
					end
					output.put (i.name)
					output.put (": ")
					i.type.process (Current)
				end
				output.put (")")
			end
			output.put_new_line
			output.put ("{")
			output.put_new_line
			output.indent
			if not a_implementation.locals.is_empty or not a_implementation.procedure.results.is_empty then
				across a_implementation.locals as i loop
					output.put_indentation
					output.put ("var ")
					process_entity_declaration (i)
					output.put (";")
					output.put_new_line
				end
				output.put_new_line
				output.put_line ("init_locals:")
				across a_implementation.locals as i loop
					-- No defaults needed for auxiliary locals of Boogie types, like HeapType:
					if i.type.default_value /= Void then
						output.put_indentation
						output.put (i.name)
						output.put (" := ")
						i.type.default_value.process (Current)
						output.put (";")
						output.put_new_line
					end
				end
				across a_implementation.procedure.results as i loop
					output.put_indentation
					output.put (i.name)
					output.put (" := ")
					i.type.default_value.process (Current)
					output.put (";")
					output.put_new_line
				end
				output.put_new_line
			end
			a_implementation.body.process (Current)
			output.unindent
			output.put ("}")
			output.put_new_line
			output.put_new_line
		end

feature -- Contract visitor

	process_precondition (a_precondition: IV_PRECONDITION)
			-- <Precursor>
		do
			output.put_indentation
			if a_precondition.is_free then
				output.put ("free ")
			end
			output.put ("requires ")
			if attached a_precondition.attribute_string then
				output.put ("{" + a_precondition.attribute_string + "} ")
			end
			a_precondition.expression.process (Current)
			output.put (";")
			print_node_info (a_precondition.node_info)
			output.put_new_line
		end

	process_postcondition (a_postcondition: IV_POSTCONDITION)
			-- <Precursor>
		do
			output.put_indentation
			if a_postcondition.is_free then
				output.put ("free ")
			end
			output.put ("ensures ")
			if attached a_postcondition.attribute_string then
				output.put ("{" + a_postcondition.attribute_string + "} ")
			end
			a_postcondition.expression.process (Current)
			output.put (";")
			print_node_info (a_postcondition.node_info)
			output.put_new_line
		end

	process_modifies (a_modifies: IV_MODIFIES)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("modifies ")
			across a_modifies.names as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				output.put (i)
			end
			output.put (";")
			output.put_new_line
		end

feature -- Statement Visitor

	process_assert (a_assert: IV_ASSERT)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("assert ")
			if attached a_assert.attribute_string then
				output.put ("{" + a_assert.attribute_string + "} ")
			end
			a_assert.expression.process (Current)
			output.put (";")
			print_node_info (a_assert.node_info)
			output.put_new_line
		end

	process_assume (a_assume: IV_ASSERT)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("assume ")
			if attached a_assume.attribute_string then
				output.put ("{" + a_assume.attribute_string + "} ")
			end
			a_assume.expression.process (Current)
			output.put (";")
			output.put_new_line
		end

	process_assignment (a_assignment: IV_ASSIGNMENT)
			-- <Precursor>
		do
			output.put_indentation
			a_assignment.target.process (Current)
			output.put (" := ")
			a_assignment.source.process (Current)
			output.put (";")
			output.put_new_line
		end

	process_block (a_block: IV_BLOCK)
			-- <Precursor>
		do
			if not a_block.name.is_empty then
				output.put_indentation
				output.put (a_block.name)
				output.put (":")
				output.put_new_line
			end
			across a_block.statements as i loop
				print_statement_origin_information (i)
				i.process (Current)
			end
		end

	process_conditional (a_conditional: IV_CONDITIONAL)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("if (")
			if a_conditional.condition = Void then
				output.put ("*")
			else
				a_conditional.condition.process (Current)
			end
			output.put (") {")
			output.put_new_line
			output.indent
			a_conditional.then_block.process (Current)
			output.unindent
			if not a_conditional.else_block.is_empty then
				output.put_line ("} else {")
				output.indent
				a_conditional.else_block.process (Current)
				output.unindent
			end
			output.put_line ("}")
		end

	process_havoc (a_havoc: IV_HAVOC)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("havoc ")
			across a_havoc.names as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				output.put (i)
			end
			output.put (";")
			output.put_new_line
		end

	process_label (a_label: IV_LABEL)
			-- <Precursor>
		do
			check False end
		end

	process_loop (a_loop: IV_LOOP)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("while (")
			if a_loop.is_until_loop then
				output.put ("!(")
			end
			a_loop.condition.process (Current)
			if a_loop.is_until_loop then
				output.put (")")
			end
			output.put (")")
			output.put_new_line
			output.indent
			across a_loop.invariants as i loop
				output.put_indentation
				i.process (Current)
				output.put (";")
				output.put_new_line
			end
			output.unindent
			output.put_line ("{")
			a_loop.body.process (Current)
			output.put_line ("}")
		end

	process_goto (a_goto: IV_GOTO)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("goto ")
			across a_goto.blocks as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				output.put (i.name)
			end
			output.put (";")
			output.put_new_line
		end

	process_procedure_call (a_call: IV_PROCEDURE_CALL)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("call ")
			if attached a_call.target as l_target then
				l_target.process (Current)
				output.put (" := ")
			end
			output.put (a_call.name)
			output.put ("(")
			across a_call.arguments as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				i.process (Current)
			end
			output.put (");")
			print_node_info (a_call.node_info)
			output.put_new_line
		end

	process_return (a_return: IV_RETURN)
			-- <Precursor>
		do
			output.put_indentation
			output.put ("return;")
			output.put_new_line
		end

	print_statement_origin_information (a_statement: IV_STATEMENT)
			-- Print origin information of `a_statement'.
		do
			if
				attached a_statement.origin_information as l_origin and then
				attached l_origin.file
			then
				output.put_comment_line (l_origin.file.utf_8_name + ":" + l_origin.line.out)
				if l_origin.line > 0 then
					output.put_comment_line (l_origin.text_of_line)
				end
			end
		end

	print_node_info (a_info: IV_NODE_INFO)
			-- Print node info `a_info'.
		do
			if attached a_info and then attached a_info.attributes as l_attributes then
				output.put (" //")
				across
					l_attributes as a
				loop
					output.put (" ")
					output.put (@ a.key.out)
					output.put (":")
					output.put_literal_string (a)
				end
			end
		end

feature -- Expression Visitor

	process_binary_operation (a_operation: IV_BINARY_OPERATION)
			-- <Precursor>
		local
			l_do_left_par, l_do_right_par: BOOLEAN
		do
			l_do_left_par :=
				(a_operation.operator /~ "&&" and a_operation.operator /~ "||") or
				not (attached {IV_BINARY_OPERATION} a_operation.left as l_b and then l_b.operator ~ a_operation.operator)
			l_do_right_par :=
				(a_operation.operator /~ "&&" and a_operation.operator /~ "||") or
				not (attached {IV_BINARY_OPERATION} a_operation.right as l_b and then l_b.operator ~ a_operation.operator)

			if l_do_left_par then
				output.put ("(")
				a_operation.left.process (Current)
				output.put (")")
			else
				a_operation.left.process (Current)
			end
			output.put (" ")
			output.put (a_operation.operator)
			output.put (" ")
			if l_do_right_par then
				output.put ("(")
				a_operation.right.process (Current)
				output.put (")")
			else
				a_operation.right.process (Current)
			end
		end

	process_conditional_expression (a_conditional: IV_CONDITIONAL_EXPRESSION)
			-- <Precursor>
		do
			output.put ("(")
			output.put ("if ")
			a_conditional.condition.process (Current)
			output.put (" then ")
			a_conditional.then_expression.process (Current)
			output.put (" else ")
			a_conditional.else_expression.process (Current)
			output.put (")")
		end

	process_entity (a_entity: IV_ENTITY)
			-- <Precursor>
		do
			output.put (a_entity.name)
		end

	process_exists (a_exists: IV_EXISTS)
			-- <Precursor>
		do
			process_quantifier ("exists", a_exists)
		end

	process_forall (a_forall: IV_FORALL)
			-- <Precursor>
		do
			process_quantifier ("forall", a_forall)
		end

	process_function_call (a_call: IV_FUNCTION_CALL)
			-- <Precursor>
		do
			output.put (a_call.name)
			output.put ("(")
			across a_call.arguments as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				i.process (Current)
			end
			output.put (")")
		end

	process_map_access (a_map_access: IV_MAP_ACCESS)
			-- <Precursor>
		do
			a_map_access.target.process (Current)
			output.put ("[")
			across a_map_access.indexes as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				i.process (Current)
			end
			output.put ("]")
		end

	process_map_update (a_map_update: IV_MAP_UPDATE)
			-- <Precursor>
		do
			a_map_update.target.process (Current)
			output.put ("[")
			across a_map_update.indexes as i loop
				if not @ i.is_first then
					output.put (", ")
				end
				i.process (Current)
			end
			output.put (" := ")
			a_map_update.value.process (Current)
			output.put ("]")
		end

	process_unary_operation (a_operation: IV_UNARY_OPERATION)
			-- <Precursor>
		do
			output.put (a_operation.operator)
			output.put ("(")
			a_operation.expression.process (Current)
			output.put (")")
		end

	process_value (a_value: IV_VALUE)
			-- <Precursor>
		do
			output.put (a_value.value)
		end

feature -- Type Visitor

	process_boolean_type (a_type: IV_BASIC_TYPE)
			-- <Precursor>
		do
			output.put ("bool")
		end

	process_integer_type (a_type: IV_BASIC_TYPE)
			-- <Precursor>
		do
			output.put ("int")
		end

	process_real_type (a_type: IV_BASIC_TYPE)
			-- <Precursor>
		do
			output.put ("real")
		end

	process_user_type (a_type: IV_USER_TYPE)
			-- <Precursor>
		local
			old_is_in_type: BOOLEAN
		do
			if is_in_type then
				output.put ("(")
			end
			output.put (a_type.constructor)
			old_is_in_type := is_in_type
			is_in_type := True
			across
				a_type.parameters as params
			loop
				output.put (" ")
				params.process (Current)
			end
			is_in_type := old_is_in_type
			if is_in_type then
				output.put (")")
			end
		end

	process_variable_type (a_type: IV_VAR_TYPE)
			-- <Precursor>
		do
			output.put (a_type.name)
		end

	process_map_type (a_type: IV_MAP_TYPE)
			-- <Precursor>
		local
			old_is_in_type: BOOLEAN
		do
			if is_in_type then
				output.put ("(")
			end
			if not a_type.type_parameters.is_empty then
				output.put ("<")
				across
					a_type.type_parameters as tps
				loop
					output.put (tps)
					if not @ tps.is_last then
						output.put (", ")
					end
				end
				output.put (">")
			end
			output.put ("[")
			across
				a_type.domain_types as ds
			loop
				ds.process (Current)
				if not @ ds.is_last then
					output.put (", ")
				end
			end
			output.put ("]")
			old_is_in_type := is_in_type
			is_in_type := True
			a_type.range_type.process (Current)
			is_in_type := old_is_in_type
			if is_in_type then
				output.put (")")
			end
		end

	process_map_synonym_type (a_type: IV_MAP_SYNONYM_TYPE)
			-- <Precursor>
		do
				-- Treat like user type:
			process_user_type (a_type)
		end

feature -- Other

	process_entity_declaration (a_declaration: IV_ENTITY_DECLARATION)
			-- <Precursor>
		do
				-- TODO: extract this helper function to some parent
			output.put (a_declaration.name)
			output.put (": ")
			a_declaration.type.process (Current)
			if attached a_declaration.property as l_property then
				output.put (" where ")
				l_property.process (Current)
			end
		end

	process_quantifier (a_keyword: STRING; a_quantifier: IV_QUANTIFIER)
			-- Process quantifier `a_quantifier'.
		do
			output.put ("(")
			output.put (a_keyword)
			if not a_quantifier.type_variables.is_empty then
				output.put (" <")
				across
					a_quantifier.type_variables as vars
				loop
					if not @ vars.is_first then
						output.put (", ")
					end
					output.put (vars)
				end
				output.put (">")
			end
			output.put (" ")
			across a_quantifier.bound_variables as i loop
				if @ i.cursor_index /= 1 then
					output.put (", ")
				end
				process_entity_declaration (i)
			end
			output.put (" :: ")
			across a_quantifier.triggers as i loop
				output.put ("{ ")
				across i as j loop
					j.process (Current)
					if not @ j.is_last then
						output.put (", ")
					end
				end
				output.put (" } ")
			end
			a_quantifier.expression.process (Current)
			output.put (")")
		end

feature {NONE} -- Implementation

	is_in_type: BOOLEAN;
			-- Is the printer processing a complex type (i.e. a context where other complex types have to be parenthesized)?

note
	ca_ignore: "CA033", "CA033: too long class"
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end

indexing
	description: "Enlarged byte node representing a call (either call or item) to an agent"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AGENT_CALL_BL

inherit
	AGENT_CALL_B
		rename
			parent as parent_b, make as make_agent_call
		undefine
			allocates_memory,
			free_register,
			generate_on,
			analyze_on,
			generate_special_feature,
			generate_access,
			generate_access_on_type,
			generate_parameters_list,
			generate_end,
			basic_register,
			is_feature_call,
			analyze,
			has_call,
			set_register,
			register,
			set_parent,
			need_invariant,
			set_need_invariant
		redefine
			generate_on,
			enlarged
		end

	FEATURE_BL
		undefine
			process,
			set_parameters,
			is_polymorphic,
			has_one_signature,
			set_type,
			inlined_byte_code
		redefine
			check_dt_current,
			analyze_on,
			fill_from,
			generate_on,
			enlarged
		select
			parent,
			make_node
		end

feature -- Code generation

	generate_on (reg: REGISTRABLE) is
			-- Generate access call of feature in current on `current_register'
		local
			l_cl_type: GEN_TYPE_A
		do
			l_cl_type := cl_type.instantiated_in (context.context_class_type.type)
			if is_function then
				register.print_register
				buffer.put_string (" = ")
			end
			buffer.put_character ('(')
			generate_function_cast (l_cl_type)
			rout_disp_b.generate_access_on_type (reg, l_cl_type)
			buffer.put_string (")(")
			buffer.indent
			buffer.put_new_line
			calc_rout_addr_b.generate_access_on_type (reg, l_cl_type)
			buffer.put_character (',')
			buffer.put_new_line
			closed_operands_b.generate_access_on_type (reg, l_cl_type)
			generate_parameters_list
			buffer.put_string (gc_rparan_semi_c)
			buffer.exdent
			buffer.put_new_line

				-- if it is a call on a function object we need to set the last_result
			if is_function and then not is_item then
				last_result_b.generate_access_on_type (reg, l_cl_type)
				buffer.put_string (" = ")
				register.print_register
				buffer.put_character (';')
				buffer.put_new_line
					-- If function return type is a reference we need an aging test.
				if register.c_type.is_pointer then
					buffer.put_string ("RTAR(")
					reg.print_register
					buffer.put_string (gc_comma)
					register.print_register
					buffer.put_character (')')
					buffer.put_character (';')
					buffer.put_new_line
				end
			end
		end

	analyze_on (reg: REGISTRABLE) is
			-- Analyze agent call on `reg'
		local
			tmp_register: REGISTER
		do
			Precursor{FEATURE_BL}(reg)
			if is_manifest_optimizable then
				rout_disp_b := init_attribute ({PREDEFINED_NAMES}.rout_disp_name_id, reg)
			else
				rout_disp_b := init_attribute ({PREDEFINED_NAMES}.encaps_rout_disp_name_id, reg)
			end
			closed_operands_b := init_attribute ({PREDEFINED_NAMES}.closed_operands_name_id, reg)
			calc_rout_addr_b := init_attribute ({PREDEFINED_NAMES}.calc_rout_addr_name_id, reg)

			if is_function then
				last_result_b := init_attribute ({PREDEFINED_NAMES}.last_result_name_id, reg)
			end

			if is_function then
				if is_item then
					get_register
				else
					create tmp_register.make (last_result_b.type.c_type)
					set_register (tmp_register)
				end
			end
		end

	check_dt_current (reg: REGISTRABLE) is
		do
		end

	init (a: AGENT_CALL_B) is
		do
			fill_from (a)

			if system.in_final_mode and
			then
				not (system.keep_assertions and then rout_class.lace_class.options.assertions.is_precondition)
			then
				create_optimized_parameters
				if is_manifest_optimizable then
					set_parameters (optimized_parameters)
				end
			end
		end

	enlarged: CALL_ACCESS_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		local
			l_agent_call: AGENT_CALL_BL
		do
			create l_agent_call
			l_agent_call.fill_from (Current)
			Result := l_agent_call
		end

	fill_from (a: AGENT_CALL_B) is
		local
			a_bl: AGENT_CALL_BL
		do
			is_item := a.is_item
			Precursor (a)

			cl_type ?= a.context_type

			rout_class := cl_type.associated_class.eiffel_class_c
			is_function := rout_class.class_id = system.function_class_id or else
						   rout_class.class_id = system.predicate_class_id
			is_predicate := rout_class.class_id = system.predicate_class_id

			if is_function then
				if is_predicate then
					type := create {BOOLEAN_A}
				else
					type := cl_type.generics.item (3)
				end
			else
				type := create {VOID_A}
			end

			a_bl ?= a
			if a_bl /= Void then
				optimized_parameters := a_bl.optimized_parameters
				is_manifest_optimizable := a_bl.is_manifest_optimizable
			end
		end

feature {NONE}--Access

	rout_disp_b: ATTRIBUTE_B
		-- Byte node for accessing feature rout_disp of class ROUTINE.

	closed_operands_b: ATTRIBUTE_B
		-- Byte node for accessing feature closed_operands of class ROUTINE.

	calc_rout_addr_b: ATTRIBUTE_B
		-- Byte node for accessing feature calc_rout_addr of class ROUTINE.

	last_result_b: ATTRIBUTE_B
		-- Byte node for accessing feature last_result of class ROUTINE.

	rout_class: EIFFEL_CLASS_C
		-- Either the EIFFEL_CLASS_C of FUNCTION, PROCEDURE or PREDICATE.

	is_function: BOOLEAN
		-- Is this a call to an agent of type FUNCTION?

	is_predicate: BOOLEAN
		-- Is this a call to an agent of type PREDICATE?

	cl_type: GEN_TYPE_A
		-- Exact type of the agent reference used for the call.

feature {AGENT_CALL_BL}--Optimized parameters

	is_manifest_optimizable: BOOLEAN
		-- Is this a call with a manifest tuple, an can it be optimized?

	optimized_parameters: like parameters
		-- Optimized verion of the parameters

feature {NONE} --Implementation

	init_attribute (id: INTEGER; reg: REGISTRABLE): ATTRIBUTE_B is
			-- Initializes an attribute byte node to access attribute with id `id' of object in `reg'
		local
			l_feat: FEATURE_I
			l_type_i: TYPE_A
		do
			l_feat := rout_class.feature_table.item_id (id)
			create Result
			Result.init (l_feat)
			l_type_i := context.real_type_in (l_feat.type, cl_type.associated_class_type (context.context_class_type.type).type)
			Result.set_type (l_type_i)
			Result := Result.enlarged
			Result.analyze_on (reg)
			Result.set_register (No_register)
		end

	create_optimized_parameters
			-- Initialize the optimized parameters (Manifest tuple optimization) if possible
		require
			semantically_correct_call: parameters /= Void and then parameters.count = 1
		local
			l_manifest_tuple: TUPLE_CONST_B
			l_void: VOID_B
			l_first_parameter, l_parameter: PARAMETER_B
			l_exprs: BYTE_LIST [EXPR_B]
			l_expr: EXPR_B
			l_tuple_type: TUPLE_TYPE_A
			l_cl_type: CL_TYPE_A
		do
			l_first_parameter := parameters.first
			l_tuple_type ?= context.real_type_in (l_first_parameter.attachment_type, cl_type.associated_class_type (context.context_class_type.type).type)

			l_void ?= l_first_parameter.expression
			if l_void /= Void then
				is_manifest_optimizable := True
				create optimized_parameters.make (0)
			else
				l_manifest_tuple ?= l_first_parameter.expression
				if l_manifest_tuple /= Void then
					is_manifest_optimizable := True
					from
						l_exprs ?= l_manifest_tuple.expressions
						l_exprs.start
						create optimized_parameters.make (l_exprs.count)
						l_cl_type := context.class_type.type
					until
						optimized_parameters.full or else l_exprs.after
					loop
						create l_parameter
						l_expr := l_exprs.item
						l_parameter.set_expression (l_expr)
						l_parameter.set_attachment_type (context.real_type_in (l_expr.type, l_cl_type))
						optimized_parameters.extend (l_parameter.enlarged)
						l_exprs.forth
					end
				end
			end
		end

	generate_function_cast (a_type: GEN_TYPE_A) is
			-- Generates a c function cast
		local
			l_arg_types: ARRAY [STRING]
			l_ret_type: TYPE_C
			i: INTEGER
		do
			if is_function then
				if is_predicate then
					l_ret_type := boolean_type.c_type
				else
					l_ret_type := a_type.generics.item (3).c_type
				end
			else
				l_ret_type := void_type.c_type
			end
			if is_manifest_optimizable then
				create l_arg_types.make (1, optimized_parameters.count + 2)
			else
				create l_arg_types.make (1, 3)
			end
			l_arg_types.put ("EIF_POINTER", 1)
			l_arg_types.put ("EIF_REFERENCE", 2)
			if is_manifest_optimizable then
				from
					i := 3
					optimized_parameters.start
				until
					optimized_parameters.after
				loop
					l_arg_types.put (optimized_parameters.item.attachment_type.c_type.c_string, i)
					i := i + 1
					optimized_parameters.forth
				end
			else
				l_arg_types.put ("EIF_REFERENCE", 3)
			end

			l_ret_type.generate_function_cast (buffer, l_arg_types, context.workbench_mode)
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

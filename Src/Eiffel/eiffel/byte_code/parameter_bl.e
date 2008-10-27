indexing
	description: "Enlarged parameter expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PARAMETER_BL

inherit

	PARAMETER_B
		redefine
			analyze, generate, unanalyze, register, set_register,
			free_register, print_register, propagate, c_type
		end

feature -- Status report

	is_address_needed: BOOLEAN
			-- Does current parameter needs to be passed as address rather than an object?

feature -- Access

	register: REGISTRABLE;
			-- Register used to store metamorphosed value

	c_type: TYPE_C is
			-- C type of the attachment target
		do
			Result := real_type (attachment_type).c_type
		end

feature -- Element change

	compute_is_address_needed is
			-- Compute value for `is_address_needed'.
		require
			not_il_generation: not system.il_generation
		local
			l_expr_type, l_target_type: TYPE_A
		do
			if
				(is_formal and context.final_mode) and then
				parent.is_polymorphic and then not parent.has_one_signature
			then
				l_target_type := context.real_type (internal_attachment_type)
				l_expr_type := context.real_type (expression.type)
				is_address_needed := l_target_type.is_basic and l_expr_type.is_basic
				check
					validity: is_address_needed implies l_target_type.same_as (l_expr_type)
				end
			else
				is_address_needed := False
			end
		end

feature -- Settings

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			expression.propagate (r);
			if r /= No_register and then r.c_type.is_pointer then
				register := r;
			end;
		end;

	free_register is
			-- Free register used by expression
		do
			expression.free_register;
			if register /= Void then
				register.free_register;
			end;
		end;

	analyze is
			-- Analyze expression
		local
			l_expression: like expression
			l_is_predefined: BOOLEAN
		do
			l_expression := expression
			l_expression.analyze;
			if is_compaund then
				register := context.get_argument_register (c_type)
			else
				compute_is_address_needed
				if is_address_needed then
					check
						no_register_needed_in_theory:
							not l_expression.is_register_required (real_type (internal_attachment_type))
					end
						-- We cannot use `l_expression.is_predefined' because here we are looking to see if
						-- there is a register storage for `l_expression'.
					l_is_predefined := l_expression.is_local or l_expression.is_argument or
						l_expression.is_result or l_expression.is_current
					if not l_is_predefined and l_expression.register = Void then
							-- An address was required due to polymorphic call but `l_expression' does not
							-- store its result in a register, so we need a register to store the value
							-- of the expression, so that we can pass its address later.
						set_register (create {REGISTER}.make (real_type (internal_attachment_type).c_type))
					end
				elseif l_expression.is_register_required (real_type (attachment_type)) then
						-- We are in the case where `internal_attachment_type' is different from `attachement_type'
					get_register
				end
			end
		end

	unanalyze is
			-- Undo the analysis of the expression
		do
			expression.unanalyze;
			register := Void;
		end;

	generate is
			-- Generate expression
		local
			target_type, source_type: TYPE_A
		do
			target_type := real_type (attachment_type)
			source_type := real_type (expression.type)
			if source_type.is_none and target_type.is_expanded then
				buffer.put_new_line
				buffer.put_string ("RTEC(EN_VEXP);")
			elseif is_compaund then
				expression.generate_for_type (register, target_type)
			else
				if is_address_needed then
					check
						no_register_needed_in_theory: not expression.is_register_required (real_type (internal_attachment_type))
					end
					expression.generate_for_type (register, real_type (internal_attachment_type))
				else
					expression.generate_for_type (register, target_type)
				end
			end
		end

	print_register is
			-- Print expression value that can be used as an argument to a routine.
		local
			target_type, source_type: TYPE_A;
			l_basic: BASIC_A
			target_ctype, source_ctype: TYPE_C;
			cast_generated: BOOLEAN;
			buf: GENERATION_BUFFER
			r: REGISTER
		do
			buf := buffer
			target_type := real_type (attachment_type);
			source_type := real_type (expression.type);
			if is_compaund then
				r ?= register
				context.print_argument_register (r, buf)
			elseif target_type.is_none then
				buf.put_string ("(EIF_REFERENCE) 0");
			elseif register /= Void then
				if is_address_needed then
					buf.put_string ("(EIF_REFERENCE) &")
				end
				register.print_register
			elseif target_type.is_true_expanded then
					-- The callee is responsible for cloning the reference.
				expression.print_register;
			elseif target_type.is_basic then
				if source_type.is_none then
						-- We pass `Void' as argument of a routine which expects a basic type,
						-- since the exception is triggered before the call (see `generate')
						-- our goal is to generate code that compiles, therefore we generate
						-- the value by default.
					l_basic ?= target_type
					check l_basic_not_void: l_basic /= Void end
					l_basic.c_type.generate_default_value (buf)
				else
						-- Ensure correct value in case the target is a double
						-- and the source an int.
					target_ctype := target_type.c_type;
					source_ctype := source_type.c_type;
					if source_ctype.level /= target_ctype.level then
						cast_generated := True;
						target_ctype.generate_cast (buf);
						buf.put_character('(');
					end;
					expression.print_register;
					if cast_generated then
						buf.put_character(')');
					end;
				end
			else
				if is_address_needed then
					buf.put_string ("(EIF_REFERENCE) &")
				end
				expression.print_register;
			end;
		end;

	print_immediate_register is
			-- Print expression value for immediate use,
			-- not for passing as an argument.
		do
			if register /= Void and then is_compaund then
				register.print_register
			else
				print_register
			end
		end

	fill_from (p: PARAMETER_B) is
			-- Fill in node from parameter `b'
		do
			expression := p.expression.enlarged
			internal_attachment_type := p.internal_attachment_type
			is_formal := p.is_formal
			is_for_tuple_access := p.is_for_tuple_access
			parent := p.parent
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

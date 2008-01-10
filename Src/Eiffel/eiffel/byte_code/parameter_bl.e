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

feature

	register: REGISTRABLE;
			-- Register used to store metamorphosed value

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	c_type: TYPE_C is
			-- C type of the attachment target
		do
			Result := real_type (attachment_type).c_type;
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
		do
			expression.analyze;
			if is_compaund then
				register := context.get_argument_register (c_type)
			elseif expression.is_register_required (real_type (attachment_type)) then
				get_register
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
			target_type, source_type: TYPE_I
		do
			target_type := real_type (attachment_type)
			source_type := real_type (expression.type)
			if source_type.is_none and target_type.is_expanded then
				buffer.put_new_line
				buffer.put_string ("RTEC(EN_VEXP);")
			else
				expression.generate_for_type (register, target_type)
			end
		end

	print_register is
			-- Print expression value that can be used as an argument to a routine.
		local
			target_type, source_type: TYPE_I;
			l_basic: BASIC_I
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
					l_basic.generate_default_value (buf)
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
					-- In that case, we have been careful not to propagate any
					-- 'No_register' value. However, this does not mean there
					-- is an attached register if the source is basic (e.g. if
					-- we have the constant '4' or '5 - 3'). This is where
					-- the 'register' attribute plays its role...
				if source_type.is_expanded then
					register.print_register;
				else
					expression.print_register;
				end;
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

indexing
	description: "Enlarged byte code for manifest tuples"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_CONST_BL

inherit
	TUPLE_CONST_B
		redefine
			analyze, generate,
			register, set_register,
			free_register, unanalyze
		end;
	SHARED_TABLE
	SHARED_DECLARATIONS

create
	make

feature

	register: REGISTRABLE
			-- Register for TUPLE

	metamorphose_reg: REGISTER
			-- Register for metamorphosis

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r
		end

	analyze is
			-- Analyze expression
		local
			real_ty: TUPLE_TYPE_I
			expr_type: TYPE_I
			expr: EXPR_B
			i: INTEGER
			require_meta: BOOLEAN
		do
			-- We need 'Current'
			context.add_dftype_current

			real_ty ?= context.real_type (type)

			get_register
			from
				i := 0
				expressions.start
			until
				expressions.after
			loop
				expr ?= expressions.item
				expr_type := context.real_type (expr.type)

				if expr_type.is_true_expanded then
					require_meta := True
				end
				expr.analyze
				expr.free_register
				expressions.forth
				i := i + 1
			end
			if require_meta then
				create metamorphose_reg.make (Reference_c_type)
			end
		end

	unanalyze is
			-- Unanalyze expression
		local
			expr: EXPR_B
		do
			metamorphose_reg := Void
			set_register (Void)
			from
				expressions.start
			until
				expressions.after
			loop
				expr ?= expressions.item
				expr.unanalyze
				expressions.forth
			end
		end

	free_register is
			-- Free the registers.
		do
			Precursor {TUPLE_CONST_B}
			if metamorphose_reg /= Void then
				metamorphose_reg.free_register
			end
		end

	generate is
			-- Generate expression
		local
			real_ty: TUPLE_TYPE_I
			workbench_mode: BOOLEAN
		do
			real_ty ?= context.real_type (type)
			workbench_mode := context.workbench_mode
			generate_tuple_creation (real_ty, workbench_mode)
			fill_tuple (real_ty.meta_generic)
		end

feature {NONE} -- C code generation

	generate_tuple_creation (real_ty: TUPLE_TYPE_I; workbench_mode: BOOLEAN) is
			-- Generate the object creation of
			-- manifest tuple.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.generate_block_open
			context.generate_gen_type_conversion (real_ty)
			buf.put_new_line
			print_register
			buf.put_string (" = ")
			buf.put_string ("RTLNTS(typres, ");
			buf.put_integer (real_ty.true_generics.count + 1)
			buf.put_string (", ")
			if real_ty.is_basic_uniform then
				buf.put_integer (1)
			else
				buf.put_integer (0)
			end
			buf.put_string (");");
			buf.generate_block_close
		end

	fill_tuple (target_types: META_GENERIC) is
			-- Generate the registers for the expressions
			-- to fill the manifest tuple.
		local
			expr: EXPR_B
			actual_type: TYPE_I
			metamorphosed: BOOLEAN
			i: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			from
				expressions.start
				i := 1
			until
				expressions.after
			loop
				metamorphosed := False
				expr ?= expressions.item
				actual_type := context.real_type (expr.type)
					-- If `actual_type' is NONE, it means we are handling `Void'
					-- and therefore nothing has to be done.
				if not actual_type.is_none then
					if actual_type.is_true_expanded then
						expr.generate
						buf.put_new_line
						metamorphose_reg.print_register
						buf.put_string (" = RTCL(")
						expr.print_register
						buf.put_string (");")
						buf.put_new_line
						metamorphosed := True
					else
						expr.generate
					end
					-- Generate initializations of values.
					buf.put_new_line
					buf.put_string ("((EIF_TYPED_VALUE *)")
					print_register
					buf.put_character('+');
					buf.put_integer (i)
					buf.put_string (")->")
					actual_type.c_type.generate_typed_field (buf)
					buf.put_string (" = ")
					if metamorphosed then
						metamorphose_reg.print_register
					else
						expr.print_register
					end
					buf.put_character (';')
						-- Generation of the RTAR protection
						-- since the array contains references
					if not actual_type.is_basic then
						buf.put_new_line
						buf.put_string ("RTAR(")
						print_register
						buf.put_character (',')
						if metamorphosed then
							metamorphose_reg.print_register
						else
							expr.print_register
						end
						buf.put_character (')')
						buf.put_character (';')
					end
				end
				expressions.forth
				i := i + 1
			end
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

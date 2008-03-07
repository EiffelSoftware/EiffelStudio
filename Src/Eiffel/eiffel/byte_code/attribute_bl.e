indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarged access to an Eiffel attribute

class ATTRIBUTE_BL

inherit
	ATTRIBUTE_B
		redefine
			free_register,
			basic_register, generate_access_on_type,
			is_polymorphic, generate_on, generate_access,
			analyze_on, analyze, set_parent, parent, set_register, register
		end

	SHARED_TABLE

	SHARED_WORKBENCH

	SHARED_DECLARATIONS

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature

	parent: NESTED_B
			-- Parent of the current call

	set_parent (p: NESTED_B) is
			-- Assign `p' to `parent'
		do
			parent := p
		end

	register: REGISTRABLE
			-- In which register the expression is stored

	basic_register: REGISTRABLE
			-- Register used to store the metamorphosed simple type

	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
			register := r
		end

	free_register is
			-- Free registers
		do
			Precursor {ATTRIBUTE_B}
			if basic_register /= Void then
				basic_register.free_register
			end
		end

	analyze is
			-- Analyze attribute
		do
debug
io.error.put_string ("In attribute_bl%N")
io.error.put_string (attribute_name)
io.error.put_new_line
end
			analyze_on (Current_register)
			get_register
debug
io.error.put_string ("Out attribute_bl%N")
end
		end

	analyze_on (reg: REGISTRABLE) is
			-- Analyze access to attribute on `reg'
		local
			tmp_register: REGISTER
		do
debug
io.error.put_string ("In attribute_bl [analyze_on]: ")
io.error.put_string (attribute_name)
io.error.put_new_line
end
			if reg.is_current then
				context.mark_current_used
			end
				-- Check whether we'll need to compute the dynamic type
				-- of current or not.
			check_dt_current (reg)
			if context_type.is_basic then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
				create tmp_register.make (Reference_c_type)
				basic_register := tmp_register
			end
debug
io.error.put_string ("Out attribute_bl [analyze_on]: ")
io.error.put_string (attribute_name)
io.error.put_new_line
end
		end

	generate_on (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		do
			do_generate (reg)
		end

	generate_access is
			-- Generate access to attribute
		do
			do_generate (Current_register)
		end

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_A
		do
				-- Do nothing if `reg' is not the current entity
			if reg.is_current then
				class_type ?= context_type
				if class_type /= Void then
					if Eiffel_table.is_polymorphic (routine_id, class_type, context.context_class_type, False) >= 0 then
						context.add_dt_current
					end
				end
			end
		end

	is_polymorphic: BOOLEAN is
			-- Is access polymorphic ?
		local
			class_type: CL_TYPE_A
			type_i: TYPE_A
		do
			type_i := context_type
			if not type_i.is_basic then
				class_type ?= type_i;	-- Cannot fail
				Result := Eiffel_table.is_polymorphic (routine_id, class_type, context.context_class_type, False) >= 0
			end
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A) is
			-- Generate attribute in a `typ' context
		local
			table_name: STRING
			offset_class_type: CLASS_TYPE
			type_c: TYPE_C
			type_i: TYPE_A
			buf: GENERATION_BUFFER
			array_index: INTEGER
		do
			buf := buffer
			type_i := real_type (type)
			type_c := type_i.c_type
				-- No need to use dereferencing if object is an expanded
				-- or if it is a bit.
			if not type_i.is_true_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				buf.put_character ('*')
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (buf)
			end
			buf.put_character ('(')
			if context.workbench_mode or reg.is_current then
				reg.print_register
			else
				buf.put_string ("RTCV(")
				reg.print_register
				buf.put_character (')')
			end
			array_index := Eiffel_table.is_polymorphic (routine_id, typ, context.context_class_type, False)
			if array_index >= 0 then
					-- The access is polymorphic, which means the offset
					-- is not a constant and has to be computed.
				table_name := Encoder.attribute_table_name (routine_id)

					-- Generate following dispatch:
					-- table [Actual_offset - base_offset]
				buf.put_string (" + ")
				buf.put_string (table_name)
				buf.put_character ('[')
				if reg.is_current then
					context.generate_current_dtype
				else
					buf.put_string (gc_upper_dtype_lparan)
					reg.print_register
					buf.put_character (')')
				end
				buf.put_character ('-')
				buf.put_integer (array_index)
				buf.put_character (']')

					-- Mark attribute offset table used.
				Eiffel_table.mark_used (routine_id)
					-- Remember external attribute offset declaration
				Extern_declarations.add_attribute_table (table_name)
			else
					-- Hardwire the offset
				offset_class_type := typ.associated_class_type (context.context_class_type.type)
					--| In this instruction, we put `False' as second
					--| arguments. This means we won't generate anything if there is nothing
					--| to generate. Remember that `True' is used in the generation of attributes
					--| table in Final mode.
				offset_class_type.skeleton.generate_offset (buf, real_feature_id (typ), False, True)
			end
			buf.put_character (')')
		end

	fill_from (a: ATTRIBUTE_B) is
			-- Fill in node with attribute `a'
		do
			attribute_name_id := a.attribute_name_id
			attribute_id := a.attribute_id
			type := a.type
			routine_id := a.routine_id
			multi_constraint_static := a.multi_constraint_static
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

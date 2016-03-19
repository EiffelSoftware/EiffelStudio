note
	description: "Enlarged access to an Eiffel attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class ATTRIBUTE_BL

inherit
	ATTRIBUTE_B
		redefine
			free_register,
			generate_access_on_type,
			generate_parameters,
			is_polymorphic,
			generate_on,
			generate_access,
			analyze_on,
			analyze,
			set_parent,
			parent,
			set_register,
			register,
			generate_finalized_separate_call_args
		end

	SHARED_TABLE

	SHARED_WORKBENCH

	SHARED_DECLARATIONS

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	fill_from

feature

	parent: NESTED_B
			-- Parent of the current call

	set_parent (p: NESTED_B)
			-- Assign `p' to `parent'
		do
			parent := p
		end

	register: REGISTRABLE
			-- In which register the expression is stored

	set_register (r: REGISTRABLE)
			-- Set current register to `r'
		do
			register := r
		end

	free_register
			-- Free registers
		do
			Precursor {ATTRIBUTE_B}
		end

	analyze
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

	analyze_on (reg: REGISTRABLE)
			-- Analyze access to attribute on `reg'
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
debug
io.error.put_string ("Out attribute_bl [analyze_on]: ")
io.error.put_string (attribute_name)
io.error.put_new_line
end
		end

	generate_on (reg: REGISTRABLE)
			-- Generate call of feature on `reg'
		do
			do_generate (reg)
		end

	generate_access
			-- Generate access to attribute
		do
			do_generate (Current_register)
		end

	check_dt_current (reg: REGISTRABLE)
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		do
				-- Do nothing if `reg' is not the current entity
			if reg.is_current then
				if Eiffel_table.is_polymorphic (routine_id, context_type, context.context_class_type, False) >= 0 then
					context.add_dt_current
				end
			end
		end

	is_polymorphic: BOOLEAN
			-- Is access polymorphic ?
		local
			type_i: TYPE_A
		do
			type_i := context_type
			if not type_i.is_basic then
				Result := Eiffel_table.is_polymorphic (routine_id, type_i, context.context_class_type, False) >= 0
			end
		end

	generate_parameters (reg: REGISTRABLE)
			-- <Precursor>
			-- Attributes have no arguments.
		do
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate attribute in a `typ' context
		local
			table_name: STRING
			type_c: TYPE_C
			type_i: TYPE_A
			buf: GENERATION_BUFFER
			array_index: INTEGER
		do
			if not reg.c_type.is_reference then
					-- This is an access on a value of an object of basic type.
				reg.print_register
			else
				buf := buffer
				type_i := real_type (type)
				type_c := type_i.c_type
					-- No need to use dereferencing if object is an expanded
					-- or if it is a bit.
				if not type_i.is_true_expanded then
						-- For dereferencing, we need a star...
					buf.put_character ('*')
						-- ...followed by the appropriate access cast
					type_c.generate_access_cast (buf)
				end
				buf.put_character ('(')
				reg.print_target_register
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
						buf.put_string ({C_CONST}.dtype);
						buf.put_character ('(')
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
					check
						is_attribute_table: attached {ATTR_TABLE [ATTR_ENTRY]} eiffel_table.poly_table (routine_id) as l_attr
					then
						l_attr.generate_attribute_offset (buf, typ, context.context_class_type)
					end
				end
				buf.put_character (')')
			end
		end

	fill_from (a: ATTRIBUTE_B)
			-- Fill in node with attribute `a'
		do
			attribute_name_id := a.attribute_name_id
			attribute_id := a.attribute_id
			type := a.type
			routine_id := a.routine_id
			multi_constraint_static := a.multi_constraint_static
			is_attachment := a.is_attachment
		end

feature {NONE} -- Separate call

	generate_finalized_separate_call_args (a_target: REGISTRABLE; a_has_result: BOOLEAN)
			-- <Precursor>
		local
			buf: GENERATION_BUFFER
			array_index: INTEGER_32
			target_type: TYPE_A
			name: STRING
		do
			buf := buffer

				-- Generate the feature name.
			buf.put_string ({C_CONST}.null)

				-- Generate the feature pattern.
			buf.put_two_character (',', ' ')
			system.separate_patterns.put (Current)

				-- Generate the offset.
			buf.put_two_character (',', ' ')

			target_type := context_type
			array_index := Eiffel_table.is_polymorphic (routine_id, target_type, Context.context_class_type, True)
			if array_index >= 0 then
					-- The access is polymorphic, which means the offset
					-- is not a constant and has to be computed.
				name := Encoder.attribute_table_name (routine_id)
					-- Generate following dispatch:
					-- table [Actual_offset - base_offset]
				buf.put_string (name)
				buf.put_character ('[')
				buf.put_string ({C_CONST}.dtype);
				buf.put_character ('(')
				a_target.print_register
				buf.put_character (')')
				buf.put_character ('-')
				buf.put_integer (array_index)
				buf.put_character (']')
					-- Mark attribute offset table used.
				Eiffel_table.mark_used (routine_id)
					-- Remember external attribute offset declaration
				Extern_declarations.add_attribute_table (name)
			else
					-- Hardwire the offset
				check
					attached {ATTR_TABLE [ATTR_ENTRY]} eiffel_table.poly_table (routine_id) as attr_table
				then
						-- Offset is not generated if it is zero, so to make the generated code valid,
						-- the base value "0" has to be generated.
					buf.put_character ('0')
					attr_table.generate_attribute_offset (buf, target_type, context.context_class_type)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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

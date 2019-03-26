note
	description: "Enlarged access to an Eiffel attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class ATTRIBUTE_BL

inherit
	ATTRIBUTE_B
		redefine
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
	fill_from,
	fill_from_access

feature {NONE} -- Creation

	fill_from (a: ATTRIBUTE_B)
			-- Fill in node with attribute `a`.
		require
			system.has_class_of_id (a.written_in)
			attached system.class_of_id (a.written_in) as c
			attached c.feature_of_rout_id (a.routine_id) as f
			f.is_attribute
			f.rout_id_set.has (a.routine_id)
		do
			attribute_name_id := a.attribute_name_id
			routine_id := a.routine_id
			attribute_id := a.attribute_id
			written_in := a.written_in
			type := a.type
			multi_constraint_static := a.multi_constraint_static
			is_attachment := a.is_attachment
		ensure
			attribute_name_id = a.attribute_name_id
			routine_id = a.routine_id
			attribute_id = a.attribute_id
			written_in = a.written_in
			type = a.type
			multi_constraint_static = a.multi_constraint_static
			is_attachment = a.is_attachment
		end

	fill_from_access (a: CALL_ACCESS_B; f: FEATURE_I)
			-- Fill in node with attribute `f` originally represented by `a`.
		require
			f.is_attribute
			system.has_class_of_id (f.written_in)
			attached system.class_of_id (f.written_in) as c
				-- `f` could come from a descendant and originate from an unrelated class.
			f.rout_id_set.has (a.routine_id)
		do
			attribute_name_id := f.feature_name_id
			routine_id := f.rout_id_set.first
			attribute_id := f.feature_id
			written_in := f.written_in
			type := a.type
			multi_constraint_static := a.multi_constraint_static
				-- `is_attachment` is `False` by default.
		ensure
			attribute_name_id = f.feature_name_id
			routine_id = f.rout_id_set.first
			attribute_id = f.feature_id
			written_in = f.written_in
			type = a.type
			multi_constraint_static = a.multi_constraint_static
			not is_attachment
		end

feature

	parent: NESTED_B
			-- Parent of the current call.

	set_parent (p: NESTED_B)
			-- Assign `p` to `parent`.
		do
			parent := p
		end

	register: REGISTRABLE
			-- In which register the expression is stored.

	set_register (r: REGISTRABLE)
			-- Set current register to `r'
		do
			register := r
		end

	analyze
			-- Analyze attribute
		do
			analyze_on (Current_register)
			get_register
		end

	analyze_on (reg: REGISTRABLE)
			-- Analyze access to attribute on `reg'
		do
			if reg.is_current then
				context.mark_current_used
					-- Check whether we'll need to compute the dynamic type of current.
				if is_polymorphic then
					context.add_dt_current
				end
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

	is_polymorphic: BOOLEAN
			-- Is access polymorphic?
		local
			type_i: TYPE_A
		do
			type_i := context_type
			if not type_i.is_basic then
				Result := eiffel_table.is_polymorphic_for_offset (routine_id, type_i, context.original_class_type) >= 0
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
			type_c: TYPE_C
			type_i: TYPE_A
			buf: GENERATION_BUFFER
		do
			if reg.c_type.is_reference then
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
				eiffel_table.generate_offset (routine_id, reg, typ, context.original_class_type, buf)
				buf.put_character (')')
			else
					-- This is an access on a value of an object of basic type.
				reg.print_register
			end
		end

feature {NONE} -- Separate call

	generate_finalized_separate_call_args (a_target: REGISTRABLE; a_has_result: BOOLEAN)
			-- <Precursor>
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- Generate the feature name.
			buf.put_string ({C_CONST}.null)
				-- Generate the feature pattern.
			buf.put_two_character (',', ' ')
			system.separate_patterns.put (Current)
				-- Generate the offset.
			buf.put_three_character (',', ' ', '0')
			eiffel_table.generate_offset (routine_id, a_target, context_type, context.context_class_type, buf)
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

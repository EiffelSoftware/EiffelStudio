note
	description: "Encapsulation of an IL extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class IL_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_il, same_as, is_static
		end

	SHARED_IL_CONSTANTS
		export
			{NONE} all
			{ANY} valid_type, need_current
		undefine
			is_equal
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		undefine
			is_equal
		end

feature -- Access

	type: INTEGER
			-- Type of IL external.
			--| See SHARED_IL_CONSTANTS for all types constants.

	base_class: STRING
			-- Name of IL class where feature is defined

feature -- Status report

	is_il: BOOLEAN = True
			-- Current external is an IL external.

	is_static: BOOLEAN
			-- <Precursor>
		do
			Result := not need_current (type)
		end

feature -- Settings

	set_type (v: INTEGER)
			-- Assign `v' to `type'.
		require
			valid_type: valid_type (v)
		do
			type := v
		ensure
			type_set: type = v
		end

	set_base_class (name: STRING)
			-- Assign `name' to `base_class'.
		require
			name_not_void: name /= Void
		do
			base_class := name
		ensure
			base_class_set: base_class = name
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN
		do
			Result := Precursor {EXTERNAL_EXT_I} (other) and then (type = other.type and equal (base_class, other.base_class))
		end

feature -- Generation access

	token: INTEGER
		do
			Result := il_generator.external_token (base_class, names_heap.item (alias_name_id),
				type, argument_types, return_type)
		end

feature -- Call generation

	generate_call (is_polymorphic: BOOLEAN)
			-- Generate external feature call on Current.
		require
			valid_call: alias_name_id > 0 or else
				type = {SHARED_IL_CONSTANTS}.Creator_type
		do
			check
				type_not_enum: type /= Enum_field_type
			end
			if is_generic_method then
				il_generator.generate_external_generic_call (base_class, Names_heap.item (alias_name_id),
					type, argument_types, generic_method_parameters_info, return_type, is_polymorphic)
			else
				il_generator.generate_external_call (base_class, Names_heap.item (alias_name_id),
					type, argument_types, return_type, is_polymorphic)
			end
		end

	generate_external_creation_call (a_actual_type: CL_TYPE_A)
			-- Generate external creation call for `a_actual_type', where constructor comes
			-- from `Current'.
		require
			a_actual_type_not_void: a_actual_type /= Void
			valid_call: alias_name_id > 0 or else
				type = {SHARED_IL_CONSTANTS}.Creator_type
		do
			check
				type_not_enum: type /= Enum_field_type
			end
			il_generator.generate_external_creation_call (a_actual_type, Names_heap.item (alias_name_id),
				type, argument_types, return_type)
		end

	generate_creation_call
			-- Generate external feature call on constructor `n' using information
			-- of Current wihtout creating an object.
		require
			valid_call: type = {SHARED_IL_CONSTANTS}.Creator_type
		do
				-- Generate a normal non-virtual call.
			il_generator.generate_external_call (base_class, Names_heap.item (alias_name_id),
				creator_call_type, argument_types, return_type, False)
		end

	generate_body (il_byte_code: EXT_BYTE_CODE; a_result: RESULT_B)
			-- Generate C code.
		do
			-- Do nothing here since IL code does not generate into C code.
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class IL_EXTENSION_I

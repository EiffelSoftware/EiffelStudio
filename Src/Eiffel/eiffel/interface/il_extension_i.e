indexing
	description: "Encapsulation of an IL extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class IL_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_il
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

	is_il: BOOLEAN is True
			-- Current external is an IL external.

	type: INTEGER
			-- Type of IL external.
			--| See SHARED_IL_CONSTANTS for all types constants.

	base_class: STRING
			-- Name of IL class where feature is defined

feature -- Settings

	set_type (v: INTEGER) is
			-- Assign `v' to `type'.
		require
			valid_type: valid_type (v)
		do
			type := v
		ensure
			type_set: type = v
		end

	set_base_class (name: STRING) is
			-- Assign `name' to `base_class'.
		require
			name_not_void: name /= Void
		do
			base_class := name
		ensure
			base_class_set: base_class = name
		end

feature -- Generation access

	token: INTEGER is
		do
			Result := il_generator.external_token (base_class, names_heap.item (alias_name_id),
				type, argument_types, return_type)
		end

feature -- Call generation

	generate_call (is_polymorphic: BOOLEAN) is
			-- Generate external feature call on Current.
		require
			valid_call: alias_name_id > 0 or else
				type = {SHARED_IL_CONSTANTS}.Creator_type
		do
			check
				type_not_enum: type /= Enum_field_type
			end
			il_generator.generate_external_call (base_class, Names_heap.item (alias_name_id),
				type, argument_types, return_type, is_polymorphic)
		end

	generate_external_creation_call (a_actual_type: CL_TYPE_A) is
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

	generate_creation_call is
			-- Generate external feature call on constructor `n' using information
			-- of Current wihtout creating an object.
		require
			valid_call: type = {SHARED_IL_CONSTANTS}.Creator_type
		do
				-- Generate a normal non-virtual call.
			il_generator.generate_external_call (base_class, Names_heap.item (alias_name_id),
				creator_call_type, argument_types, return_type, False)
		end

	generate_body (il_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate C code.
		do
			-- Do nothing here since IL code does not generate into C code.
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

end -- class IL_EXTENSION_I

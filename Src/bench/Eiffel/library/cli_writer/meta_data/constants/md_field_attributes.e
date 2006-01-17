indexing
	description: "Available properties for field."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_FIELD_ATTRIBUTES

feature -- Access

	field_access_mask: INTEGER_16 is 0x0007

	compiler_controlled: INTEGER_16 is 0x0000
			-- Member not referenceable.

	private: INTEGER_16 is 0x0001
			-- Accessible only by the parent type.

	family_and_assembly: INTEGER_16 is 0x0002
			-- Accessible by sub-types only in this Assembly.

	assembly: INTEGER_16 is 0x0003
			-- Accessibly by anyone in the Assembly.

	family: INTEGER_16 is 0x0004
			-- Accessible only by type and sub-types.

	family_or_assembly: INTEGER_16 is 0x0005
			-- Accessibly by sub-types anywhere, plus anyone in assembly.

	public: INTEGER_16 is 0x0006
			-- Accessibly by anyone who has visibility to .

feature -- Type of field

	static: INTEGER_16 is 0x0010
			-- Defined on type, else per instance.

	init_only: INTEGER_16 is 0x0020
			-- Field may only be initialized, not written to after init.

	literal: INTEGER_16 is 0x0040
			-- Value is compile time constant.

	not_serialized: INTEGER_16 is 0x0080
			-- Field does not have to be serialized when type is remoted.

	special_name: INTEGER_16 is 0x0200
			-- Field is special.

feature -- Interop Attributes

	pinvoke_implementation: INTEGER_16 is 0x2000
			-- Implementation is forwarded through PInvoke..

feature -- Additional flags

	rt_special_name: INTEGER_16 is 0x0400
			-- CLI provides 'special' behavior, depending upon the name of the field.

	has_field_marshal: INTEGER_16 is 0x1000
			-- Field has marshalling information.

	has_default: INTEGER_16 is 0x8000
			-- Field has default.

	has_field_rva: INTEGER_16 is 0x0100;
			-- Field has RVA.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class MD_FIELD_ATTRIBUTES

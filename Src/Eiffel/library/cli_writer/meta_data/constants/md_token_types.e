indexing
	description: "All possible types of metadata token"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TOKEN_TYPES

feature -- Access

	md_module: INTEGER is 0x00000000
	md_type_ref: INTEGER is 0x01000000
	md_type_def: INTEGER is 0x02000000
	md_field_def: INTEGER is 0x04000000
	md_method_def: INTEGER is 0x06000000
	md_param_def: INTEGER is 0x08000000
	md_interface_impl: INTEGER is 0x09000000
	md_member_ref: INTEGER is 0x0a000000
	md_custom_attribute: INTEGER is 0x0c000000
	md_permission: INTEGER is 0x0e000000
	md_signature: INTEGER is 0x11000000
	md_event: INTEGER is 0x14000000
	md_property: INTEGER is 0x17000000
	md_module_ref: INTEGER is 0x1a000000
	md_type_spec: INTEGER is 0x1b000000
	md_assembly: INTEGER is 0x20000000
	md_assembly_ref: INTEGER is 0x23000000
	md_file: INTEGER is 0x26000000
	md_exported_type: INTEGER is 0x27000000
	md_manifest_resource: INTEGER is 0x28000000
	md_string: INTEGER is 0x70000000
	md_name: INTEGER is 0x71000000
			-- All possible types of tokens.

	md_mask: INTEGER is 0xFF000000
			-- Mask to get token type.

	md_base_type: INTEGER is 0x72000000;
			--  Leave this on the high end value. This does not correspond to metadata table
	
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

end -- class MD_TOKEN_TYPES

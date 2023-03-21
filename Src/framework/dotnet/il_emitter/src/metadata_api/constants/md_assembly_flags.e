note
	description: "Possible flags you can pass to `define_assembly' from `MD_ASSEMBLY_EMIT'"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ASSEMBLY_FLAGS

feature -- Access

	side_by_side_compatible: INTEGER = 0
			-- The assembly is side by side compatible.

	public_key: INTEGER = 1
			-- The assembly reference holds the full (unhashed) public key.

	reserved: INTEGER = 0x00000030
			-- Reserved: Both bits shall be zero.

	enable_jit_compile_tracking: INTEGER = 0x00008000
			-- Reserved:  a conforming implementation of the CLI may ignore this
			-- setting on read; some implementations might use this bit to indicate
			-- that a CIL-to-native-code compiler should generate CIL-to-native code map.

	disable_jit_compiler_optimizer: INTEGER = 0x00004000;
	-- Reserved: a conforming implementation of the CLI may ignore this
	-- setting on read; some implementations might use this bit to indicate
	-- that a CIL-to-native-code compiler should not generate optimized code.

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class MD_ASSEMBLY_FLAGS

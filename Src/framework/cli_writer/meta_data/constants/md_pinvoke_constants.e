indexing
	description: "Flags to define a Pinvoke routine in call to `MD_EMIT.define_pinvoke_map'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PINVOKE_CONSTANTS

feature -- Access

  	no_mangle: INTEGER_16 is 0x0001
			-- Pinvoke is to use the member name as specified.

feature -- Access: CharSet information

	charset_mask: INTEGER_16 is 0x0006
			-- Use this mask to retrieve the CharSet information.

	charset_not_specified: INTEGER_16 is 0x0000
	charset_ansi: INTEGER_16 is 0x0002
	charset_unicode: INTEGER_16 is 0x0004
	charset_auto: INTEGER_16 is 0x0006

	supports_last_error: INTEGER_16 is 0x0040
			-- Information about target function. Not relevant for fields.

feature -- Access: calling convention

	calling_convention_mask: INTEGER_16 is 0x0700

	winapi: INTEGER_16 is 0x0100
			-- Pinvoke will use native callconv appropriate to target windows platform.

	cdecl: INTEGER_16 is 0x0200
	stdcall: INTEGER_16 is 0x0300

	thiscall: INTEGER_16 is 0x0400
			-- In M9, pinvoke will raise exception.

	fastcall: INTEGER_16 is 0x0500;

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

end -- class MD_PINVOKE_CONSTANTS

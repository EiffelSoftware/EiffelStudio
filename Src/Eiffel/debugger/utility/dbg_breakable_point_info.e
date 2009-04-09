note
	description: "Summary description for {DEBUGGER_BREAKABLE_POINT_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_BREAKABLE_POINT_INFO

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_bp, a_bp_nested: INTEGER)
			-- Instanciate info with breakable index
		do
			bp := a_bp
			bp_nested := a_bp_nested
		end

feature -- Access

	bp: INTEGER
			-- Breakable index

	bp_nested: INTEGER
			-- Breakable nested index	

	class_c: CLASS_C assign set_class_c

	line: INTEGER assign set_line

	text: STRING assign set_text

feature -- Change

	set_class_c (v: like class_c)
			-- Set `class_c' to `v'
		do
			class_c := v
		end

	set_line (v: like line)
			-- Set `line' to `v'
		do
			line := v
		end

	set_text (v: like text)
			-- Set `text' to `v'
		do
			text := v
		end

feature -- Status report

	debug_output: STRING
		local
			fi: FORMAT_INTEGER
		do
			create Result.make (20)

			if bp_nested > 0 then
				create fi.make (3)
				fi.left_justify
				Result.append_string (fi.formatted (bp))

				Result.append_character ('+')
				Result.append_integer (bp_nested)
			else
				create fi.make (5)
				fi.left_justify
				Result.append_string (fi.formatted (bp))
			end
			Result.append_character (' ')
			Result.append_character ('<')
			Result.append_string (class_c.name_in_upper)
			Result.append_character ('#')
			Result.append_integer (line)
			Result.append_character ('>')
			Result.append_character (':')
			Result.append_character (' ')
			Result.append_string (text)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

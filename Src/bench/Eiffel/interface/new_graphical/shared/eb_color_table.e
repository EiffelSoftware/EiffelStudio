indexing
	description: "$EiffelGraphicalCompiler$ basic colors table"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COLOR_TABLE

inherit
	EV_BASIC_COLORS

feature -- Constants

	color_table: HASH_TABLE [EV_COLOR, STRING] is
			--
		once
			Create Result.make (16)

			Result.put (white, "white")
			Result.put (black, "black")
			Result.put (grey, "grey")
			Result.put (dark_grey, "dark grey")
			Result.put (blue, "blue")
			Result.put (dark_blue, "dark blue")
			Result.put (cyan, "cyan")
			Result.put (dark_cyan, "dark cyan")
			Result.put (green, "green")
			Result.put (dark_green, "dark green")
			Result.put (yellow, "yellow")
			Result.put (dark_yellow, "dark yellow")
			Result.put (red, "red")
			Result.put (dark_red, "dark red")
			Result.put (magenta, "magenta")
			Result.put (dark_magenta, "dark magenta")
		ensure
			sixteen_colors: Result.count = 16
		end

	color_from_table (s: STRING): EV_COLOR is
			-- color named `s' in the table
			-- black if color `s' is not in table
		local
			c: EV_COLOR
		do
			c := color_table.item (s)

			if c = Void then
				Create Result.make
				Result.set_name (s)
			else
				Result := deep_clone (c)
			end
		end

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

end -- class EB_COLOR_TABLE

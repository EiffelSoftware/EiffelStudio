indexing
	description: "List of clickable syntax items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLICK_LIST

inherit
	ARRAYED_LIST [CLICK_AST]
		export
			{ANY} area, lower, upper
		end

create
	make

create {CLICK_LIST}
	make_filled

feature -- Access

	item_by_node (a_node: CLICKABLE_AST): CLICK_AST is
			-- Return item with `node' `a_node'.
		local
			i: INTEGER
		do
			from i := 1 until Result /= Void or i > count loop
				if i_th (i).node = a_node then
					Result := i_th (i)
					i := i + 1
				end
			end
		end

feature -- Debug

	trace is
			-- Output to `io.error'.
		local
			i: INTEGER
		do
			io.error.put_string ("Click list is:%N")
			io.error.put_string (out)
			io.error.put_string ("Content is:%N")
			from
			until
				i = count
			loop
				i := i + 1
				io.error.put_string (i_th (i).out)
			end
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

end -- class CLICK_LIST

indexing
	description: "Documentation Page."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_DOCUMENTATION_PAGE

create
	make

feature -- Initialization

	make(s: STRING) is
			-- Initialization
		require
			not_void: s /= Void
		local
			ind,ind2: INTEGER
			ss: STRING
			err: BOOLEAN
		do
			if not err then
				error := FALSE
				Create list.make
				ss := clone(s)
				ind := 2
				from
				until
					(ind<2)
				loop
					ind := ss.substring_index("<FL_LOOP>",1)
					ind2 := ss.substring_index("</FL_LOOP>",ind)
					if ind >1 and then ind2>ind then
						list.extend(ss.substring(1,ind-1))
						list.extend(ss.substring(ind,ind2+10))
						ss := ss.substring(ind2+11,ss.count)
					else
						list.extend(ss)
					end
				end
			else
				error := TRUE
			end
		rescue
			err := TRUE
			retry
		end

feature -- Access

	error: BOOLEAN

	list: LINKED_LIST[STRING];
	
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

end -- class XML_DOCUMENTATION_PAGE

indexing
	description: "XML Field"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FIELD

inherit
	XML_COMPOSITE

creation
	make

feature -- Initialization

	make (n: STRING) is
			-- Initialize
		do
			name:= n
			!! heir.make
		end

feature -- Access

	name: STRING

	heir: LINKED_LIST [XML_COMPOSITE]

feature --Managment

	add_heir (c: XML_COMPOSITE) is
		do
			heir.extend (c)
		end

invariant
	XML_FIELD_not_void: heir /= Void and name /= Void
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
end -- class XML_FIELD

indexing
	description: "A hyperlink to a topic on a E_TOPIC_DISPLAY"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"

class
	E_TOPIC_LINK

creation
	make

feature -- Initialization

	make(f, l: INTEGER; id: STRING) is
			-- Initialize
		require
			positive: f>= 0 
			consistent: f <=l
			not_void: id /= Void
		do
			first := f
			last := l
			topic_id := id
		ensure
			first_set: first = f
			last_set: last = l
			topic_id_set: topic_id = id
		end

feature -- Basic operations

	is_in_region(pos: INTEGER): BOOLEAN is
			-- Returns whether pos is in this link.
		require
			positive: pos >=0
		do
			Result := (pos>first) and then (pos<=last+1)
		end

feature -- Access

	first, last: INTEGER
			-- The first & last char-index of this link.

	topic_id: STRING
			-- The topic this link points to.

invariant
	E_TOPIC_LINK_consistent: first <= last and first >= 0
	E_TOPIC_LINK_exists: topic_id /= Void

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
end -- class E_TOPIC_LINK

indexing
	description: "Description of an export clause."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLIENT_I

inherit
	COMPARABLE
		redefine
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			is_equal
		end

	SHARED_NAMES_HEAP
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (c: like clients; i: like written_in) is
			-- Initialize current with `c' and `i'.
		require
			c_not_void: c /= Void
			i_positive: i > 0
		do
			clients := c
			written_in := i
		ensure
			clients_set: clients = c
			written_in_set: written_in = i
		end

feature -- Access

	written_in: INTEGER
			-- Id of the class where the client list is written in

	clients: ID_LIST
			-- Client list IDs (indexed in names_heap)

feature -- Comparison

	is_equal (other: CLIENT_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := written_in = other.written_in
		end

	infix "<" (other: CLIENT_I): BOOLEAN is
			-- is `other greater than Current ?
		do
			Result := written_in < other.written_in
		end

feature -- Status report

	written_class: CLASS_C is
			-- Class in which Current is written.
		do
			Result := System.class_of_id (written_in)
		end

feature -- Query

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the client `client' valid for the current client list ?
		require
			good_argument: client /= Void
			consistency: System.class_of_id (written_in) /= Void
		local
			supplier_class: CLASS_I
			group: CONF_GROUP
			l_names_heap: like names_heap
			i, nb: INTEGER
		do
			from
				l_names_heap := names_heap
				group := System.class_of_id (written_in).group
				i := 1
				nb := clients.count
			until
				i > nb or else Result
			loop
				supplier_class := Universe.class_named (l_names_heap.item (clients.item (i)), group)
				if supplier_class /= Void and then supplier_class.is_compiled then
					Result := client.conform_to (supplier_class.compiled_class)
				end
				i := i + 1
			end
		end

feature -- Incrementality

	equiv (other: CLIENT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?	
			-- [Result implies "`clients' is a subset of `other.clients'"]
		require
			good_argument: other /= Void
			consistency: other.written_in = written_in
		local
			other_clients: like clients
			i, nb: INTEGER
		do
			from
				other_clients := other.clients
				Result := True
				i := 1
				nb := clients.count
			until
				i > nb or else not Result
			loop
				Result := other_clients.has (clients.item (i))
				i := i + 1
			end
		end

	same_as (other: CLIENT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void
			same_written_in: written_in = other.written_in
		local
			other_clients: like clients
			i, c: INTEGER
		do
			c := clients.count
			other_clients := other.clients
			if c = other_clients.count then
				from
					Result := True
					i := 1
				until
					i > c or else not Result
				loop
					Result := other_clients.has (clients.item (i))
					i := i + 1
				end
			end
		end

feature -- Debug purpose

	trace is
			-- Debug purpose
		local
			i, nb: INTEGER
		do
			io.error.put_character ('[')
			io.error.put_string (System.class_of_id (written_in).group.location.evaluated_path)
			io.error.put_string ("] : ")
			from
				i := 1
				nb := clients.count
			until
				i > nb
			loop
				io.error.put_character ('%T')
				io.error.put_string (names_heap.item (clients.item (i)))
				io.error.put_character (' ')
				i := i + 1
			end
		end

feature -- formatter

	less_restrictive_than (other: like Current): BOOLEAN is
		require
			good_argument: other /= Void
		local
			other_clients: like clients
			other_group: CONF_GROUP
			l_names_heap: like names_heap
			i, nb: INTEGER
		do
			l_names_heap := names_heap
			other_clients := other.clients
			other_group := system.class_of_id (other.written_in).group
			from
				i := 1
				nb := other_clients.count
				Result := True
			until
				i > nb or Result = False
			loop
				Result := valid_for (Universe.class_named
					(l_names_heap.item (other_clients.item (i)), other_group).compiled_class)
				i := i + 1
			end
		end

invariant
	clients_not_void: clients /= Void
	written_in_positive: written_in > 0

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

end -- class CLIENT_I

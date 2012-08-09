note
	description: "Representation of an export clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLIENT_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients)
			-- Create a new CLIENT AST node.
		require
			c_not_void: c /= Void
			c_not_empty: not c.is_empty
		do
			clients := c
		ensure
			clients_set: clients = c
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_client_as (Current)
		end

feature -- Attributes

	clients: CLASS_LIST_AS
			-- Client list

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := clients.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := clients.last_token (a_list)
		end

feature -- Roundtrip

	is_client_list_empty: BOOLEAN
			-- Is client list empty? e.g. in form of {}
			--|If a client list is in form of {}, a NONE_ID_AS object will be inserted
			--|into the list automatically. Because it is not in source code, we must
			--|deal with it specially.
		local
			l_none_id: NONE_ID_AS
		do
			if clients.count = 1 then
				l_none_id ?= clients.first
				Result := l_none_id /= Void
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: use mechanism similar to `is_equiv'!!!!
			Result := equivalent (clients, other.clients)
		end

	is_equiv (other: like Current): BOOLEAN
			-- Is `other' equivalent to Current?
		local
			other_clients: EIFFEL_LIST [ID_AS]
			found: BOOLEAN
		do
			if other /= Current then
				-- Both have clients.
				other_clients := other.clients
				if clients.count = other.clients.count then
					from
						found := True
						clients.start
					until
						clients.after or else not found
					loop
						from
							found := False
							other_clients.start
						until
							other_clients.after or else found
						loop
							found := clients.item.is_equal (other_clients.item)
							other_clients.forth
						end
						clients.forth
					end
					Result := found
				end
			end
		end

feature -- Output

	dump: STRING
			-- Dump for comparison purposes.
		do
			create Result.make (3)
			from
				clients.start
			until
				clients.after
			loop
				Result.append (clients.item.name)
				clients.forth
				if not clients.after then
					Result.append (", ")
				end
			end
			if Result.is_equal ("any") then
				Result.wipe_out
			end
		end

invariant
	clients_not_void: clients /= Void
	clients_not_empty: not clients.is_empty

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class CLIENT_AS

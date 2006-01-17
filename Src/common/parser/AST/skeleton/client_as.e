indexing
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

	initialize (c: like clients) is
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

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_client_as (Current)
		end

feature -- Attributes

	clients: EIFFEL_LIST [ID_AS]
			-- Client list

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := clients.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := clients.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: use mechanism similar to `is_equiv'!!!!
			Result := equivalent (clients, other.clients)
		end

	is_equiv (other: like Current): BOOLEAN is
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

	dump: STRING is
			-- Dump for comparison purposes.
		do
			create Result.make (3)
			from
				clients.start
			until
				clients.after
			loop
				Result.append (clients.item)
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

end -- class CLIENT_AS

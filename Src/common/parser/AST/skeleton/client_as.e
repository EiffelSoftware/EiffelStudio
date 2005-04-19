indexing
	description: "Representation of an export clause"
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

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := clients.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := clients.end_location
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

end -- class CLIENT_AS

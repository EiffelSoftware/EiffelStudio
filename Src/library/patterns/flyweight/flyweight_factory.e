indexing
	description: "Create and Manage flyweight objects."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	FLYWEIGHT_FACTORY

feature -- Initialization
	
	make is
		-- Initialize
		do
			!! list.make
		end

feature -- Operations

	add (unshared: ANY; shared: ANY) is
			-- Add a flyweight to the list.
		require
			not_void: unshared /= Void and then shared /= Void
		local
			flyweight: FLYWEIGHT[like unshared, like shared]
		do
			!! flyweight
			flyweight.initialize(unshared, shared)
			list.extend(flyweight)	
		ensure
			increment_list: list.count = old list.count + 1
		end
	
	remove(a_flyweight: FLYWEIGHT[ANY,ANY]) is
			-- Remove a flyweight from the list.
			-- Do nothing if it is not found.
		require
			not_void: a_flyweight /= Void
		do
			from
				list.start
			until
				list.after
			loop
				if a_flyweight= list.item then
					list.remove
				else
					list.forth
				end
			end
		end

	has(a_flyweight: FLYWEIGHT[ANY,ANY]): BOOLEAN is
		-- Return TRUE if the flyweight is managed by Current.
		require
			not_void: a_flyweight /= Void
		do
			from
				list.start
			until
				list.after or Result
			loop
				if a_flyweight= list.item then
					Result := TRUE
				else
					list.forth
				end
			end
		end

feature {NONE} -- Implementation

	list: LINKED_LIST [FLYWEIGHT[ANY,ANY]]
		-- List of flyweights.

invariant
	FLYWEIGHT_FACTORY_list_exists: list /= Void
end -- class FLYWEIGHT_FACTORY

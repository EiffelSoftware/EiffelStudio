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
			!! list.make(20)
		end

feature -- Operations

	add (unshared: ANY; shared: ANY;key: HASHABLE) is
			-- Add a flyweight to the list.
		require
			not_void: unshared /= Void and then shared /= Void and key /= Void
		local
			flyweight: FLYWEIGHT[like unshared, like shared]
		do
			!! flyweight
			flyweight.initialize(unshared, shared)
			list.put(flyweight,key)	
		ensure
			increment_list: list.count = old list.count + 1
		end
	
	remove(key: HASHABLE) is
			-- Remove a flyweight from the list.
			-- Do nothing if it is not found.
		require
			not_void: key /= Void
		do
			list.remove(key)
		end

	has_item(a_flyweight: FLYWEIGHT[ANY,ANY]): BOOLEAN is
		-- Return TRUE if the flyweight is managed by Current.
		require
			not_void: a_flyweight /= Void
		do
			Result := has_item(a_flyweight)
		end

	has(key: HASHABLE): BOOLEAN is
		-- Return TRUE if a flyweight is managed by Current.
		require
			not_void: key /= Void
		do
			Result := has(key)
		end

	get_flyweight(key: HASHABLE): FLYWEIGHT[ANY,ANY] is
			-- Return flyweight corresponding to the key 'any'.
			-- Return Void if not found.
		require
			key_exists: key /= Void
		do
			Result := list.item(key)
		end

feature {NONE} -- Implementation

	list: HASH_TABLE [FLYWEIGHT[ANY,ANY],HASHABLE]
		-- List of flyweights.

invariant
	FLYWEIGHT_FACTORY_list_exists: list /= Void
end -- class FLYWEIGHT_FACTORY


--|----------------------------------------------------------------
--| EiffelPatterns: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_VALUE_KEEPER

create {SHARED_DEBUG_VALUE_KEEPER}
	make
	
feature {NONE} -- Initialization

	make is
		do
			create debug_value_kept.make (10)
			debug_value_kept.compare_objects
		end

feature -- Operation

	recycle is
		do
			debug_value_kept.wipe_out
		end

feature -- Access

	know_about (l_k: STRING): BOOLEAN is
			-- 
		do
			Result := debug_value_kept.has (l_k)
		end
		

	item (l_k: STRING): ABSTRACT_DEBUG_VALUE is
		require
			know_about (l_k)
		do
			Result := debug_value_kept.item (l_k)
		ensure
			Result /= Void
		end

	keep (dv: ABSTRACT_DEBUG_VALUE) is
		require
			dv /= Void
		local
			l_address: STRING
		do
			l_address := dv.address
			if l_address /= Void then
				if not debug_value_kept.has (l_address) then
					debug_value_kept.put (dv, l_address)
				end
			end
		end
		
	remove_by_address (a_address: STRING) is
		require
			a_address /= Void and not a_address.is_empty
		do
			if debug_value_kept.has (a_address) then
				debug_value_kept.remove (a_address)
			end
		end
		
	keep_only (l_addresses: LIST [STRING]) is
			-- Clean all the value except the one from l_addresses
		local
			l_add: STRING
		do
			from
				debug_value_kept.start
			until
				debug_value_kept.after
			loop
				l_add := debug_value_kept.key_for_iteration
				if not l_addresses.has (l_add) then
					debug_value_kept.remove (l_add)
				end
				debug_value_kept.forth
			end
		end
	
	debug_value_kept: HASH_TABLE [ABSTRACT_DEBUG_VALUE, STRING]

end -- class DEBUG_VALUE_KEEPER

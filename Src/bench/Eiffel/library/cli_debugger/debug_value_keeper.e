indexing
	description: "Objects that keep a reference to the debug value indexed by address..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_VALUE_KEEPER
	
inherit
	ICOR_EXPORTER

create {SHARED_DEBUG_VALUE_KEEPER}
	make
	
feature {NONE} -- Initialization

	make is
		do
			create debug_value_kept.make (10)
			debug_value_kept.compare_objects
		end

feature {EIFNET_EXPORTER, APPLICATION_EXECUTION_DOTNET, EB_DEBUGGER_MANAGER} -- Operation

	initialize is
		do
			create debug_value_kept.make (10)
			debug_value_kept.compare_objects
		end

	terminate is
		do
		end

	recycle is
		do
			debug_value_kept.wipe_out
		end

feature -- Access

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
		
	keep_dotnet_value (ddv: EIFNET_ABSTRACT_DEBUG_VALUE) is
		require
			ddv /= Void
		local
			l_address: STRING
		do
			l_address := ddv.address
			if l_address /= Void then
				if not debug_value_kept.has (l_address) then
					debug_value_kept.put (ddv, l_address)
				end
			end
		end		

	know_about (l_k: STRING): BOOLEAN is
			-- Has a Debug Value object address by `l_k'
		do
			Result := debug_value_kept.has (l_k)
		end

	item (l_k: STRING): ABSTRACT_DEBUG_VALUE is
			-- Debug Value object address by `l_k'
		require
			know_about (l_k)
		do
			Result := debug_value_kept.item (l_k)
		ensure
			Result /= Void
		end		

feature {APPLICATION_EXECUTION_DOTNET} -- Implementation

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
		
feature {NONE} -- restricted access
	
	debug_value_kept: HASH_TABLE [ABSTRACT_DEBUG_VALUE, STRING]

end -- class DEBUG_VALUE_KEEPER

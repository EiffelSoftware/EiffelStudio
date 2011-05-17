note
	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class STRING_HDL

feature -- Status setting

	clear_all
			-- Remove all mapped keys.
		require
			ht_not_void: ht /= Void
			ht_order_not_void: ht_order /= Void
		do
			ht.wipe_out
			ht_order.wipe_out
		end

	set_map_name (n: detachable ANY; key: STRING_32)
			-- Store item `n' with key `key'.
			-- `n' can be `Void'.
		require
			ht_not_void: ht /= Void
			ht_order_not_void: ht_order /= Void
			key_exists: key /= Void
			not_key_in_table: not is_mapped (key)
		do
			ht.put (n, key)
			ht_order.extend (key)
		ensure
			count_valid: ht.count = old (ht.count) + 1
			count_valid: ht_order.count = old (ht_order.count) + 1
			mapped: is_mapped (key)
		end

	unset_map_name (key: STRING_32)
			-- Remove item associated with key `key'.
		require
			ht_not_void: ht /= Void
			ht_order_not_void: ht_order /= Void
			key_exists: key /= Void
			item_exists: is_mapped (key)
		do
			ht.remove (key)
			ht_order.prune_all (key)
		ensure
			count_valid: ht.count = old (ht.count) - 1
			count_valid: ht_order.count = old (ht_order.count) - 1
		end

feature -- Status report

	is_mapped (key: STRING_32): BOOLEAN
			-- Is `key' mapped to an Eiffel entity?
		require
			ht_not_void: ht /= Void
			keys_exists: key /= Void
		do
			Result := ht.has (key)
		end

	mapped_value (key: STRING_32): ANY
			-- Value mapped with `key'
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			key_mapped: is_mapped (key)
		do
				-- Per precondition `is_mapped' this should always succeed.
			check attached ht.item (key) as l_item then
				Result := l_item
			end
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	ht: detachable DB_STRING_HASH_TABLE [detachable ANY] note option: stable attribute end
		-- Correspondence table between object references
		-- and mapped keys

	ht_order: detachable ARRAYED_LIST [STRING_32] note option: stable attribute end
		-- Keys of `ht' in order of mapping

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

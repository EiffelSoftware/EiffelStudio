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
		do
			ht.wipe_out
			ht_order.wipe_out
		end

	set_map_name (n: detachable ANY; key: READABLE_STRING_GENERAL)
			-- Store item `n' with key `key'.
			-- `n' can be `Void'.
		require
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

	unset_map_name (key: READABLE_STRING_GENERAL)
			-- Remove item associated with key `key'.
		require
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

	is_mapped (key: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `key' mapped to an Eiffel entity?
		require
			keys_exists: key /= Void
		do
			Result := ht.has (key)
		end

	mapped_value (key: READABLE_STRING_GENERAL): detachable ANY
			-- Value mapped with `key'
		require
			key_exists: key /= Void
		do
				-- Per precondition `is_mapped' this should always succeed.
			if attached ht.item (key) as l_item then
				Result := l_item
			end
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Status report

	ht: DB_STRING_HASH_TABLE [detachable ANY]
			-- Correspondence table between object references
			-- and mapped keys.

	ht_order: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Keys of `ht' in order of mapping.

invariant
	same_count: ht.count = ht_order.count

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

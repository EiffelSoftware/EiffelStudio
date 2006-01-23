indexing

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class STRING_HDL

feature -- Status setting

	clear_all is
			-- Remove all mapped keys.
		require
			ht_not_void: ht /= Void
		do
			ht.clear_all
			ht_order.wipe_out
		end

	set_map_name (n: ANY; key: STRING) is
			-- Store item `n' with key `key'.
			-- `n' can be `Void'.
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			not_key_in_table: not is_mapped (key)
		do
			ht.put (n, key)
			ht_order.extend (key)
		ensure
			ht.count = old ht.count + 1
		end

	unset_map_name (key: STRING) is
			-- Remove item associated with key `key'.
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			item_exists: is_mapped (key)
		do
			ht.remove(key)
			ht_order.prune (key)
		ensure
			ht.count = old ht.count - 1
		end

feature -- Status report

	is_mapped (key: STRING): BOOLEAN is
			-- Is `key' mapped to an Eiffel entity?
		require
			ht_not_void: ht /= Void
			keys_exists: key /= Void
		do
			Result := ht.has (key)
		end

	mapped_value (key: STRING): ANY is
			-- Value mapped with `key'
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			key_mapped: is_mapped (key)
		do
			Result := ht.item (key)
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	ht: HASH_TABLE [ANY, STRING]
		-- Correspondence table between object references
		-- and mapped keys

	ht_order: ARRAYED_LIST [STRING];
		-- Keys of `ht' in order of mapping

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STRING_HDL




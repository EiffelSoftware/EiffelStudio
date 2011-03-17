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
		local
			l_ht: like ht
			l_ht_order: like ht_order
		do
			l_ht := ht
			check l_ht /= Void end -- implied by precondition `ht_not_void'
			l_ht.wipe_out

			l_ht_order := ht_order
			check l_ht_order /= Void end -- FIXME: implied by ...? bug?
			l_ht_order.wipe_out
		end

	set_map_name (n: ANY; key: STRING)
			-- Store item `n' with key `key'.
			-- `n' can be `Void'.
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			not_key_in_table: not is_mapped (key)
		local
			l_ht: like ht
			l_ht_order: like ht_order
		do
			l_ht := ht
			check l_ht /= Void end -- implied by precondition `ht_not_void'
			l_ht.put (n, key)

			l_ht_order := ht_order
			check l_ht_order /= Void end -- FIXME: Impplied by ...? bug?
			l_ht_order.extend (key)
		ensure
			count_valid: (attached ht and old (attached ht)) and then hash_table_count (ht) = old (hash_table_count (ht)) + 1
			count_valid: (attached ht_order and old (attached ht_order)) and then array_list_count (ht_order) = old (array_list_count (ht_order)) + 1
			mapped: is_mapped (key)
		end

	unset_map_name (key: STRING)
			-- Remove item associated with key `key'.
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			item_exists: is_mapped (key)
		local
			l_ht: like ht
			l_ht_order: like ht_order
		do
			l_ht := ht
			check l_ht /= Void end -- implied by precondition `ht_not_void'
			l_ht.remove (key)

			l_ht_order := ht_order
			check l_ht_order /= Void end -- FIXME: implied by ...? bug?
			l_ht_order.prune_all (key)
		ensure
			count_valid: (attached ht and old (attached ht)) and then hash_table_count (ht) = old (hash_table_count (ht)) - 1
			count_valid: (attached ht_order and old (attached ht_order)) and then array_list_count (ht_order) = old (array_list_count (ht_order)) - 1
		end

feature -- Status report

	is_mapped (key: STRING): BOOLEAN
			-- Is `key' mapped to an Eiffel entity?
		require
			ht_not_void: ht /= Void
			keys_exists: key /= Void
		local
			l_ht: like ht
		do
			l_ht := ht
			check l_ht /= Void end -- implied by precondition `ht_not_void'
			Result := l_ht.has (key)
		end

	mapped_value (key: STRING): ANY
			-- Value mapped with `key'
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			key_mapped: is_mapped (key)
		local
			l_result: detachable ANY
			l_ht: like ht
		do
			l_ht := ht
			check l_ht /= Void end -- implied by precondition `ht_not_void'
			l_result := l_ht.item (key)
			check l_result /= Void end -- implied by precondition `key_mapped'
			Result := l_result
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	ht: detachable DB_STRING_HASH_TABLE [ANY]
		-- Correspondence table between object references
		-- and mapped keys

	ht_order: detachable ARRAYED_LIST [STRING]
		-- Keys of `ht' in order of mapping

feature -- Contract support

	hash_table_count (a_hash_table: detachable  HASH_TABLE [ANY, STRING]): INTEGER
			-- Count value of `a_hash_table'
		require
			ready: attached a_hash_table
		do
			if attached a_hash_table as l_ht then
				Result := l_ht.count
			else
				check False end -- Implied by precondition `ready'
			end
		end

	array_list_count (a_list: detachable ARRAYED_LIST [STRING]): INTEGER
			-- Count value of `a_list'
		require
			ready: attached a_list
		do
			if attached a_list as l_list then
				Result := l_list.count
			else
				check False end -- Implied by precondition `ready'
			end
		end

;note
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



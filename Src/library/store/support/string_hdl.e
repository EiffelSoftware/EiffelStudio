indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class STRING_HDL

feature -- Status setting

	clear_all is
			-- Remove all mapped keys.
		do
			ht.clear_all
		end

	set_map_name (n: ANY; key: STRING) is
			-- Store item `n' with key `key'.
			-- `n' can be `Void'.
		require
			key_exists: key /= Void
			not_key_in_table: not is_mapped (key)
		do
			ht.put (n, key)
		ensure
			ht.count = old ht.count + 1
		end

	unset_map_name (key: STRING) is
			-- Remove item associated with key `key'.
		require
			key_exists: key /= Void
			item_exists: is_mapped (key)
		do
			ht.remove(key)
		ensure
			ht.count = old ht.count - 1
		end

feature -- Status report

	is_mapped (key: STRING): BOOLEAN is
			-- Is `key' mapped to an Eiffel entity?
		require
			keys_exists: key /= Void
		do
			Result := ht.has (key)
		end

	mapped_value (key: STRING): ANY is
			-- Value mapped with `key'
		require
			key_exists: key /= Void
			key_mapped: is_mapped (key)
		do
			Result := ht.item (key)
		ensure
			result_exists: Result /= Void
		end

feature {DATABASE_PROC} -- Status report

	ht: HASH_TABLE [ANY, STRING]
		-- Correspondence table between object references
		-- and mapped keys

end -- class STRING_HDL


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


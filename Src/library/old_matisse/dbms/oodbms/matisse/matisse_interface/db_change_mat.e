
class DB_CHANGE_MAT

inherit

	DB_CHANGE_I
		undefine
			is_equal, out, copy, consistent, setup
		end

	SQL_SCAN
		export {NONE} all
		end

creation -- Creation procedure

	make

feature -- Status report

	descriptor_available: BOOLEAN is
		-- Always False
		do
		end -- descriptor_available

feature -- Element change

	modify (sql: STRING) is
		-- Do nothing
		require else
			argument_exists: sql /= Void
			connected: is_connected
			descriptor_is_available: descriptor_available
		do
		end -- modify

feature -- Status setting

	set_ht (table: HASH_TABLE [ANY, STRING]) is
		-- Do nothing
		require else
			table_exists: table /= Void
		do
		ensure then
			ht = table
		end -- set_ht

end -- class DB_CHANGE_MAT

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


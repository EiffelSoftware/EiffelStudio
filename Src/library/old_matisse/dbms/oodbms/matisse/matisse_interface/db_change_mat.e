
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

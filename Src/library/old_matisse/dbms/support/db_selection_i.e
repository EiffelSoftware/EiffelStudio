indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class DB_SELECTION_I

inherit

	DB_STATUS_USE
		export
			{ANY} is_ok
			{ANY} is_connected
		end

	DB_EXEC_USE

feature -- Basic operations

	query (statement: STRING) is
			-- Query database server using SQL `statement'.
		require
			descriptor_is_available: descriptor_available
		deferred
		end

	next is
			-- Move to next available resulting row.
		deferred
		end

	terminate is
			-- Release cursor descriptor used with last query.
		deferred
		ensure
			descriptor_is_available: descriptor_available
		end

feature -- Status setting

	cursor_to_object (object: ANY; cursor: DB_RESULT) is
			-- Effectively load `object' attributes with
			-- `cursor' fields.
		require
			cursor_exists: cursor /= Void
			object_exists: object /= Void
		deferred
		end

	set_ht (table: HASH_TABLE [ANY, STRING]) is
			-- Obtain bind variables table.
		deferred
		end

feature -- Status report

	descriptor: INTEGER
			-- Cursor descriptor index

	descriptor_available: BOOLEAN is
			-- Is it possible to get an additional cursor
			-- from database server?
		deferred
		end

end -- class DB_SELECTION_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

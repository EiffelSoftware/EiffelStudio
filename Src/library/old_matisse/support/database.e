indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class 
	DATABASE
inherit
	MEMORY
-- FIXME: Jacques, added according matisse library
		export {NONE} all
--
		redefine
			dispose
		end
feature -- Status report

	db_control_i: DB_CONTROL_I is
			-- Common interface object
			-- for implementation of 
			-- DB_CONTROL handle
		deferred
		end

	db_status_i: DB_STATUS_I is
			-- Common interface object
			-- for implementation of 
			-- DB_STATUS handle
		deferred
		end

	db_change_i: DB_CHANGE_I is
			-- Common interface object
			-- for implementation of 
			-- DB_CHANGE handle
		deferred
		end

	db_selection_i: DB_SELECTION_I is
			-- Common interface object
			-- for implementation of 
			-- DB_SELECTION handle
		deferred
		end

	db_repository_i: DB_REPOSITORY_I is
			-- Common interface object
			-- for implementation of 
			-- DB_REPOSITORY handle
		deferred
		end

	db_result_i: DB_RESULT_I is
			-- Common interface object
			-- for implementation of 
			-- DB_RESULT handle
		deferred
		end

	db_store_i: DB_STORE_I is
			-- Common interface object
			-- for implementation of 
			-- DB_STORE handle
		deferred
		end

	db_format_i: DB_FORMAT_I is
			-- Common interface object
			-- for implementation of 
			-- DB_FORMAT handle
		deferred
		end

	db_proc_i: DB_PROC_I is
			-- Common interface object
			-- for implementation of 
			-- DB_PROC handle
		deferred
		end

	db_all_types_i: DB_ALL_TYPES_I is
			-- Common interface object
			-- for implementation of 
			-- DB_ALL_TYPES handle
		deferred
		end

	name: STRING is
			-- Database name
		once
			Result := clone (generator)
		ensure
			Result.is_equal (generator)
		end

feature {NONE} -- Element change
	
	dispose is
			-- Whenever an instance conforming to Current
			-- is reclaimed, disconnect from database server
			-- if not already done.
		local
			status: INTEGER
		do
			if db_control_i.is_connected then
				status := db_control_i.disconnect
			end
		end

	
end -- class DATABASE


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


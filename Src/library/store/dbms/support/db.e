indexing
	description: "Contains all the handles";
	date: "$Date$";
	revision: "$Revision$"

class 
	DB [G -> DATABASE create default_create end]

inherit

	DB_CONSTANT
		export
			{NONE} all
		end
	

feature -- Status report

	db_control: DATABASE_CONTROL [G] is
			-- DATABASE_CONTROL handle 
		do
			create Result
		end

	db_status: DATABASE_STATUS [G] is
			-- DATABASE_STATUS handle 
		do
			create Result
		end

	db_selection: DATABASE_SELECTION [G] is
			-- DATABASE_SELECTION handle 
		do
			create Result.make (parsed_string_size)
		end

	db_change: DATABASE_CHANGE [G] is
			-- DATABASE_CHANGE handle 
		do
			create Result.make (parsed_string_size)
		end

	db_repository: DATABASE_REPOSITORY [G] is
			-- DATABASE_REPOSITORY handle 
		do
			create Result.make
		end

	db_result: DATABASE_TUPLE [G] is
			-- DATABASE_TUPLE handle 
		do
			create Result.make
		end

	db_store: DATABASE_STORE [G] is
			-- DATABASE_STORE handle 
		do
			create Result.make (parsed_string_size)
		end

	db_format: DATABASE_FORMAT [G] is
			-- DATABASE_FORMAT handle 
		do
			create Result
		end

	db_proc: DATABASE_PROC [G] is
			-- DATABASE_PROC handle 
		do
			create Result.make
		end

	db_all_types: DATABASE_ALL_TYPES [G] is
			-- DATABASE_ALL_TYPES handle 
		do
			create Result.make
		end

	db_dyn_selection: DATABASE_DYN_SELECTION [G] is
			-- DATABASE_DYN_SELECTION handle 
		do
			create Result.make (parsed_string_size)
		end
		
	db_dyn_change: DATABASE_DYN_CHANGE [G] is
			-- DATABASE_DYN_CHANGE handle 
		do
			create Result.make (parsed_string_size)
		end
	
	name: STRING is
			-- Database name
		local
			l: G
		once
			create l
			Result := l.generator
		end

feature {NONE} -- Status report

	sql_struct: DATABASE_DATA [G] is
			-- Implementation of the data.
		do
			create Result
		end

end -- class DB


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------



indexing
	description: "DB_SELECTION for dynamic sql"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DYN_SELECTION

inherit
	DB_SELECTION
		rename
			implementation as db_sel_imp
		redefine
			make
		end

creation
	make

feature -- Initialization

	make is
			-- Create an interface objet to query active base.
		do
			!! ht.make (name_table_size)
			implementation := handle.database.db_dyn_selection
			implementation.set_ht (ht)
		end

feature -- Element change

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		do
			implementation.prepare (s)
		end

	bind_parameter is 
			-- Bind of the prarameters of the sql statement 
		do
			implementation.bind_parameter
		end

	execute  is
			-- Execute the sql statement
		do
			if is_ok then
				implementation.execute
			end
	
		end

	set_value (v: ANY) is
			-- Set the values of the parameters
		do
			implementation.set_value (v)
		end

	retrieve (table: ARRAY [ANY]) is
			-- Execute the sql statement with `table' as 
			-- the array of values for the parameters
		do
			implementation.retrieve (table)
		end

feature {NONE} -- Implementation

	implementation: DATABASE_DYN_SELECTION [DATABASE]
		-- Handle reference to specific database implementation

end -- class DB_DYN_SELECTION

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


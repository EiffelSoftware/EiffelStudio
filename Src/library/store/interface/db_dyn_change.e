indexing
	description: "DB_CHANGE for dynamic sql"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DYN_CHANGE

inherit
	DB_CHANGE
		undefine
			set_map_name,
			unset_map_name,
			is_mapped,
			mapped_value,
			clear_all
		redefine
			implementation,
			make
		end

	PARAMETER_HDL

creation
	make

feature -- Initialization

	make is
			-- Creation routine
		do
			implementation := handle.database.db_dyn_change
			!! ht.make (name_table_size)
			implementation.set_ht (ht)
			init
			implementation.init_implementation (parameters_value, parameter_name_to_position)
		end

feature -- Element change

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_sql: s.count > 0
		do
			implementation.prepare (s)
			set_prepared (TRUE)
		ensure
			prepared_statement: is_prepared
		end

	bind_parameter is
			-- Bind of the prarameters of the sql statement 
		require
			prepared_statement: is_prepared
		do
			implementation.bind_parameter
		end

	execute is
			-- Execute the sql statement
		require
			prepare_statement: is_prepared
		do
			if is_ok then
				implementation.execute
			end
		end

feature {NONE} -- Implementation

	implementation: DATABASE_DYN_CHANGE [DATABASE]
		-- Handle reference to specific database implementation


end -- class DB_DYN_CHANGE

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


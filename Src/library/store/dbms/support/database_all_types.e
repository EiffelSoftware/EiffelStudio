indexing
	description: "Implementation of DB_ALL_TYPES";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATABASE_ALL_TYPES [G -> DATABASE create default_create end]

inherit

	HASH_TABLE [DB_TYPE, INTEGER]
		rename
			make as ht_make
		end

	INTERNAL
		undefine
			copy,
			is_equal
		end

creation -- Creation procedure

	make

feature -- Initialization

	make is
		do
			ht_make (10)
		end

feature -- Access
		
	db_type (object: ANY): DB_TYPE is
			-- DB_TYPE instance associated to `object'
		do
			Result := item (dynamic_type (object))
		ensure
			result_value: Result = item (dynamic_type (object))
		end
feature -- Status report

	is_registered (object: ANY): BOOLEAN is
			-- Is `object' type registered?
		require
			object_not_void: object /= Void
		do
			Result := has (dynamic_type (object))
		ensure
			result_value: Result = has (dynamic_type (object))
		end

feature -- Element change

	register_all is
			-- Register all available types.
		require
			count = 0
		local
			a_db_type: DB_TYPE
		once
			!DATABASE_STRING [G]!a_db_type
			register_type (a_db_type)
			!DATABASE_CHARACTER [G]!a_db_type
			register_type (a_db_type)
			!DATABASE_INTEGER [G]!a_db_type
			register_type (a_db_type)
			!DATABASE_BOOLEAN [G]!a_db_type
			register_type (a_db_type)
			!DATABASE_REAL [G]!a_db_type
			register_type (a_db_type)
			!DATABASE_DOUBLE [G]!a_db_type
			register_type (a_db_type)
			!DATABASE_DATETIME [G]!a_db_type
			register_type (a_db_type)
		ensure
			positive_count: count > 0
		end

	register_type (type: DB_TYPE) is
			-- Register a new `type'.
		require
			type_not_void: type /= Void
			type_not_register: not has_item (type)
		do
			put (type, type.dynamic)
		ensure
			incremented_count: count = old count + 1
		end


end -- class DATABASE_ALL_TYPES

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

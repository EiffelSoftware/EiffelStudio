indexing

	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

deferred class DB_ALL_TYPES_I inherit

	HASH_TABLE [DB_TYPE, INTEGER]
		rename
			make as ht_make
		end

	INTERNAL
		undefine
			copy,
			is_equal
		end

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
		deferred
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

end -- class DB_ALL_TYPES_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

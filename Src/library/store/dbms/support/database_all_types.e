indexing
	description: "Implementation of DB_ALL_TYPES"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create -- Creation procedure

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
			create {DATABASE_STRING [G]} a_db_type
			register_type (a_db_type)
			create {DATABASE_CHARACTER [G]} a_db_type
			register_type (a_db_type)
			create {DATABASE_INTEGER [G]} a_db_type
			register_type (a_db_type)
			create {DATABASE_BOOLEAN [G]} a_db_type
			register_type (a_db_type)
			create {DATABASE_REAL [G]} a_db_type
			register_type (a_db_type)
			create {DATABASE_DOUBLE [G]} a_db_type
			register_type (a_db_type)
			create {DATABASE_DATETIME [G]} a_db_type
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


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATABASE_ALL_TYPES



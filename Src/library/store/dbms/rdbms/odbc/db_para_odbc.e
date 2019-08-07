note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: ODBC

class

	DB_PARA_ODBC

create

	make

feature -- Initialization

	make ( size: INTEGER)
		do
			create ptr.make_filled (Void, 1, size)
			count := size
		end

feature -- Status Setting

	resize (size: INTEGER)
		require
			array_exist: ptr /= Void
		do
			ptr.conservative_resize_with_default (Void, 1, size)
			count := size
		end

	set (val: detachable MANAGED_POINTER; pos: INTEGER)
		do
			ptr.put(val, pos)
		end

	get (pos: INTEGER): POINTER
		local
			l_ptr: detachable MANAGED_POINTER
		do
			l_ptr := ptr.item (pos)
			if l_ptr /= Void then
				Result := l_ptr.item
			end
		end

	release
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				ptr.put (Void, i)
				i := i + 1
			end
			count := 0
		end


feature  -- Status

	count: INTEGER

	ptr: ARRAY [detachable MANAGED_POINTER]


feature { NONE} -- External Features

	odbc_c_free (p: POINTER)
		external
			"C [macro %"odbc.h%"]"
		alias
			"ODBC_C_FREE"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_PARA_ODBC




indexing
	description: "Handle to actual database";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC [G -> DATABASE create default_create end]

feature -- Access

	db_spec: DATABASE is
			-- Handle to actual database
		do
			Result := db_spec_impl.item
		ensure
			not_void: Result /= Void 
		end

feature {NONE} -- Implementation

	update_handle is
			-- Update handle according to current connection.
		local
			obj: G
		do
			create obj
			db_spec_impl.replace (obj)
		end

	db_spec_impl : CELL [DATABASE] is
			-- Unique reference to application database handle.
		local
			obj: G
		once
			create obj
			create Result.put (obj)
		end

end -- class HANDLE_SPEC


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
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


class CONTROL_ACTION 

inherit 

	ACTION
		redefine start,execute
	end

	SHARED_CURSOR

feature

		
    start is
        do
			io.putstring("Beginning action")
        end

    execute is
		local
			one_object : MT_OBJECT
        do
			one_object ?= one_cursor.data
			io.putstring("Handling object #") io.putint(one_object.oid) io.new_line
        end

end -- class CONTROL_ACTION

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


indexing

    Product: EiffelStore
    Database: Matisse

class DB_TUPLE_MAT

inherit

    DB_TUPLE_I

creation -- Creation procedure

    make

feature -- Status report

    data: DB_DATA_MAT
            -- Associated data description

feature -- Initialization

    make is
            -- Create `implementation'.
        do
            !! data
        end

end -- class DB_TUPLE_MAT

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


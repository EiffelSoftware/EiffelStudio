indexing

    Product: EiffelStore
    Database: Matisse

class DB_FORMAT_MAT

inherit

	DB_FORMAT_I

	BASIC_ROUTINES

feature -- Conversion

    boolean_format (object: BOOLEAN): STRING is
            -- String representation in SQL string of `object'
        do
            if object.item then
                Result := True_representation
            else
                Result := False_representation
            end        
        end

    date_format (object: ABSOLUTE_DATE): STRING is
            -- String representation in SQL of `object'
        do
        ensure then
            Result = date_buffer
        end

    string_format (s: STRING): STRING is
            -- String representation in SQL of `object'
        do
        end

feature {NONE} -- Status report

    True_representation: STRING is "'T'"

    False_representation: STRING is "'F'"

    Concat_string: STRING is "'||'"

    Max_len: INTEGER is 255

    break (s: STRING): STRING is
            -- Broken long string using
        require
            s_not_void: s /= Void
        do
        end

    date_buffer: STRING is
            -- String buffer
        once
            !! Result.make (20)
        end

end -- class DB_FORMAT_MAT

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


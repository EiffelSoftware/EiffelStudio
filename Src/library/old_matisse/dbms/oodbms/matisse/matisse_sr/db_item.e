indexing
    description:  "Temporary Dyn Type code class. Not needed when ISE Eiffel 4.2 %
        %available."
    keywords:	  "temporary, dynamic-types"
    revision:	  "%%A%%"
    source:	  "%%P%%"
    requirements: ""

class DB_ITEM

    feature -- {CLNT_APPLICATION, TYPES} TEMPORARY: DYNAMIC TYPE WORKAROUND
	dt_code:INTEGER

	set_dt_code(i:INTEGER) is
	    do
	        dt_code := i
	    end

end

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
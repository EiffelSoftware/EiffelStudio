class MT_ATTRIBUTE_EXTERNAL 

feature {NONE} -- Implementation MT_ATTRIBUTE

    c_get_attribute(name : POINTER) : INTEGER is
        -- Use MtGetAttrinute
    external
        "C"
    end -- c_get_attribute

    c_check_attribute(aid,oid : INTEGER)  is
        -- Use Mt_CheckAttribute
    external
        "C"
    end -- c_check_attribute

    c_get_dimension(oid,aid,rank : INTEGER) : INTEGER is
        -- Use Mt_GetDimension
    external
        "C"
    end -- c_get_dimension

    c_get_value(oid,aid : INTEGER)  is
        -- Use Mt_GetValue
    external
        "C"
    end -- c_get_value

    c_value_type : INTEGER is
    external
        "C"
    end -- c_value_type

    c_get_integer_value : INTEGER is
    external
        "C"
    end -- c_get_integer_value

    c_get_double_value : DOUBLE is
    external
        "C"
    end -- c_get_double_value

    c_get_real_value : REAL is
    external
        "C"
    end -- c_get_real_value

    c_get_char_value : CHARACTER is
    external
        "C"
    end -- c_get_char_value

    c_get_string_value : POINTER is
    external
        "C"
    end -- c_get_string_value

    c_free_value is
    external
        "C"
    end -- c_free_value
    
    c_ith_list_integer(i:INTEGER) : INTEGER is
    external
        "C"
    end -- c_ith_list_integer

    c_ith_list_double(i:INTEGER) : DOUBLE is
    external
        "C"
    end -- c_ith_list_double

    c_ith_list_real(i:INTEGER) : REAL is
    external
        "C"
    end -- c_ith_list_real

    c_ith_list_string(i:INTEGER) : POINTER is
    external
        "C"
    end -- c_ith_list_string

    c_set_value_integer(oid,aid,type,value,rank : INTEGER) is
    external 
        "C"
    end -- c_set_value_integer

    c_set_value_double(oid,aid,type: INTEGER ;value : DOUBLE ;rank : INTEGER) is
    external 
        "C"
    end -- c_set_value_double

    c_set_value_real(oid,aid,type: INTEGER ;value : REAL ;rank : INTEGER) is
    external 
        "C"
    end -- c_set_value_real

    c_set_value_char(oid,aid,type: INTEGER ;value : CHARACTER ;rank : INTEGER) is
    external 
        "C"
    end -- c_set_value_char


    c_set_value_string(oid,aid,type: INTEGER ;value : POINTER ;rank : INTEGER) is
    external 
        "C"
    end -- c_set_value_string


    c_set_value_array_numeric(oid,aid,type: INTEGER ;value : POINTER ;rank : INTEGER) is
    external 
        "C"
    end -- c_set_value_array_integer

	c_type_value(aid : INTEGER) : INTEGER is
	external
		"C"
	end -- c_type_value

end -- class MT_ATTRIBUTE_EXTERNAL

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


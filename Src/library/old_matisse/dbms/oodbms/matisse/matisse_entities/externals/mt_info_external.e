class MT_INFO_EXTERNAL 


feature {NONE} -- Implementation MT_INFO

    c_max_buffered_objects : INTEGER is
        -- Use GetConfigurationInfo
    external 
        "C"
    end -- c_max_buffered_objects

    c_max_index_criteria_number : INTEGER is
        -- Use GetConfigurationInfo
    external 
        "C"
    end -- c_max_index_criteria_number

    c_max_index_key_length : INTEGER is
        -- Use GetConfigurationInfo
    external 
        "C"
    end -- c_max_index_key_length

    c_get_total_read_bytes : INTEGER is
        -- Use GetTotalReadBytes
    external 
        "C"
    end -- c_get_total_read_bytes

    c_get_total_write_bytes : INTEGER is
        -- Use GetTotalWriteBytes
    external 
        "C"
    end -- c_get_total_write_bytes

    c_get_wait_time : INTEGER is
        -- Use GetWaitTime
    external 
        "C"
    end -- c_get_wait_time


end -- class MT_INFO_EXTERNAL

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


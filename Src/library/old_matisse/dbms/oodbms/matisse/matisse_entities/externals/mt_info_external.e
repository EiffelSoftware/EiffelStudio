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

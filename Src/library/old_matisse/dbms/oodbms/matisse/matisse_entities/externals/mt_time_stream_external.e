class MT_TIME_STREAM_EXTERNAL 

feature {NONE} -- Implementation MT_TIME_STREAM

    c_time_enum_start : POINTER is
        -- Use MtTimeEnumStart
    external
        "C"
    end -- c_time_enum_start

    c_next_time(sid:POINTER) : POINTER is
        -- Use MtNextTime
    external
        "C"
    end -- c_next_time

    c_time_enum_end(sid:POINTER) is
        -- Use MtTimeEnumEnd
    external
        "C"
    end -- c_time_enum_end


end -- class MT_TIME_STREAM_EXTERNAL

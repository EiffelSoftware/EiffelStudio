class MT_STREAM_EXTERNAL 

feature {NONE} -- Implementation MT_STREAM

    c_next_object(sid:POINTER) : INTEGER is
        -- Use MtNextObject
    external
        "C"
    end -- c_next_object

    c_next_property(sid:POINTER) : INTEGER is
        -- Use MtNextProperty
    external
        "C"
    end -- c_next_property

    c_close_stream(sid:POINTER) is
        -- Use MtNextObject
    external
        "C"
    end -- c_close_stream

end -- class MT_STREAM_EXTERNAL

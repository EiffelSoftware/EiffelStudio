class MT_CLASS_STREAM_EXTERNAL 

feature {NONE} -- Implementation MT_CLASS_STREAM

    c_open_class_stream(cid : INTEGER) : POINTER is
        -- Use Mt_OpenClassStream
    external
        "C"
    end -- c_open_class_stream

end -- class MT_CLASS_STREAM_EXTERNAL

class MT_INDEX_STREAM_EXTERNAL 

feature {NONE} -- Implementation MT_INDEX_STREAM

    c_open_index_stream(index_name,class_name:POINTER;direction : INTEGER) : POINTER is
        -- Use Mt_OpenIndexStream
    external
        "C"
    end -- c_open_index_stream

end -- class MT_INDEX_STREAM_EXTERNAL

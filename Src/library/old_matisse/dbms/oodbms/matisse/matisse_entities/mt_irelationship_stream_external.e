class MT_IRELATIONSHIP_STREAM_EXTERNAL 

feature {NONE} -- Implementation

    c_open_irelationship_stream(oid,rid:INTEGER) : POINTER is
        -- Use Mt_OpenIRelStream
    external
        "C"
    end

end

class MT_HANDLE_MAT_EXTERNAL 


feature {NONE} -- Implementation HANDLE_MAT

    c_set_wait_time(settime : INTEGER ) is
        -- Use MtError
    external
        "C"
    end -- c_set_wait_time

end -- class MT_HANDLE_MAT_EXTERNAL

class MT_DB_STATUS_MAT_EXTERNAL 

inherit

	MT_RESULT_EXTERNAL

feature {NONE} -- Implementation DB_STATUS_MAT


    c_error : POINTER is
        -- Use MtError
    external
        "C"
    end -- c_error

    c_is_ok : INTEGER is
        -- Use MtSuccess in C interface
    external
        "C"
    end -- c_is_ok

    c_invalid_object : INTEGER is
        -- Use MtInvalidObject
    external
        "C"
    end -- c_invalid_object

    c_perror(c_head : POINTER) is
        -- Use MtPError
    external
        "C"
    end -- c_perror

    c_is_check_error : BOOLEAN is
        -- Use MtCheckErrorP
    external
        "C"
    end -- c_is_check_error

    c_full_error : POINTER is
        -- Use ErrorStr
    external
        "C"
    end -- c_full_error

    c_failure : INTEGER is
        -- Use Failure
    external
        "C"
    end -- c_failure

end -- class MT_DB_STATUS_MAT_EXTERNAL

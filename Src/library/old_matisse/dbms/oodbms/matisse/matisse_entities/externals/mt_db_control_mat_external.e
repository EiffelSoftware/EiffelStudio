class MT_DB_CONTROL_MAT_EXTERNAL 

inherit

	MT_RESULT_EXTERNAL

feature {NONE} -- Implementation DB_CONTROL_MAT

    c_connect(host_name,database_name : POINTER) is 
        -- Use MtConnect
    external
        "C"
    end

    c_disconnect is
        -- Use MtDisconnect
    external
        "C"
    end

    c_set_context is
        -- Use MtSetContext
    external
        "C"
    end

    c_set_no_context is
        -- Use MtSetContext
    external
        "C"
    end

    c_start_transaction(priority : INTEGER) is
        -- Use MtStartTransaction
    external
        "C"
    end

    c_commit_transaction is
        -- Use MtCommitTransaction
    external
        "C"
    end

    c_rollback is
        -- Use MtAbortTransaction
    external
        "C"
    end -- c_rollback

    c_set_time(time_name : POINTER) is
        -- Use MtSetTime
    external
        "C"
    end -- c_set_time

    c_end_time is
        -- Use MtEndTime
    external
        "C"
    end -- c_end_time

    c_transaction_count : INTEGER is
    external
        "C"
    end -- c_transaction_count


end -- class MT_DB_CONTROL_MAT_EXTERNAL

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


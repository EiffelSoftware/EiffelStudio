class MT_DB_CONTROL_MAT_EXTERNAL 

inherit

	MT_RESULT_EXTERNAL

feature {NONE} -- Implementation DB_CONTROL_MAT

    c_db_connect(host_name,database_name : POINTER) is 
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

    c_set_transaction_count(trans_count:INTEGER) is
    external
        "C"
    end

    c_database:POINTER is
    external
        "C"
    end

    c_set_database(db:POINTER) is
    external
        "C"
    end

feature -- admin functions
    c_admin_connect(host_name, database_name:POINTER) is 
        -- Use mts_rpc_connect
    external
        "C"
    end

    c_admin_disconnect is
        -- Use mts_rpc_disconnect
    external
        "C"
    end

    c_admin_handle:POINTER is
    external
        "C"
    end

    c_set_admin_handle(hdl:POINTER) is
    external
        "C"
    end

-- FIXME: the following functions probably belong somewhere like DB_STATUS_MAT or similar,
-- but ISE should decide that
	c_admin_collect_and_wait is
			-- use mts_collect, mts_wait_for_adm (synchronous operation)
		external
			"C"
		end

	c_admin_sts_success:BOOLEAN is
			-- get result of last admin function, e.g. collect
		external
 			"C"
		end

	c_admin_sts:INTEGER is
			-- get result of last admin function, e.g. collect
		external
 			"C"
		end

	admin_sts_msg:STRING is
		do
 			!!Result.make(0)
			Result.from_c(c_admin_sts_msg)
		end

	c_admin_sts_msg:POINTER is
			-- get result of last admin function, e.g. collect
		external
 			"C"
		end

end

indexing
	description:  "Interface to databases conforming to the Eiffel Store%
                     % abstract model of databases, i.e. using DB_CONTROL. Provides%
                     % facilities such as indexing and transactions. All database %
                     % descendants of REP_CLIENT should inherit from this class as well."
	keywords:     "database, repository"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

deferred class DB_REP_CLIENT

inherit
	REP_CLIENT
		rename
			make as rep_client_make
		end

feature -- Initialisation
	make is
		do
			-- attach to repository
			rep_session := db_sessions.item(rep_name)
		end

feature -- Status
	is_attached: BOOLEAN
	    -- is this REP_CLIENT attached to a repository?

feature {NONE} -- Transaction Management
	start_transaction(caller:STRING) is
	    require
			Caller_valid: caller /= Void and then not caller.empty
	    do
			clear_fail_reason
			set_current_db_name(rep_name)
			rep_session.begin_transaction
			if not rep_session.is_ok then
				rep_session.rollback_transaction
				build_fail_reason(caller, "start_transaction", rep_session.error_message, rep_session.error_code)
			end
	    ensure
			Transaction_exists: not last_op_fail implies (rep_session.transaction_count = old rep_session.transaction_count + 1)
	    end

	end_transaction(caller:STRING) is
			-- commit or rollback transaction depending on session.is_ok
	    require
			Caller_valid: caller /= Void and then not caller.empty
			Transaction_exists: rep_session.transaction_count > 0
	    do
			if rep_session.transaction_count > 0 then
			    if not rep_session.is_ok then
				    build_append_fail_reason(caller, "end_transaction (rollback)", rep_session.error_message,rep_session.error_code)
				    rep_session.rollback_transaction
			        if not rep_session.is_ok then
				        build_append_fail_reason(caller, "end_transaction (rollback fail)", rep_session.error_message,rep_session.error_code)
			        end
			    else
				    rep_session.commit_transaction
					if not rep_session.is_ok then
						build_append_fail_reason(caller, "end_transaction (commit fail)", rep_session.error_message,rep_session.error_code)
						rep_session.rollback_transaction
						if not rep_session.is_ok then
							build_append_fail_reason(caller, "end_transaction (commit/rollback fail)", rep_session.error_message,rep_session.error_code)
		   				end
					end
				end
			end
	    ensure
			Transaction_ended: not last_op_fail implies (rep_session.transaction_count = old rep_session.transaction_count - 1)
	    end

feature {NONE} -- Structural
	rep_session:DB_CONTROL

invariant
    	Is_attached: rep_session /= Void

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

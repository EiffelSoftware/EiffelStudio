indexing
	description: ""
	keywords:    "error status reporting"
	revision:    "%%A%%"
	source:	     "%%P%%"
	copyright:   "See notice at end of class"


class DB_ERROR_STATUS

inherit
	ERROR_STATUS

feature -- Modify
	build_fail_reason(op_name,code_context,rep_msg:STRING;rep_code:INTEGER) is
		-- initialise 'fail_reason' to reason based on various information
	    require
			Args_valid: op_name /= Void and code_context /= Void and rep_msg /= Void
	    do
			fail_reason_string := fail_string(op_name,code_context,rep_msg,rep_code)
			last_op_fail := True
	    ensure
	    	Fail_flag_set: last_op_fail
		end

	build_append_fail_reason(op_name,code_context,rep_msg:STRING;rep_code:INTEGER) is
			-- append another reason by building from various information
	    require
			Args_valid: op_name /= Void and code_context /= Void and rep_msg /= Void
	    do
			if fail_reason_string = Void then
			    !!fail_reason_string.make(0)
			end
			fail_reason_string.append("%N----------------------------%N")
			fail_reason_string.append(fail_string(op_name,code_context,rep_msg,rep_code))
			last_op_fail := True
	    ensure
	    	Fail_flag_set: last_op_fail
		end

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


indexing
	description: "Error status flag and reason to be inherited by classes needing its services."
	keywords:    "error status reporting"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"


class ERROR_STATUS

feature -- Access
	last_op_fail: BOOLEAN -- result of operation

	fail_reason:STRING is
		-- reason for last op failure
	    do
			Result := clone(fail_reason_string)
	    end

feature -- Reporting
	fail_reason_line_len:INTEGER is 78

feature -- Modify
	set_fail_reason(s:STRING) is
		-- initialise 'fail_reason' to reason 's'
	    require
			Args_valid: s /= Void
	    do
			fail_reason_string := s

			last_op_fail := True
	    ensure
	    	Fail_flag_set: last_op_fail
	    end

	append_fail_reason(s:STRING) is
		-- append another reason 's' to 'fail_reason'
	    require
			Args_valid: s /= Void
	    do
			if fail_reason_string = Void then
			    !!fail_reason_string.make(0)
			end
			fail_reason_string.append("%N----------------------------%N")
			fail_reason_string.append(s)

			last_op_fail := True
	    ensure
	    	Fail_flag_set: last_op_fail
	    end

	clear_fail_reason is
			-- clear fail reason and flag
		do
			fail_reason_string := Void
			last_op_fail := False
		ensure
			Fail_flag_cleared: not last_op_fail
		end

feature {NONE} -- Implementation
	fail_reason_string:STRING

	fail_string(op_name,code_context,rep_msg:STRING;rep_code:INTEGER):STRING is
	    require
			Args_valid: op_name /= Void and code_context /= Void and rep_msg /= Void
	    local
			str:STRING
			charpos, spcpos:INTEGER
	    do
			!!Result.make(0)

			Result.copy(op_name)
			Result.to_upper
			Result.append(" failure (reported in ")  
			Result.append(code_context)
			Result.append("):%N")

			-- the next bit might be long, so build it, then chop it up to be readable
			str := indent_str
			str.append(rep_msg) str.append(" <error code: ") str.append_integer(rep_code) str.append(">")
			from charpos := fail_reason_line_len until charpos >= str.count loop
			    -- find next space
			    spcpos := str.index_of(' ',charpos).max(charpos)
			    if spcpos <= str.count then
				    str.insert("%N",spcpos) str.insert(indent_str, spcpos+2)
			    end
			    charpos := spcpos + fail_reason_line_len
			end

			Result.append(str)
	    end

	indent_str:STRING is
	    do
			!!Result.make(4)
			Result.fill_blank
	    end

invariant
	Reason_set: last_op_fail implies not fail_reason.empty

end


--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,  modification  and/or  distribution  |
--         | permitted with this notice  intact.  Please send  |
--         | modifications  and suggestions  to  Deep Thought  |
--         | Informatics, in  the  interests  of  maintenance  |
--         | and improvement.                                  |
--         |                                                   |
--         | Use of this software is on the understanding that |
--         | the  author(s)  accept no  liability of any kind. |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

 

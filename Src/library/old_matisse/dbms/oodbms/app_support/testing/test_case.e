indexing
    description:  "Abstract Test Case"
    keywords:	  "test case"
    revision:	  "%%A%%"
    source:       "%%P%%"
    copyright:    "See notice at end of class"

deferred class TEST_CASE

inherit
	ERROR_STATUS
		rename 
			last_op_fail as failed
		end

feature -- Initialisation
	make(arg:ANY) is
	    deferred
	    end

feature -- Access
	title:STRING is 
			-- the name of the test
		deferred
		end

	prereqs:ARRAY[STRING] is 
			-- names of prerequisite test cases
		deferred
		end

feature -- testing
	execute is
			-- test routine
		deferred
		end

	check_result is
			-- compare actual result with required result and set 'failed' as necessary
		do
		ensure
			Failure_reason_given: failed implies fail_reason /= Void and then not fail_reason.empty
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,   modification   and   distribution  |
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


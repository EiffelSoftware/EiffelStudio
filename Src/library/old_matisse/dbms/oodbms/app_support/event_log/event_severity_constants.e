indexing
 	description: ""
	keywords:    "Event logging severity constants"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"


class EVENT_SEVERITY_CONSTANTS

feature -- Access
        Information:INTEGER is 0
        Warning:INTEGER is 101
        Error:INTEGER is 102

feature -- Status
	is_valid_severity(n:INTEGER):BOOLEAN is
		do
			Result := n = Information or else (n >= Warning and n <= Error)
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
 


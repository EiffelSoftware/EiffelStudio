indexing
	description:  "INFO_ITEM status value."
	keywords:     "INFO_ITEM"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

class INFO_ITEM_STATUS

feature -- Access
	Sts_current: INTEGER is 0
	Sts_new: INTEGER is 1001
	Sts_old: INTEGER is 1002

feature -- Status
	is_valid_status(i:INTEGER):BOOLEAN is
		do
			Result := i = Sts_current or else (i >= Sts_old and i <= Sts_new)
	        end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,  modification  and/or  distribution  |
--         | permitted with this notice  intact.  Please send  |
--         | modifications  and suggestions to  Deep  Thought  |
--         | Informatics, in  the  interests  of  maintenance  |
--         | and improvement.                                  |
--         |                                                   |
--         | Use of this software is on the understanding that |
--         | the  author(s)  accept no  liability of any kind. |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

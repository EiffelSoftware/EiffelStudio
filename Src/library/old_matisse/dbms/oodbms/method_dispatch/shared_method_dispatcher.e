indexing
	description: "Shared method dispatcher"
	keywords:    "method dispatcher"
	revision:    "%%A%%"
	source:	     "%%P%%"
	copyright:    "See notice at end"

class SHARED_METHOD_DISPATCHER

inherit
	FEATURE_TYPES

feature -- Access
	method_dispatcher:METHOD_DISPATCHER is
	    once
			!!Result.make(True)
	    end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
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


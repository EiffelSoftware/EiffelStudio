indexing
	description:  "TEST database repository. Provides a simple populate routine%
                  %which in fact just sets the local storage to point to the pseudo-repository"
	keywords:     "test database repository"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

class TEST_STAT_REP_CLIENT

inherit
	STAT_REP_CLIENT
		rename
			make as stat_client_make
		end

creation
	make

feature -- Initialisation
	make(a_ref_item:like ref_item; a_rep_name:STRING; a_source: like source)  is
	    do
			-- make rep client
			rep_client_make(a_ref_item, a_rep_name)

			-- make db client
			stat_client_make

			populate(a_source)
         end

feature {APPLICATION} -- Element change
	populate_source(a_source: like source) is
	    do
			source := a_source
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

indexing
    description:  "Keyed INFO_ITEM cell for used with indexed static REP_CLIENTs"
    keywords:     "database, static"
    revision:     "%%A%%"
    source:       "%%P%%"
	copyright:    "See notice at end of class"

class STAT_REP_KEY_CELL[G, H->COMPARABLE]

    inherit
	COMPARABLE

    creation
	make

    feature {REP_CLIENT} -- Initialisation
	make (an_item:G;a_key:H) is
	    require
	        Args_valid: a_key /= Void and an_item /= Void
	    do
		key := a_key
		item := an_item
	    end

    feature {REP_CLIENT, STAT_REP_KEY_CELL, LIST} -- Access
        key: H
        item: G

    feature {STAT_REP_KEY_CELL, LIST} -- Comparison
        infix "<" (other: like Current):BOOLEAN is
            do
                Result := key < other.key
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

indexing
    description:  "Matisse Stream retrieval limit counter"
    keywords:	  "matisse, database"
    revision:	  "%%A%%"
    source:	      "%%P%%"
	copyright:    "See notice at end of class"

class STREAM_COUNTER

    inherit
	ACTION
	    redefine
		start, execute, found
	    end

    creation
        make

    feature -- Initialisation
        make (n:INTEGER) is
            require
		Retrieve_limit_valid: n > 0 and n <= sanity_limit
            do
                limit := n.min(sanity_limit)
            end

    feature -- Access
        sanity_limit:INTEGER is 1000

    feature -- Action
        start is
            do
                counter := 1
            end

        execute is
            do
                counter := counter + 1
            end

    feature -- Status
        found:BOOLEAN is
            do
                Result := counter > limit
            end
    
    feature {NONE} -- Implementation
        counter:INTEGER
        limit:INTEGER

end -- class STREAM_COUNTER

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

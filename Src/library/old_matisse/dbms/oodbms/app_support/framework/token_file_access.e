indexing
	description:  "Access to a file whose lines are token-separated. Typical %
	              %examples: TAB-separated, comma-separated etc."
	keywords:     "token file"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

class TOKEN_FILE_ACCESS

inherit
	TEXT_FILE_ACCESS

creation
        make

feature -- Initialisation
	initialise is
		do
		end


feature -- template routines
	read_initialise is
		do
		end

	read_finalise is
		do
		end

	process_readline is
		do
	       end

	write_file is
		do
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


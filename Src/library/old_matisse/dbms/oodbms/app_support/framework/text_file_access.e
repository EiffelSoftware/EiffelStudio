indexing
	description:  "Access to a text file, ignoring comments & blank lines"
	keywords:     "text file"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

deferred class TEXT_FILE_ACCESS

inherit
	ERROR_STATUS

feature -- Initialisation
        make(a_file_name:STRING) is
                -- initialise config file
            require
                Args_valid: a_file_name /= Void and then not a_file_name.empty
            do

                file_name := clone(a_file_name)
                file_cmt_char := file_default_cmt_char

                !!file.make(file_name)
        
                if not file.exists then
                        set_fail_reason("File ") 
                        append_fail_reason(file_name) 
                        append_fail_reason(" does not exist")

                elseif not file.is_readable then
                        set_fail_reason("File ") 
                        append_fail_reason(file_name) 
                        append_fail_reason(" not readable")

                else
                        exists := True
                		initialise
                        read_file
                end
            end

	initialise is
			-- template routine for special initialisation
		deferred
		end

feature -- Access
        file_name:STRING

        file_default_cmt_char:CHARACTER is ';'

        file_cmt_char:CHARACTER

feature -- Status
        exists: BOOLEAN
        writable: BOOLEAN
	is_valid: BOOLEAN

feature -- Modification
        set_file_cmt_char(c:CHARACTER) is
		do
			file_cmt_char := c
		end

        set_updatable is
		do
			if not file.is_writable then
			      set_fail_reason("File ") 
			      append_fail_reason(file_name) 
			      append_fail_reason(" does not exist")
			      writable := False
			else
			      writable := True
			end
		end


feature {NONE} -- Implementation
	file:RAW_FILE

	linebuf:STRING

        read_file is
            local
		    pos:INTEGER
            do
            	    read_initialise

                    from
			    file.open_read
                    until
                            file.end_of_file
                    loop
                            file.readline

                            -- ignore blank lines & comment lines (lines or part 
                            -- lines starting with a semicolon)
                            linebuf := clone(file.laststring)
                            linebuf.left_adjust -- remove leading spaces
                            linebuf.right_adjust -- remove trailing white space
                            if not linebuf.empty then
				    -- see if it is a comment
				    if linebuf.item(1) /= file_cmt_char then
					    -- must be a real line; strip out in-line comments
					    pos := linebuf.index_of(file_cmt_char,1)
					    if pos > 0 then
						    linebuf.replace_substring("",pos,linebuf.count)
					    end

					    process_readline
				    end
                           end
                    end
                    file.close

            	    read_finalise
            ensure
           	File_closed: file.is_closed
            end
        
    write_file is
           require
                   Exists: exists
                   Writable: writable
           deferred
           ensure
           	   File_closed: file.is_closed
           end

feature -- template routines
	read_initialise is
			-- do any specific initialisation before processing whole file
		deferred
		end

	read_finalise is
			-- do any specific finalisation before processing whole file
		deferred
		end

	process_readline is
			-- process linebuf contents; guaranteed to be leading and trailing
			-- space stripped; no blank lines or comment lines
		deferred
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


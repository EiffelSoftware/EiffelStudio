indexing

description: "Driver for a generic compiler";
keywords: "Parsing framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class STANDARD_COMPILER

inherit
    THE_HANDLER;
    ARGUMENTS

feature

    make is

        local
            project : STRING
            path    : STRING
            intf    : PLAIN_TEXT_FILE
            err     : BOOLEAN

        do
            if not err then
                if argument_count /= 1 then
                    error (<<"Usage: ", command_name, " <project_name>">>)
                end
                error_handler.arm_warnings
                project := argument (1)
                path    := clone (project)

                if not fs.file_exists (path) then
                    error (<<"The file ", path, " does not exist">>)
                end

                if not fs.has_readperm (path) then
                    error (<<"You don't have read permission for ", path>>)
                end

                create intf.make_open_read (path)
                run_frontend (intf)
                intf.close
                intf := void                
                io.set_output_default
                io.put_string ("DONE%N")
            end
        rescue
            io.set_output_default
            if error_handler.in_text then
                io.new_line
                io.put_string (error_handler.text)
                io.new_line
                draw_arrow (error_handler.column)
                io.new_line
                io.put_string (error_handler.error_text)
                io.put_string ("%Nin line ")
                io.putint (error_handler.line)
                io.put_string (" of file ")
                io.put_string (error_handler.path)
                io.new_line
            elseif error_handler.generation then
                io.new_line
                io.put_string (error_handler.error_text)
                io.new_line
            elseif error_handler.error_text /= void then
                io.put_string (error_handler.error_text)
            else -- it's got to be a runtime error
                io.put_string ("Runtime error in routine%N")
                io.put_string (except.class_name)
                io.putchar ('.')
                io.put_string (except.recipient_name)
                io.put_string ("%NExplanation : ")
                io.put_string (except.meaning (except.exception))
                io.put_string ("%NTag : ")
                io.put_string (except.tag_name)
                io.new_line
                io.put_string (except.exception_trace)
            end
            io.new_line

            if intf /= void then
                intf.close
            end
            err := true
            retry
        end
-------------------------------------------------------------

    run_frontend (intf : PLAIN_TEXT_FILE) is
        -- This is essentially a "hook".

        local
            read : FILE_READER
            scan : PROJECT_SCANNER
            rcp  : ROOT_CONSTRUCT_PARSER

        do
            create read.make
            read.set_text (intf)
            create scan.make (read)
            create rcp
            rcp.parse (scan)

            run_backend (rcp.value)
        end
-------------------------------------------------------------

    run_backend (rc : ROOT_CONSTRUCT) is
        -- This too is a "hook".

        local
            pv : PROJECT_VISITOR

        do
            error_handler.set_generation (true)
            create pv.make
            rc.accept (pv)
            error_handler.set_generation (false)
        end
-------------------------------------------------------------

    draw_arrow (col : INTEGER) is

        local
            i : INTEGER

        do
            from
                i := 1
            until
                i >= col
            loop
                io.putchar ('_')
                i := i + 1
            end
            io.putchar ('^')
        end
-------------------------------------------------------------

    except : EXCEPTIONS is

        once
            create result
        end
-------------------------------------------------------------

    fs : FILE_SYSTEM is

        once
            create result.make
        end
-------------------------------------------------------------

    error (msgs : ARRAY [STRING]) is

        local
            i : INTEGER
            m : STRING

        do
            from
                i := msgs.lower
                m := msgs.item (i)
                i := i + 1
            until
                i > msgs.upper
            loop
                m.append (msgs.item (i))
                i := i + 1               
            end
            error_handler.error (m, false)
        end


end -- class STANDARD_COMPILER

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------

indexing

description: "General error handling in parser";
keywords: "Parsing framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ERROR_HANDLER

feature

    in_text : BOOLEAN
        -- Are we parsing?
    generation : BOOLEAN
        -- Are we generating code?
    warnings_deadly : BOOLEAN
        -- Do warnings stop the show?
    error_text : STRING

    arm_warnings is

        do
            warnings_deadly := true
        end
--------------------------------------------------------------

    set_scanner (scan : SCANNER) is

        do
            scanner := scan
        end
--------------------------------------------------------------

    text : STRING is
        -- Line of source text in which an error occurred.

        require
            in_text : in_text

        do
            result := scanner.text
        end
--------------------------------------------------------------

    line : INTEGER is
        -- Line number in source text in which an error occurred.

        require
            in_text : in_text

        do
            result := scanner.line
        end
--------------------------------------------------------------

    column : INTEGER is
        -- Column number in source text in which an error occurred.

        require
            in_text : in_text

        do
            result := scanner.column
        end
--------------------------------------------------------------

    path : STRING is
        -- Path of source text in which an error occurred.

        require
            in_text : in_text

        do
            result := scanner.path
        end
--------------------------------------------------------------

    set_generation (b : BOOLEAN) is

        do
            generation := b
        end
--------------------------------------------------------------

    error (msg : STRING; parsing : BOOLEAN) is
        -- Report an error described by `msg'; we are still
        -- parsing the source if `parsing' is true. Calling this
        -- procedure will halt parsing by raising an exception.

        do
            in_text := parsing
            error_text := msg
            except.raise ("ERROR:%N")
        end
--------------------------------------------------------------

    warning (msg: STRING; parsing : BOOLEAN) is
        -- Issue a warning described by `msg'; we are still
        -- parsing the source if `parsing' is true. Calling this
        -- procedure will halt parsing if `arm_warnings' has
        -- previously been called.

        do
            in_text := parsing
            if warnings_deadly then
                error_text := msg
                except.raise ("WARNING:%N")
            end
        end
--------------------------------------------------------------
feature { NONE }

    except : EXCEPTIONS is

        once
            create result
        end
------------------------------------------------------------ 

    scanner : SCANNER

end -- class ERROR_HANDLER

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

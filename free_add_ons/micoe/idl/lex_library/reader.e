indexing

description: "Generic reader. Breaks input up into individual characters. %
             %Can backtrack if needed. Remembers line and column as well %
             %as lexeme";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class READER

inherit
    SUBJECT

feature

    line : INTEGER 
        -- Line in which lexeme begins.
    col : INTEGER
        -- Column at which lexeme begins.
    lexeme : STRING
        -- Lexeme accepted by `accept'.
    end_of_text : BOOLEAN
    text : STRING
        -- Text line now being analyzed.

    make is

        do
            subject_make
        end
--------------------------------------------------------------

    has_text : BOOLEAN is

        deferred
        end
--------------------------------------------------------------

    input : CHARACTER is
        -- The next character on the input stream;
        -- '%N' at the end of a line, '%U' if end_of_text.

        require
            more_text : not end_of_text

        do 
            if cur_col <= text.count then
                result := text.item (cur_col)
            else
                result := '%N'
            end
        end
--------------------------------------------------------------

    path : STRING is
        -- Path of the file in which lexeme occurs.

        do
        end
--------------------------------------------------------------

    advance is
        -- Move to the next character in the input stream.

        require
            not_over : not end_of_text

        deferred
        end
--------------------------------------------------------------

    retreat is
        -- Put the last input character back on the input stream.

        deferred
        end
--------------------------------------------------------------

    accept is
        -- Accept the lexeme currently being analyzed, so
        -- we can move on to the next one.

        deferred
        end
--------------------------------------------------------------

    return is
        -- After a DFA has failed we need to go back to the
        -- beginning of the lexeme currently being analyzed.

        deferred
        end
--------------------------------------------------------------
    
feature { NONE }

    start_col  : INTEGER
    start_line : INTEGER
    cur_col    : INTEGER
    cur_line   : INTEGER

--------------------------------------------------------------

    frozen restart is
        -- Called by set_text to reinitialize the reader.
        -- This is a template method; each type of reader
        -- implements it by redefining the primitive
        -- method `special_restart'.

        do
           special_restart
           notify_all
        end
--------------------------------------------------------------

    special_restart is
        -- A primitive method for implementing the
        -- template method `restart' in each type of reader.

        deferred
        end
--------------------------------------------------------------

    compute_lexeme is

        do
            if cur_col <= text.count then
                lexeme := text.substring (start_col, cur_col)
            else
                lexeme := text.substring (start_col, text.count)
            end
        end

end -- class READER

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

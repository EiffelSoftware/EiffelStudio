
indexing

description: "A text matcher accepts a text as ARRAY [STRING] and a matcher %
             %as arguments to its creation procedure `make' and searches %
             %the entire text for the pattern with which the matcher was %
             %initialized. Thus any setup time the matcher may have incurred %
             %is paid only once no matter how many lines the text has.";
keywords: "string searching in long texts"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   TEXT_MATCHER

creation
    make


feature -- Initialization

    make (text : ARRAY [STRING]; mtch : MATCHER) is

        require
            some_text  : text.count > 0
            good_match : mtch /= void

        do
            ta := text
            m  := mtch
            first
        end         
-----------------------------------------------------------
feature -- Access
  
    line_no  : INTEGER
        -- Number of line in which a find may have occurred;
        -- valid only if `inside' is true.
    inside   : BOOLEAN
        -- Are we still inside the text?
    finished : BOOLEAN
        -- Do we want to quit? (see `stop')

    col_no : INTEGER is
        -- The column number at which a match occurred.
        -- Valid only if `inside' = true.

        do
            result := m.index
        end
-----------------------------------------------------------
 
    length : INTEGER is
        -- Length of the text matched by the pattern;
        -- this is not self-evident if the pattern is
        -- a regular expression.

        require
            was_found : col_no /= 0

        do
            result := m.length
        end
-----------------------------------------------------------
feature -- Operation

    first is
        -- Search for the first occurrence of the pattern.
        -- Set line_no and col_no appropriately.

        do
            finished := false

            from
                line_no := 1
            until
                ta.item (line_no) /= void
            loop
                line_no := line_no + 1
            end

            from
                m.set_text (ta.item (line_no)) 
                m.first 
            until
                m.index /= 0 or else line_no = ta.count 
            loop
                line_no := line_no + 1

                if ta.item (line_no) /= void then
                    m.set_text (ta.item (line_no))
                    m.first 
                end
            end

            inside   := (m.index /= 0)
            finished := not inside
        end 
-----------------------------------------------------------

    forth is
        -- Search for the next occurrence of the pattern.
        -- Set line_no and col_no accordingly.

        require
            not_first    : col_no > 0
            still_inside : inside

        do
            from
                m.forth 
            until
                m.index /= 0 or else line_no = ta.count 
            loop
                line_no := line_no + 1

                if ta.item (line_no) /= void then
                    m.set_text (ta.item (line_no))
                    m.first 
                end
            end

            inside   := (m.index /= 0)
            finished := not inside
        end
-----------------------------------------------------------
 
    stop is
        -- Make `finished' true without affecting `inside'.

        do
            finished := true
        end
-----------------------------------------------------------

 
feature { NONE }

    ta  : ARRAY [STRING]
    m   : MATCHER

end -- class TEXT_MATCHER

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

indexing

description: "This concrete implementation of MATCHER can search for %
              %multiple %"keywords simultaneously. Like the other matchers %
              %it returns the index in the text at which a keyword was found %
              %as well as the length of the word matched.";
keywords: "keywords"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   KEYWORD_MATCHER

inherit
    MATCHER
        export { NONE }
            make
        redefine
            first, forth,
            build_automat, advance, accept, reset
    end

creation
    initialize

feature -- Initialization
  
    initialize is
        -- Creation procedure.

        do
            create kwd.make (-1)
        end
-----------------------------------------------------------

    add_keyword (word : STRING) is
        -- Add a new keyword `word' to the list to look for.

        do
            count := count + 1
            kwd.add (word, count)
        end
-----------------------------------------------------------
feature -- Searching

    token : INTEGER     -- Number of the keyword found.

-----------------------------------------------------------

    first is
        -- Search for the first occurrence of a keyword.
        -- If successful set token, index and length accordingly.

        do
            if t.count > 1 then
                kwd.set_text (t)
                index := 1
                advance
            else
                index := 0
            end 
        end
-----------------------------------------------------------

    forth is
        -- Search for the next occurence of a keyword after a find.
        -- If successful set token, index and length accordingly.

        do
            index := index + length
            advance
        end
-----------------------------------------------------------

feature { NONE }

    kwd   : KEYWORDS [INTEGER]
    count : INTEGER         -- no. of keywords to search for

-----------------------------------------------------------

    build_automat is

        do
            -- not used
        end
-----------------------------------------------------------

    advance is

        do
            from
                token := -1
            until
                index > t.count or else token /= -1
            loop
                token := kwd.search (index)

                if token = -1 then
                    index := index + 1
                end
            end                 

            if token = -1 then
                index := 0
            else
                length := kwd.length
            end
        end
-----------------------------------------------------------

    accept : BOOLEAN is

        do
            -- not used
        end
-----------------------------------------------------------

    reset is

        do
            -- not used
        end

end -- class KEYWORD_MATCHER

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

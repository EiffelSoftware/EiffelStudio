indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TOKENS    -- treat a string as a sequence of tokens

creation
    make

feature

    make (seps : STRING) is

        local
            i : INTEGER

        do
            !!separators.make (1, 128)
            set_separators (seps)
        end
----------------------

    set_separators (seps : STRING) is

        local
            i : INTEGER

        do
            from
                i := separators.lower
            until
                i > separators.upper
            loop
                separators.put (false, i)
                i := i + 1
            end

            from
                i := 1
            until
                i > seps.count
            loop
                separators.put (true, seps.item (i).code)
                i := i + 1
            end
        end
----------------------

    set_text (s : STRING) is

        do
            text := s
            start 
        end
----------------------

    start is

        local
            i : INTEGER

        do
            next := 0
            advance

        ensure
            -- finished or else
            -- cursor not on a separator and then
            -- token consists of longest substring of non-separators
            -- beginning at cursor
        end
----------------------

    forth is

        require
            still_inside : not finished

        do
            advance

        ensure
            -- finished or else
            -- cursor not on a separator and then
            -- token consists of longest substring of non-separators
            -- beginning at cursor
        end
----------------------

    finished : BOOLEAN is

        do
            result := cursor > text.count
        end
----------------------

    stop is

        do
            cursor := text.count + 1
        end 
----------------------

    token : STRING is

        require
            still_inside : not finished

        do
            result := clone (text.substring (cursor, next - 1)) 
        end
----------------------

    rest : STRING is

        require
            still_inside : not finished

        do
            result := clone (text.substring (cursor, text.count))
        end
----------------------
feature { NONE }

    separators : ARRAY [BOOLEAN]
    text       : STRING
    cursor     : INTEGER    -- beginning of token
    next       : INTEGER    -- beginning of next separator

----------------------

    advance is

        do
            from
                cursor := next + 1
            until
                cursor > text.count or else
                not separators.item (text.item (cursor).code)         
            loop
                cursor := cursor + 1
            end

            if cursor <= text.count then
                from
                    next := cursor + 1
                until
                    next > text.count or else
                    separators.item (text.item (next).code)
                loop
                    next := next + 1
                end 
            end
        end
    
end -- class TOKENS

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

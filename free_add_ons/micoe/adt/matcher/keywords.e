indexing

description: "The data structure used by KEY_WORD_MATCHER; it is essentially %
             %a trie.";
keywords: "keywords", "tokens"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class  KEYWORDS [T]

creation
    make

feature -- Initialization

    make (error_token : T) is
        -- Initialize the structure and remember `error_token' as the
        -- token to return if a search fails.

        local
            i : INTEGER

        do
            error_tok := error_token
            create items.make (1, Min_size)
            create tokens.make (1, Min_size)
            create down.make (1, Min_size)
            create right.make (1, Min_size)
            free   := 1
            root   := 0
            length := 0
        end
-----------------------------------------------------------

    add (word : STRING; token : T) is
        -- Add a keyword to be searched for together with
        -- the token to return if this keyword is found.

        local
            indx : INTEGER
            pos  : INTEGER
            left : INTEGER
            up   : INTEGER
            new  : INTEGER
            ch   : CHARACTER

        do
            from
                indx   := 1
                pos    := root
            until
                indx > word.count
            loop
                from 
                    ch := word.item (indx) 
                until
                    pos = 0 or else ch >= items.item (pos)
                loop
                    left := pos
                    pos  := right.item (pos)
                end
                    
                if pos = 0 or else items.item (pos) /= ch then
                    new := new_node
                    items.put (ch, new)
                    right.put (pos, new)
                    pos := new

                    if left /= 0 then
                        right.put (new, left)
                    elseif up /= 0 then
                        down.put (new, up)
                    else
                        root := new
                    end
                end

                if indx = word.count then
                    tokens.put (token, pos)
                end

                up   := pos
                pos  := down.item (pos)
                left := 0
                indx := indx + 1
            end 
        end
-----------------------------------------------------------   

    set_text (text : STRING) is
        -- Set the text to be searched for occurrences of the
        -- keywords.

        do
            t := text
        end
-----------------------------------------------------------
feature -- Searching

    length : INTEGER    -- no. of characters matched by last successful search

-----------------------------------------------------------
   
    search (start : INTEGER) : T is
        -- Start searching for a keyword in text at position `start';
        -- return corresponding token if match, otherwise error token.

        local
            indx : INTEGER
            pos  : INTEGER
            ch   : CHARACTER

        do
            from
                result := error_tok
                length := 0
                indx   := start
                pos    := root
            until
                pos = 0 or else indx > t.count
            loop
                from 
                    ch := t.item (indx) 
                until
                    pos = 0 or else ch >= items.item (pos)
                loop
                    pos := right.item (pos)
                end
                    
                if pos /= 0 and then items.item (pos) = ch then
                    result := tokens.item (pos) 
                    length := length + 1
                    indx   := indx + 1 
                    pos    := down.item (pos) 
 
                else 
                    pos := 0
                end
            end 
        end
-----------------------------------------------------------

feature { NONE }

    Min_size : INTEGER is 16

    t         : STRING
    error_tok : T
    items     : ARRAY [CHARACTER]
    tokens    : ARRAY [T]
    right     : ARRAY [INTEGER]
    down      : ARRAY [INTEGER]
    root      : INTEGER 
    free      : INTEGER
 
-----------------------------------------------------------

feature { NONE }

    new_node : INTEGER is

        do
            if free > items.count then
                expand
            end

            result := free
            free   := free + 1

            down.put (0, result)
            tokens.put (error_tok, result)
        end
-----------------------------------------------------------

    expand is

        local
            old_size : INTEGER

        do
            old_size := items.count 

            items.resize (1, 2 * old_size)
            tokens.resize (1, 2 * old_size)
            right.resize (1, 2 * old_size)
            down.resize (1, 2 * old_size)
        end

end -- class KEYWORDS

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

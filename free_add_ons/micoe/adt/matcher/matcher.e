indexing

description: "The abstract parent of all matcher classes.";
keyords: "string matching"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
deferred class MATCHER


feature -- Initialization

    make (pattern : STRING) is
        -- Establishes the pattern for
        -- which the matcher shall search.

        require
            good_pattern : pattern /= void and then pattern.count > 0

        do
            p := pattern
            build_automat
        end
-----------------------------------------------------------

    set_text (the_text : STRING) is
        -- Establish the string to be searched for occurences
        -- of `pattern'.

        do
            if safe then
                t := clone (the_text)
            else
                t := the_text
            end

            index := 0      -- prevent next_match before first_match
        end
-----------------------------------------------------------

    set_safe is
        -- Always clone text. `set_safe' should
        -- be called whenever the text originally given to
        -- `set_text' is going to be modified while the matcher
        -- is busy searching.

        do
            safe := true

            if p /= void then
                p := clone (p)
            end
            if t /= void then
                t := clone (t)
            end
        end
-----------------------------------------------------------
feature -- Access

    length : INTEGER
        -- The length of the pattern matched.
        -- This is not as ridiculous as it might look at first;
        -- If the pattern is a regular expression, we cannot know
        -- a priori how long the matched text will be.

    index  : INTEGER
        -- The index in the string `text' at which `pattern' was
        -- found by the last call to `first' or `forth'. If no match
        -- was found, then `index' = 0. Note that `index' = 1 means
        -- that the pattern matches the beginning of the text (i.e.
        -- is a prefix of the text).

feature -- Operation

    first is
        -- Search the text set with `set_text' for the pattern
        -- set with `make'. Set `index' to the index in the text
        -- where the pattern is first found if it is found;
        -- otherwise set `index' to 0. Note that `index' = 1
        -- means that the pattern matches the beginning of the text.

        require
            text_there : text /= void

        do
            index := 0

            if start_i <= t.count + 1 then
                match_init
                advance

                if accept then
                    index := shift - length
                    reset
                end
            end
        end
-----------------------------------------------------------

    forth is
        -- Search the text set with `set_text' for the next
        -- occurence of the pattern set with `make'. Set `index'
        -- to the index in the text where the pattern is found
        -- if it is found; otherwise set `index' to 0.

        require
            not_first : index > 0

        do
            index := 0

            if shift <= t.count + 1 then
                advance

                if accept then
                    index := shift - length
                    reset
                end
            end
        end
-----------------------------------------------------------

    text : STRING is
            -- The string to be searched for pattern.

        do
            result := t
        end
-----------------------------------------------------------
 
feature { NONE }

    t       : STRING        -- the text in which to search
    p       : STRING        -- the pattern to search for
 
    state   : INTEGER       --  current state of the automat
    shift   : INTEGER       --  current position in text

    start_s : INTEGER       -- starting value of state for first_match
    start_i : INTEGER       --   "        "   "  shift  "    "    "

    safe    : BOOLEAN       -- do we clone text and pattern?

-----------------------------------------------------------
 
    build_automat is

        deferred
        end 
-----------------------------------------------------------

    match_init is
        -- A default implementation that will almost
        -- always work.

        do
            shift := start_i
            state := start_s
        end
-----------------------------------------------------------

    advance is
        -- Look for next match

        deferred
        end
-----------------------------------------------------------

    accept : BOOLEAN is
        -- Has pattern been matched?

        deferred
        end
-----------------------------------------------------------

    reset is
        -- Put automat in proper state for next_match 

        deferred
        end
-----------------------------------------------------------

end -- class MATCHER

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

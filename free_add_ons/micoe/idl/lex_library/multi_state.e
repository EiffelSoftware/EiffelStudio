indexing

description: "Makes transition to `follows[i]' iff input character is %
             %`inputs[i]'; if input character not in `inputs' transition %
             %to `alternate'";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class MULTI_STATE

inherit
    STATE

creation
    make

feature

    make (chars  : ARRAY [CHARACTER];
          states : ARRAY [STATE];
          alt    : STATE            ) is

        require
            matching_bounds : chars.lower = states.lower and then
                             chars.upper = states.upper
        do
            inputs    := chars
            follows   := states
            alternate := alt
        end
------------------------------------------------------------

    set_successor (suc : STATE; index : INTEGER) is

        require
            valid_index : valid_index (index)

        do
            follows.put (suc, index)
        end
------------------------------------------------------------

    valid_index (index : INTEGER) : BOOLEAN is

        do
            result := (follows.lower <= index and then index <= follows.upper)
        end
------------------------------------------------------------

    set_alternate (alt : STATE) is

        do
            alternate := alt
        end
------------------------------------------------------------

    transition (ch : CHARACTER) : STATE is

        local
            i : INTEGER

        do
            from
                i := inputs.lower
            until
                i > inputs.upper or else ch = inputs.item (i)
            loop
                i := i + 1
            end

            if i <= inputs.upper then
                result := follows.item (i)
            else
                result := alternate
            end
        end
------------------------------------------------------------
feature { NONE }

    inputs    : ARRAY [CHARACTER]
    follows   : ARRAY [STATE]
    alternate : STATE

end -- class MULTI_STATE

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

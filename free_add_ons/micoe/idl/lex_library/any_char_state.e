indexing

description: "Makes transition to state `successor' on every input";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ANY_CHAR_STATE

inherit
    STATE

creation
    make

feature

    make (s : STATE) is

        do
            successor := s
        end
-------------------------------------------------------

    set_successor (s : STATE) is

        do
            successor := s
        end
-------------------------------------------------------

    transition (ch : CHARACTER) : STATE is
        -- `current' makes a transition to
        -- state `successor' regardless of what
        -- `ch' may be.

        do
            result := successor
        end
-------------------------------------------------------
feature { NONE }

    successor : STATE

end -- class ANY_CHAR_STATE

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

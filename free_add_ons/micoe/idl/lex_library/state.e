indexing

description: "Generic state used by DFAs";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class STATE

feature

    transition (ch : CHARACTER) : STATE is
        -- Upon input `ch' make transition to
        -- the state returned by this function.

        deferred
        end
----------------------

    accept : BOOLEAN is
        -- Is `current' an accepting state?

        do
        end
----------------------

    put_back : BOOLEAN is
        -- Do we need to put the last character
        -- read back on the input stream when we
        -- reach `current'?

        require
            is_accepting_state : accept

        do
        end
----------------------

    token : INTEGER is
        -- Token to be returned when `current'
        -- is reached.

        require
            is_accepting_state : accept

        do
        end

end -- class STATE


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

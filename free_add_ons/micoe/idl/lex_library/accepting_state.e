indexing

description: "Still to be entered";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ACCEPTING_STATE

inherit
    STATE
        redefine
            accept, put_back, token
        end

creation
    make

feature

    make (pb : BOOLEAN; tok : INTEGER) is
        -- Should this accepting state cause
        -- the last character read to be put back?
        -- Which token should be returned if this
        -- state is reached?

        do
            do_put_back := pb
            my_token    := tok
        end
---------------------------------------------------

    transition (ch : CHARACTER) : STATE is

        do
            except.raise ("transition called for an accepting state")
        end
---------------------------------------------------

    accept : BOOLEAN is

        do
            result := true
        end
---------------------------------------------------

    put_back : BOOLEAN is

        do
            result := do_put_back
        end
---------------------------------------------------

    token : INTEGER is

        do
            result := my_token
        end
---------------------------------------------------
feature { NONE }

    do_put_back : BOOLEAN
    my_token    : INTEGER
---------------------------------------------------

    except : EXCEPTIONS is

        once
            create result
        end

end -- class ACCEPTING_STATE

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

indexing

description: "Makes transition to state `digit' iff input character `ch' is %
             % a digit, to state `dot' iff input character is a decimal dot %
             %`.' and otherwise to state `other'";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class DIGIT_DOT_STATE

inherit
    STATE

creation
    make

feature

    make (dg, dt, oth : STATE) is

        do
            digit := dg
            dot   := dt
            other := oth
        end
--------------------------------------------------------------

    transition (ch : CHARACTER) : STATE is

        do
            if '0' <= ch and then ch <= '9' then
                result := digit
            elseif ch = '.' then
                result := dot
            else
                result := other
            end
        end
--------------------------------------------------------------

    set_digit_state (dg : STATE) is

        do
            digit := dg
        end
--------------------------------------------------------------

    set_dot_state (dt : STATE) is

        do
            dot := dt
        end
--------------------------------------------------------------

    set_other_state (oth : STATE) is

        do
            other := oth
        end
--------------------------------------------------------------
feature { NONE }

    digit : STATE
    dot   : STATE
    other : STATE

end -- class DIGIT_DOT_STATE

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

indexing

description: "Makes transition to state `quote' iff input character is %
             %a quote `%"', to state `percent' if it is a percent character %
             %`%%', otherwise to `other'. This is useful for Eiffel style %
             %strings";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class QUOTE_PERCENT_STATE

inherit
    STATE
        redefine
            transition
        end

creation
    make

feature

    make (qt, pt, oth : INTEGER) is

        do
            quote   := qt
            percent := pt
            other   := oth
        end
--------------------------------------------------------------

    transition (ch : CHARACTER) : INTEGER is

        do
            if ch = '%'' then
                result := quote
            elseif ch = '%%' then
                result := percent
            else
                result := other
            end
        end
--------------------------------------------------------------

feature { NONE }

    quote   : INTEGER
    percent : INTEGER
    other   : INTEGER

end -- class QUOTE_PERCENT_STATE

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

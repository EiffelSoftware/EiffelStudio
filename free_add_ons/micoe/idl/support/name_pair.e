indexing

description: "Data structure stored in symbol table";
keywords: "symbol table";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class NAME_PAIR

inherit
    COMPARABLE
        redefine
            infix "<"
        end

creation
    make

feature

    lower_name : STRING
         -- Name entirely in lower case.
    real_name : STRING
         -- Name as it originally looked.

    make (nm : STRING) is

        do
            real_name := nm
            lower_name := clone (nm)
            lower_name.to_lower
        end
---------------------------------------------

    infix "<" (other : like current) : BOOLEAN is

        do
            result := (lower_name < other.lower_name)
        end

end -- class NAME_PAIR

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

indexing

description: "Trivial data structure used by DATA_ENCODER encapsulation";
keywords: "data encoder", "encapsulation";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ENCAPS_STATE

feature { DATA_ENCODER } -- Access

    pos   : INTEGER
    bo    : INTEGER
    align : INTEGER

----------------------
feature -- Mutation

    set_pos (p : INTEGER) is

        do
            pos := p
        end
----------------------

    set_bo (b : INTEGER) is

        do
            bo := b
        end
----------------------

    set_align (a : INTEGER) is

        do
            align := a
        end

end -- class ENCAPS_STATE

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










indexing

description: "This effective version of CATALOG stores the n%
             % items associated with a given key in a list.";
keywords: "1:n mapping"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class   LIST_CATALOG [G, K -> HASHABLE]

inherit
    CATALOG [G, K]
        redefine
            anchor, new_list
        end

creation
    make

feature

    anchor : ES_LIST [G]

feature { NONE }

    new_list : like anchor is

        do
            create {ES_LIST [G]} result.make (false)
        end

end -- class LIST_CATALOG 

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

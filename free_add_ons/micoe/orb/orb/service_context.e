indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SERVICE_CONTEXT -- This is actually a struct.

inherit
    ANY
        redefine
            copy, is_equal
        end

creation
    make

feature

    make (id : INTEGER; d : ARRAY [INTEGER]) is

        do
            context_id   := id
            context_data := d
        end
----------------------

    get_context_id : INTEGER is

        do
            result := context_id
        end
----------------------------------

    set_context_id (new_id : INTEGER) is

        do
            context_id := new_id
        end
----------------------------------

    get_context_data : ARRAY [INTEGER] is

        do
            result := context_data
        end
----------------------------------

    set_context_data (new_data : ARRAY [INTEGER]) is

        do
            context_data := new_data
        end
----------------------------------
feature -- Copying

    copy (other : like current) is

        do
        end
----------------------------------

    is_equal (other : like current) : BOOLEAN is

        do
        end
----------------------------------
feature { NONE } -- Implementation

    context_id   : INTEGER
    context_data : ARRAY [INTEGER]

end -- class SERVICE_CONTEXT

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

indexing

description: "The parent of all _HELPER classes";
keywords: "narrow";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class STANDARD_NARROW_HELPER

feature

    local_objects : DICTIONARY [IMPLEMENTATION_BASE, STRING] is

        do
            create result.make
        end
----------------------

    horb : ORB is

        local
            theo : THE_ORB

        once
            create theo.make (0, void, "")
            result := theo.ORB_instance
        end

end -- class STANDARD_NARROW_HELPER

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










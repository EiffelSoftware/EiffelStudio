indexing

description: "Some constants needed by clients of DISPATCHER";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class EVENT_CONSTANTS

feature -- Dispatcher events; actually an enum

    Timer_ev  : INTEGER is 0
    Read_ev   : INTEGER is 1
    Write_ev  : INTEGER is 2
    Accept_ev : INTEGER is 3
    Except_ev : INTEGER is 4
    All_ev    : INTEGER is 5
    Remove_ev : INTEGER is 6

    Request_done : INTEGER is 0
        -- This one is actually defined in
        -- struct RequestCallback (dii.h)
  
end -- class EVENT_CONSTANTS

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

indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class IIOP_PROXY_INVOKE_RECORD

creation
    make, make1, make2, make3, make4

feature -- Initialization

    make is

        do
        end
----------------------

    make1 (the_conn : GIOP_CONNECTION) is

        do
            make4 (the_conn, void, 0, 0)
        end
----------------------

    make2 (the_conn : GIOP_CONNECTION; the_req : ORB_REQUEST) is

        do
            make4 (the_conn, the_req, 0, 0)
        end
----------------------

    make3 (the_conn : GIOP_CONNECTION;
           the_req  : ORB_REQUEST;
           cs       : INTEGER) is

        do
            make4 (the_conn, the_req, cs, 0)
        end
----------------------

    make4 (the_conn : GIOP_CONNECTION;
           the_req  : ORB_REQUEST;
           cs, wcs  : INTEGER) is

        do
            conn  := the_conn
            req   := the_req
            csid  := cs
            wcsid := wcs
        end
----------------------

    get_conn : GIOP_CONNECTION is

        do
            result := conn
        end
----------------------

    request : ORB_REQUEST is

        do
            result := req
        end
----------------------

    get_csid : INTEGER is

        do
            result := csid
        end
----------------------

    get_wcsid : INTEGER is

        do
            result := wcsid
        end
----------------------
feature { NONE } -- Implementation

    conn  : GIOP_CONNECTION
    req   : ORB_REQUEST
    csid  : INTEGER
    wcsid : INTEGER

end -- class IIOP_PROXY_INVOKE_RECORD

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

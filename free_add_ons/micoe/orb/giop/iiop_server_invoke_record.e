indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class IIOP_SERVER_INVOKE_RECORD

creation
    make4, make6

feature -- Initialization

    make4 (gconn : GIOP_CONNECTION;
           rid   : INTEGER;
           oid   : INTEGER;
           obj   : CORBA_OBJECT) is

        do
            my_conn  := gconn
            my_orbid := oid
            my_reqid := rid
            my_obj   := obj
            my_pr    := void
        end
----------------------

    make6 (gconn : GIOP_CONNECTION;
           rid   : INTEGER;
           oid   : INTEGER;
           oreq  : ORB_REQUEST;
           obj   : CORBA_OBJECT;
           pr    : PRINCIPAL) is

        do
            my_conn  := gconn
            my_orbid := oid
            my_reqid := rid
            my_obj   := obj
            my_pr    := pr
        end
----------------------

    req : ORB_REQUEST is

        do
            result := my_req
        end
----------------------

    orbid : INTEGER is

        do
            result := my_orbid
        end
----------------------

    set_orbid (id : INTEGER) is

        do
            my_orbid := id
        end
----------------------

    reqid : INTEGER is

        do
            result := my_reqid
        end
----------------------

    conn : GIOP_CONNECTION is

        do
            result := my_conn
        end
----------------------
feature { NONE } -- Implementation

    my_req   : ORB_REQUEST
    my_obj   : CORBA_OBJECT
    my_pr    : PRINCIPAL
    my_orbid : INTEGER
    my_reqid : INTEGER
    my_conn  : GIOP_CONNECTION


end -- class IIOP_SERVER_INVOKE_RECORD

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

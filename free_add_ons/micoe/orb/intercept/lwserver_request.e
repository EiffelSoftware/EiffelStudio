indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LWSERVER_REQUEST

inherit
    LWROOT_REQUEST
        rename
            make as lwrr_make
        redefine
            repoid
        end

creation
    make

feature

    make ( the_obj : CORBA_OBJECT;
           the_op  : STRING;
           the_svc : INDEXED_LIST [SERVICE_CONTEXT];
           the_req : CORBA_SERVER_REQUEST) is

        do
            lwrr_make (obj, op, the_svc)
            obj := the_obj
            op  := the_op
            req := the_req
        end
----------------------------------

    repoid : STRING is

        do
            result := "IDL:omg.org/Interceptor/LWServerRequest:1.0"
        end
----------------------------------

    request : CORBA_SERVER_REQUEST is

        do
            result := req
        end
----------------------------------
feature { NONE } -- Implementation

    req : CORBA_SERVER_REQUEST

end -- class LWSERVER_REQUEST

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

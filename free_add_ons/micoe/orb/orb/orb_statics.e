indexing

description: "A trick to achieve the semantics of static features as in %
             %C++ or Java. Various enumerated types are also available here.";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ORB_STATICS

inherit
    THE_LOGGER;
    EXCEPTION_STATICS;
    CODESET_STATICS;
    INTERCEPTOR_STATICS;
    ADDRESS_STATICS

feature

------- Constants needed by ORBs ---------------

   -- InvokeStatus

   Invoke_ok      : INTEGER is 0
   Invoke_forward : INTEGER is 1
   Invoke_sys_ex  : INTEGER is 2
   Invoke_usr_ex  : INTEGER is 3

    -- LocateStatus

    Locate_unknown : INTEGER is 0
    Locate_here    : INTEGER is 1
    Locate_forward : INTEGER is 2

    -- RequestType

    Request_invoke  : INTEGER is 0
    Request_bind    : INTEGER is 1
    Request_locate  : INTEGER is 2
    Request_unknown : INTEGER is 3

    -- ORBCallback::Event

    ORB_invoke : INTEGER is 0
    ORB_locate : INTEGER is 1
    ORB_bind   : INTEGER is 2
----------------------

    fs : FILE_SYSTEM is

        once
            create result.make
        end

end -- class ORB_STATICS

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

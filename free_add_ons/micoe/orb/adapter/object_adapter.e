indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class OBJECT_ADAPTER

feature

    get_oaid : STRING is

        deferred
        end
----------------------
feature { ORB, REQUEST_QUEUE_RECORD} -- OAI (Object Adapter Interface}
    -- We have to make an exception for REQUEST_QUEUE_RECORD
    -- because it would be ridiculous to let REQUEST_QUEUE_RECORD
    -- inherit from ORB.

    is_local : BOOLEAN is

        deferred
        end
----------------------

    has_object (o : CORBA_OBJECT) : BOOLEAN is

        deferred
        end
----------------------

    address_used_for_object (obj : CORBA_OBJECT) : ADDRESS is

        deferred
        end
----------------------

    invoke4 (msgid : INTEGER; o : CORBA_OBJECT; req : ORB_REQUEST;
            pr : PRINCIPAL) : BOOLEAN is

        do
            result := invoke5(msgid, o, req, pr, true)
        end
----------------------

    invoke5 (msgid : INTEGER; o : CORBA_OBJECT; req : ORB_REQUEST;
             pr : PRINCIPAL; response_exp : BOOLEAN) : BOOLEAN is

        deferred
        end
----------------------

    bind (msgid : INTEGER; repoid : STRING; tag : ARRAY [INTEGER];
          addr : ADDRESS) : BOOLEAN is

        deferred
        end
----------------------

    locate (msgid : INTEGER; o : CORBA_OBJECT) is

        deferred
        end
----------------------

    skeleton (o : CORBA_OBJECT) : CORBA_OBJECT is

        deferred
        end
----------------------

    cancel (msgid : INTEGER) is

        deferred
        end
----------------------

    shutdown (wait_for_completion : BOOLEAN) is

        deferred
        end
----------------------
feature { ANY }

    answer_invoke (msgid : INTEGER; o : CORBA_OBJECT; req : ORB_REQUEST;
                   stst : INTEGER) is

        deferred
        end

end -- class OBJECT_ADAPTER

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

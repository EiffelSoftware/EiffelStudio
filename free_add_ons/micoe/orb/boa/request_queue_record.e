indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class REQUEST_QUEUE_RECORD

inherit
    ORB_STATICS

creation
    make_invoke, make_bind, make_locate

feature

    make_invoke (mid  : INTEGER;
                 req  : ORB_REQUEST;
                 ob   : CORBA_OBJECT;
                 p    : PRINCIPAL;
                 resp : BOOLEAN) is

        do
            id           := mid
            request      := req
            obj          := ob
            pr           := p
            response_exp := resp
            type         := Request_invoke
        end
-----------------------------------

   make_bind (mid  : INTEGER;
              rep  : STRING;
              oid  : ARRAY [INTEGER]) is

        do
            id      := mid
            request := void
            obj     := void
            pr      := void
            tag     := oid
            type    := Request_bind
        end
-----------------------------------

    make_locate (mid : INTEGER;
                 ob  : CORBA_OBJECT) is

        do
            id := mid
            request := void
            obj     := ob
            pr      := void
            type    := Request_locate
        end
-----------------------------------
feature -- Access

    target : CORBA_OBJECT is

        do
            result := obj
        end
-----------------------------------

    msgid : INTEGER is

        do
             result := id
        end
-----------------------------------
feature -- Operation

    exec (the_oa : OBJECT_ADAPTER; the_orb : ORB) is

        local
            dum : BOOLEAN

        do
            inspect type

            when Request_invoke then
                dum := the_oa.invoke5 (id, obj, request, pr, response_exp)
            when Request_bind then
                if not the_oa.bind (id, repoid, tag, void) then
                    the_orb.answer_bind (id, Locate_unknown, void)
                end
            when Request_locate then
                the_oa.locate (id, obj)

            end
        end
-----------------------------------

    fail (the_oa : OBJECT_ADAPTER; the_orb : ORB) is

        local
            ex  : COMM_FAILURE

        do
            inspect type

            when Request_invoke then
                create ex.make
                request.set_out_args_ex (ex)
                the_orb.answer_invoke (id, Invoke_sys_ex, void, request)

            when Request_bind then
                the_orb.answer_bind (id, Locate_unknown, void)

            when Request_locate then
                the_orb.answer_locate (id, Locate_unknown, void)

            end
        end
-----------------------------------
feature { NONE } -- Implementation

    type         : INTEGER
    repoid       : STRING
    request      : ORB_REQUEST
    pr           : PRINCIPAL
    obj          : CORBA_OBJECT
    id           : INTEGER
    response_exp : BOOLEAN
    tag          : ARRAY [INTEGER]

end -- class REQUEST_QUEUE_RECORD

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

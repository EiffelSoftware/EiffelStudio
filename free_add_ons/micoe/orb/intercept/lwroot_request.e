indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class LWROOT_REQUEST

creation
    make

feature

    make (the_obj : CORBA_OBJECT;
          the_op  : STRING;
          the_svc : INDEXED_LIST [SERVICE_CONTEXT]) is

        do
            svc := the_svc
            op  := the_op
            obj := the_obj
        end
---------------------------------------------------------

    repoid : STRING is

        do
            result := "IDL:omg.org/Interceptor/LWRootRequest:1.0"
        end
---------------------------------------------------------

    set_target (o : CORBA_OBJECT) is

        do
            obj := o
        end
---------------------------------------------------------

    get_target : CORBA_OBJECT is

        do
            result := obj
        end
---------------------------------------------------------

    set_operation (the_op : STRING) is

        do
            op := the_op
        end
---------------------------------------------------------

    get_operation : STRING is

        do
            result := op
        end
---------------------------------------------------------

    set_service_context (id : INTEGER;
                         fl : FLAGS;
                         d  : ARRAY [INTEGER]) is

        local
            i, n : INTEGER
            done : BOOLEAN
            sc   : SERVICE_CONTEXT

        do
            from
                i := 1
                n := svc.count
            until
                i > n
            loop
                if svc.at (i).get_context_id = id then
                    svc.at (i).set_context_data (d)
                    done := true
                    check
                        have_permission : fl.value = 0
                    end
                else
                    i := i + 1
                end
            end
            if not done then
                create sc.make (id, d)
                svc.append (sc)
            end
        end
---------------------------------------------------------

    get_service_context (id : INTEGER; fl : FLAGS) : ARRAY [INTEGER] is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := svc.count
            until
                i > n or else result /= void
            loop
                if svc.at (i).get_context_id = id then
                    result := clone (svc.at (i).get_context_data)
                else
                    i := i + 1
                end
            end

        ensure
            nonvoid_result : result /= void
        end
---------------------------------------------------------

    remove_service_context (id : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := svc.count
            until
                i > n
            loop
                if svc.at (i).get_context_id = id then
                    svc.remove_at (i)
                    i := n + 1
                else
                    i := i + 1
                end
            end
        end
---------------------------------------------------------

    has_service_context (id : INTEGER) : BOOLEAN is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := svc.count
            until
                i > n or else result
            loop
                if svc.at (i).get_context_id = id then
                    result := true
                else
                    i := i + 1
                end
            end
        end
---------------------------------------------------------

    set_context (interceptor : ROOT; ctx : INTERCEPTOR_CONTEXT) is

        do
            ctxs.put (ctx, interceptor)
        end
---------------------------------------------------------

    get_context (interceptor : ROOT) : INTERCEPTOR_CONTEXT is

        do
            if not ctxs.has (interceptor) then
                result := ctxs.at (interceptor)
            end
        end
---------------------------------------------------------
feature -- Implementation

    ctxs : DICTIONARY [INTERCEPTOR_CONTEXT, ROOT]
    svc  : INDEXED_LIST [SERVICE_CONTEXT]
    op   : STRING
    obj  : CORBA_OBJECT

end -- class LWROOT_REQUEST





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

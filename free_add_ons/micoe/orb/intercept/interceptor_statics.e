indexing

description: "A trick to achieve the semantics of static features as in %
             %C++ or Java.";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class INTERCEPTOR_STATICS

feature

-------Statics needed by interceptors-----------

    Invoke_continue : INTEGER is 0
    Invoke_abort    : INTEGER is 1
    Invoke_retry    : INTEGER is 2
    Invoke_break    : INTEGER is 3

----------------------

    Initialize_request_code : INTEGER is 0
    After_marshal_code      : INTEGER is 1
    Before_unmarshal_code   : INTEGER is 2
    Before_marshal_code     : INTEGER is 3
    After_unmarshal_code    : INTEGER is 4
    Finish_request_code     : INTEGER is 5

----------------------

    client_ics : SORTED_LIST [CLIENT_INTERCEPTOR] is

        once
            create result.make (false)
        end
----------------------

    client_exec (req : LWREQUEST;
                 env : ENVIRONMENT;
                 m   : INTEGER) : BOOLEAN is
        -- XXX the C++ code has a third argument of
        -- type InterceptorMethod, which represents a
        -- pointer to a method of the class ClientInterceptor
        -- accepting arguments of the types LWRquest and
        -- Environment (actually pointers in both cases).
        -- We implement these pointers to methods with
        -- constants defined above. I don't find this very
        -- elegant -- but then ...

        local
            it : ITERATOR
            s  : INTEGER

        do
            if client_ics.count = 0 then
                result := true
            else
                check
                    nonvoid_req : req /= void
                end
                from
                    it := client_ics.iterator
                until
                    it.finished
                loop
                    inspect m

                    when Initialize_request_code then
                        s := Client_ics.item (it).initialize_request (req, env)

                    when Before_unmarshal_code then
                        s := Client_ics.item (it).before_unmarshal (req, env)

                    when After_marshal_code then
                        s := Client_ics.item (it).after_marshal (req, env)

                    when Finish_request_code then
                        s := Client_ics.item (it).finish_request (req, env)
                    end
                    if s = Invoke_abort then
                        result := false
                        it.stop
                    elseif s = Invoke_break then
                        result := true
                        it.stop
                    elseif s = Invoke_retry then
                        check
                            know_what_to_do : false
                        end
                    else
                        it.forth
                    end
                end -- loop
                result := true
            end -- if client_ics.count = 0 then ...
        end
----------------------

    client_exec_initialize_request (req : LWREQUEST;
                                    env : ENVIRONMENT) : BOOLEAN is

        do
            result := Client_exec (req, env, Initialize_request_code) 
        end
----------------------

    client_exec_after_marshal (req : LWREQUEST;
                         env : ENVIRONMENT) : BOOLEAN is

        do
             result := Client_exec (req, env, After_marshal_code)
        end
----------------------

    client_exec_before_unmarshal (req : LWREQUEST;
                           env : ENVIRONMENT) : BOOLEAN is

        do
            result := Client_exec (req, env, Before_unmarshal_code)
        end
----------------------

    client_exec_finish_request (req : LWREQUEST;
                         env : ENVIRONMENT) : BOOLEAN is

        do
            result := Client_exec (req, env, Finish_request_code)
        end
----------------------

   client_create_request (obj : CORBA_OBJECT;
                   op  : STRING;
                   svc : INDEXED_LIST [SERVICE_CONTEXT];
                   req : CORBA_REQUEST) : LWREQUEST is

        do
            if client_ics.count /= 0 then
                create result.make (obj, op, svc, req)
            end
        end
----------------------

    server_ics : SORTED_LIST [SERVER_INTERCEPTOR] is

        once
            create result.make (false)
        end
----------------------

    server_exec (req  : LWSERVER_REQUEST;
                 env  : ENVIRONMENT;
                 m    : INTEGER) : BOOLEAN is
        -- XXX the C++ code has a third argument of
        -- type InterceptorMethod, which represents a
        -- pointer to a method of the class ServerInterceptor
        -- accepting arguments of the types LWRquest and
        -- Environment (actually pointers in both cases).
        -- We implement these pointers to methods with
        -- constants defined above. I don't find this very
        -- elegant -- but then ...

        local
            it : ITERATOR
            s  : INTEGER

        do
            if server_ics.count = 0 then
                result := true
            else
                check
                    nonvoid_req : req /= void
                end
                from
                    it := server_ics.iterator
                until
                    it.finished
                loop
                    inspect m

                    when Initialize_request_code then
                        s := server_ics.item (it).initialize_request (req, env)

                    when Before_marshal_code then
                        s := server_ics.item (it).before_marshal (req, env)

                    when After_unmarshal_code then
                        s := server_ics.item (it).after_unmarshal (req, env)

                    when Finish_request_code then
                        s := server_ics.item (it).finish_request (req, env)

                    end
                    if s = Invoke_abort then
                        result := false
                        it.stop
                    elseif s = Invoke_break then
                        result := true
                        it.stop
                    elseif s = Invoke_retry then
                        check
                            know_what_to_do : false
                        end
                    else
                        it.forth
                    end
                end -- loop
                result := true
            end -- if server_ics.count = 0 then ...
        end
----------------------

    server_exec_initialize_request (req : LWSERVER_REQUEST;
                             env : ENVIRONMENT) : BOOLEAN is

        do
            result := server_exec (req, env, Initialize_request_code)
        end
----------------------

    server_exec_before_marshal (req : LWSERVER_REQUEST;
                         env : ENVIRONMENT) : BOOLEAN is

        do
            result := server_exec (req, env, Before_marshal_code)
        end
----------------------

    server_exec_after_unmarshal (req : LWSERVER_REQUEST;
                           env : ENVIRONMENT) : BOOLEAN is

        do
            result := server_exec (req, env, After_unmarshal_code)
        end
----------------------

    server_exec_finish_request (req : LWSERVER_REQUEST;
                         env : ENVIRONMENT) : BOOLEAN is

        do
            result := server_exec (req, env, Finish_request_code)
        end
----------------------

   server_create_request (obj : CORBA_OBJECT;
                   op  : STRING;
                   svc : INDEXED_LIST [SERVICE_CONTEXT];
                   req : CORBA_SERVER_REQUEST) : LWSERVER_REQUEST is

        do
            if server_ics.count /= 0 then
                create result.make (obj, op, svc, req)
            end
        end
----------------------

    SSL_options : INDEXED_CATALOG [STRING, STRING]
        -- Initialized by SSL_init object

----------------------

    init_ics : SORTED_LIST [INIT_INTERCEPTOR] is

        once
            create result.make (false)
        end
----------------------

    init_exec_initialize (the_orb : ORB; id : STRING;
                          argc : INTEGER_REF;
                          argv : ARRAY [STRING]) : BOOLEAN is

        local
            it   : ITERATOR
            s    : INTEGER

        do
            if init_ics.count = 0 then
                result := true
            else
                from
                    it := init_ics.iterator
                until
                    it.finished
                loop
                    s := init_ics.item (it).initialize (the_orb, id,
                                                     argc, argv)
                    if s = Invoke_abort then
                        result := false
                        it.stop
                    elseif s = Invoke_break then
                        result := true
                        it.stop
                    elseif s = Invoke_retry then
                        check
                            know_what_to_do : false
                        end
                    else
                        it.forth
                    end
                end
                result := true
            end
        end
----------------------

    boa_ics : SORTED_LIST [BOA_INTERCEPTOR] is

        once
            create result.make (false)
        end
----------------------

    boa_exec_bind (repoid : STRING;
                   oid : ARRAY [INTEGER]) : BOOLEAN is

        local
            it : ITERATOR
            s  : INTEGER

        do
            if boa_ics.count = 0 then
                result := true
            else
                from
                    it := boa_ics.iterator
                until
                    it.finished
                loop
                    s := boa_ics.item (it).bind (repoid, oid)
                    if s = Invoke_abort then
                        result := false
                        it.stop
                    elseif s = Invoke_break then
                        result := true
                        it.stop
                    elseif s = Invoke_retry then
                        check
                            know_what_to_do : false
                        end
                    else
                        it.forth
                    end
                end
                result := true
            end
        end
----------------------

    boa_exec_restore (obj : CORBA_OBJECT) : BOOLEAN is

        local
            it   : ITERATOR
            s    : INTEGER

        do
            if boa_ics.count = 0 then
                result := true
            else
                from
                    it := boa_ics.iterator
                until
                    it.finished
                loop
                    s := boa_ics.item (it).restore (obj)
                    if s = Invoke_abort then
                        result := false
                        it.stop
                    elseif s = Invoke_break then
                        result := true
                        it.stop
                    elseif s = Invoke_retry then
                        check
                            know_what_to_do : false
                        end
                    else
                        it.forth
                    end
                end
                result := true
            end
        end
----------------------

    boa_exec_create (obj : CORBA_OBJECT) : BOOLEAN is

        local
            it : ITERATOR
            s  : INTEGER

        do
            if boa_ics.count = 0 then
                result := true
            else
                from
                    it := boa_ics.iterator
                until
                    it.finished
                loop
                    s := boa_ics.item (it).create_object (obj)
                    if s = Invoke_abort then
                        result := false
                        it.stop
                    elseif s = Invoke_break then
                        result := true
                        it.stop
                    elseif s = Invoke_retry then
                        check
                            know_what_to_do : false
                        end
                    else
                        it.forth
                    end
                end
            end
        end
----------------------

    conn_ics : SORTED_LIST [CONN_INTERCEPTOR] is

        once
            create result.make (false)
        end
----------------------

    conn_exec_client_connect (addr : STRING) : BOOLEAN is

        local
            it : ITERATOR
            s  : INTEGER

        do
            from
                it := conn_ics.iterator
            until
                it.finished
            loop
                s := conn_ics.item (it).client_connect (addr)
                if s = Invoke_abort then
                    result := false
                    it.stop
                elseif s = Invoke_break then
                    result := true
                    it.stop
                elseif s = Invoke_retry then
                    check
                        know_what_to_do : false
                    end
                else
                    it.forth
                end
            end -- loop
            result := true
        end
----------------------

    conn_exec_client_disconnect (addr : STRING) : BOOLEAN is

        local
            it : ITERATOR
            s  : INTEGER


        do
            from
                it := conn_ics.iterator
            until
                it.finished
            loop
                s := conn_ics.item (it).client_disconnect (addr)
                if s = Invoke_abort then
                    result := false
                    it.stop
                elseif s = Invoke_break then
                    result := true
                    it.stop
                elseif s = Invoke_retry then
                    check
                        know_what_to_do : false
                    end

                else
                    it.forth
                end
            end
            result := true
        end

end -- class INTERCEPTOR_STATICS

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

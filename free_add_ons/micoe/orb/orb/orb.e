indexing

description: "Implements the microORB with all the functionality that %
             %every ORB will require and the adapter interfaces";
keywords: "microORB", "Invocation Adapter", "Object Adapter";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ORB

inherit
    THE_FLAGS;
    ENUM_CONSTANTS;
    ORB_STATICS;
    TYPECODE_STATICS

creation
    make

feature -- Initialization

    make (argc : INTEGER_REF;
          argv : ARRAY [STRING];
          file : STRING) is

        do
            create {SELECT_DISPATCHER} disp.make
            theid               := 1
            stopped             := true
            wait_for_completion := false
            rcfile              := file
            create tmpl.make
            create isa_cache.make (false)
            create init_refs.make
            create adapters.make (false)
            create shutting_down_adapters.make (false)
            create invokes.make
        end
----------------------
feature

    object_to_string (obj : CORBA_OBJECT) : STRING is

        require
            nonvoid_arg : obj /= void

        do
            result := obj.get_ior.stringify
        end
----------------------

    string_to_object (str : STRING) : CORBA_OBJECT is

        require
            nonvoid_arg : str /= void

        local
            ior : IOR

        do
            create ior.make
            ior.from_string (str)
            result := ior_to_object (ior)
        end
----------------------

    get_rcfile : STRING is

        do
            result := rcfile
        end
----------------------

    tag_to_string (oid : ARRAY [INTEGER]) : STRING is

        local
            i, n : INTEGER
            o    : INTEGER

        do
            from
                result := ""
                i      := oid.lower
                n      := oid.upper
            until
                i > n
            loop
                o := oid.item (i)
                check
                    nonzero_value : o /= 0 
                end
                result.extend (int2character (o))
                i := i + 1
            end
        end
----------------------

    string_to_tag (s : STRING) : ARRAY [INTEGER] is

        require
            nonvoid_arg : s /= void

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := s.count
                create result.make (i, n)
            until
                i > n
            loop
                result.put (s.item (i).code, i)
                i := i + 1
            end
        end
----------------------

    resolve_initial_references (id : STRING) : CORBA_OBJECT is


        local
            imr : IMPLEMENTATION_REPOSITORY_IMPL
            ir  : CORBA_REPOSITORY_IMPL
            log : IO_MEDIUM

        do
            if not equal (id, "InterfaceRepository") and then
               not equal (id, "NameService")             then
                log := logger.log (logger.Log_err, "General", "ORB",
                                   "resolve_initial_references")
                log.put_string ("bad id: ")
                log.put_string (id)
                log.new_line
                check
                    cannot_happen : false
                end
            end
	    if init_refs.has (id) then
	       result := init_refs.at (id)
	    end
        end
----------------------

    list_initial_services : INDEXED_LIST [STRING] is

        local
            it : ITERATOR

        do
            from
                create result.make (false)
                it := init_refs.iterator
            until
                it.finished
            loop
                result.append (init_refs.key (it))
                it.forth
            end
        end
----------------------

    set_initial_reference (id : STRING; obj : CORBA_OBJECT) : BOOLEAN is

        do
            init_refs.put (obj, id)
            result := true
        end
----------------------

    is_impl (obj : CORBA_OBJECT) : BOOLEAN is

        local
            oa : OBJECT_ADAPTER
            o1 : CORBA_OBJECT

        do
            oa := get_oa (obj)
            if oa /= void then
                o1 := oa.skeleton (obj)
            end
            result := (o1 /= void and then equal (obj, o1))
        end
----------------------

    standard_address : ADDRESS is
        -- The address the ORB is putting into each object reference.

        do
            result := tmpl.addr
        end
----------------------

    ior_to_object (ior : IOR) : CORBA_OBJECT is

        local
            obj : CORBA_OBJECT
            oa  : OBJECT_ADAPTER

        do
            create obj.make_with_ior (ior)
            oa := get_oa (obj)
            if oa /= void and then oa.is_local then
                result := oa.skeleton (obj)
            else
                result := obj
            end
        end
----------------------

    return (req : CORBA_REQUEST) is

        do
        end
----------------------

    create_request (ctx        : CORBA_CONTEXT;
                    target     : CORBA_OBJECT;
                    operation  : STRING;
                    arg_list   : CORBA_NV_LIST;
                    inv_result : CORBA_NAMED_VALUE) : CORBA_REQUEST is
        -- The convenient way to create an invocation. This is
        -- an alternative to creating the CORBA_REQUEST object
        -- and then repeatedly calling add_arg_xxx on it.
        -- NOTE: In [5-6] mixing these two approaches is explicitly
        -- discouraged.

        do
            create result.make5 (target, ctx, operation, arg_list, inv_result)
        end
----------------------

    create_environment : ENVIRONMENT is

        do
            create result.make
        end
----------------------

    create_context_list : INDEXED_LIST [STRING] is

        do
            create result.make (false)
        end
----------------------

    create_list (n : INTEGER) : CORBA_NV_LIST is

        do
            create result.make

        ensure
            nonvoid_result : result /= void
        end
----------------------

    create_exception_list : INDEXED_LIST [CORBA_TYPECODE] is

        do
            create result.make (false)
        end
----------------------

    create_operation_list (op : CORBA_OPERATIONDEF) : CORBA_NV_LIST is

        local
            i, n   : INTEGER
            params : CORBA_PARDESCRIPTIONSEQ
            pd     : CORBA_PARAMETERDESCRIPTION

        do
            create result.make
            params := op.params
            from
                i := 0
                n := params.length
            until
                i > n
            loop
                pd := params.get_value (i)
                i  := i + 1
                inspect pd.mode.value

                when Param_in then
                    result.add (Flags.Arg_in).value.set_type (pd.type)

                when Param_out then
                    result.add (Flags.Arg_out).value.set_type (pd.type)

                when Param_inout then
                    result.add (Flags.Arg_inout).value.set_type (pd.type)

                end
            end
        end
----------------------

    create_named_value : CORBA_NAMED_VALUE is

        do
            create result.make

        ensure
            nonvoid_result : result /= void
        end
----------------------

    get_default_context : CORBA_CONTEXT is

        do
            create result.make
        end
----------------------

    send_multiple_requests_oneway (rl : INDEXED_LIST [CORBA_REQUEST]) : INTEGER is

        local
            r    : INTEGER
            i, n : INTEGER

        do
            from
                i := rl.low_index
                n := rl.high_index
            until
                i > n
            loop
                rl.at (i).send_oneway
                i := i + 1
            end
        end
----------------------

    send_multiple_requests_deferred (rl : INDEXED_LIST [CORBA_REQUEST]) : INTEGER is

        local
            i, n : INTEGER

        do
            from
                i := rl.low_index
                n := rl.high_index
            until
                i > n
            loop
                rl.at (i).send
                i := i + 1
            end
        end
----------------------

    poll_next_response : BOOLEAN is

        local
            rec : INVOKE_RECORD
            req : ORB_REQUEST
            it  : ITERATOR

        do
            from
                it := invokes.iterator
            until
                it.finished
            loop
                rec := invokes.item (it)
                req := rec.request
                if rec.request_type = Request_invoke and then
                   rec.completed                     and then
                   equal (req.type, "local")             then
                    -- found a local request that has completed
                    result := true
                    it.stop
                else
                    it.forth
                end
            end
        end
----------------------

    get_next_response : CORBA_REQUEST is

        local
            rec  : INVOKE_RECORD
            req  : ORB_REQUEST
            lreq : LOCAL_REQUEST
            it   : ITERATOR

        do
            from
                it := invokes.iterator
            until
                it.finished
            loop
                rec := invokes.item (it)
                req := rec.request
                if rec.request_type = Request_invoke and then
                   rec.completed                     and then
                   equal (req.type, "local")             then
                    -- found a local request that has completed
                    lreq   ?= req
                    result := lreq.request
                    it.stop
                else
                    it.forth
                end
            end
        end
----------------------

    work_pending : BOOLEAN is

        do
            -- if not stopped run has been called and cares
            -- for events ...
            result := (stopped and then not disp.idle)
        end
----------------------

    perform_work is

        do
            if not stopped then
                disp.run
            end
        end
----------------------

    run is

        local
            i, n : INTEGER

        do
            from
                stopped := false
            until
                stopped
            loop
                disp.run
            end
            if wait_for_completion then
                shutting_down_adapters := clone (adapters)
            end -- if wait_for_completion then ...
            from
                i := adapters.low_index
                n := adapters.high_index
            until
                i > n
            loop
                adapters.at (i).shutdown (wait_for_completion)
                i := i + 1
            end -- loop
            if wait_for_completion then
                from
                    -- nothing
                until
                    shutting_down_adapters.count = 0
                loop
                    disp.run
                end -- loop
            end -- if wait_for_completion then ...
        end
----------------------

    shutdown (wait : BOOLEAN) is

        do
            wait_for_completion := wait
            stopped             := true
        end
----------------------
feature -- BOAs

    BOA_instance1 (id : STRING) : BOA is

        require
            nonvoid_arg : id /= void

        do
            result := BOA_instance2 (id, true)
        end
----------------------

    BOA_instance2 (id : STRING; do_create : BOOLEAN) : BOA is

        require
            nonvoid_arg : id /= void

        local
            i, n : INTEGER

        do
            from
                i := adapters.low_index
                n := adapters.high_index
            until
                i > n or else result /= void
            loop
                if equal (id, adapters.at (i).get_oaid) then
                    result ?= adapters.at (i)
                else
                    i := i + 1
                end
            end
            if result = void and then do_create then
                result := BOA_init (0, void, id)
            end
        end
----------------------

    BOA_init (argc   : INTEGER_REF;
              argv   : ARRAY [STRING];
              id     : STRING) : BOA is

        require
            nonvoid_args : id   /= void and then
                           argc /= void

        local
            opts       : DICTIONARY [STRING, STRING]
            o          : INDEXED_CATALOG [STRING, STRING]
            opt_parser : GET_OPTS
            r, done    : BOOLEAN
            i, n       : INTEGER
            obj        : CORBA_OBJECT
            log        : IO_MEDIUM

        once
            create opts.make
            opts.put ("unique", "-OAId")
            create opt_parser.make (opts)
            if rcfile /= void      and then
               fs.file_exists (rcfile) then
                r := opt_parser.parse_file2 (rcfile, true)
                check
                    file_parse_ok : r
                end
            end
            if argv /= void then
                r := opt_parser.parse3 (argc, argv, true)
                check
                    arg_parse_ok : r
                end
            end -- if argv /= void then ...
            o  := opt_parser.opts
            if o.has ("-OAID") then
                id.copy (o.at ("-OAID").at (1))
            end
            check
                nonempty_id : id.count /= 0
            end
            from
                i := adapters.low_index
                n := adapters.high_index 
            until
                i > n or else done
            loop
                if equal (id, adapters.at (i).get_oaid) then
                    result ?= adapters.at (i)
                    done   := true
                else
                    i := i + 1
                end
            end
            if not done then
                if not equal (id, "mico-local-boa") then
                    log := logger.log (logger.Log_warning, "General",
                                       "ORB", "BOA_init")
                    log.put_string ("unknown OA id : ")
                    log.put_string (id)
                    log.new_line
                end -- if not equal (id, "mico-local-boa") then ...
                create result.make (current, argc, argv)
                -- The creation procedure registers `result'.
                -- make sure impl repository is active ...

--                obj := resolve_initial_references
--                                ("ImplementationRepository")
            end -- if not done then ...
        end
----------------------
feature -- MICO extension (not in appendix)


    new_msgid : INTEGER is

        do
            if theid = 0 then
                theid := 1
            end
            result := theid
            theid  := theid + 1
        end
----------------------

    get_bindaddrs : INDEXED_LIST [STRING] is

        do
            result := bindaddrs
        end
----------------------

    set_bindaddrs (ba : INDEXED_LIST [STRING]) is

        do
            bindaddrs := ba
        end
----------------------

    dispatcher : DISPATCHER is

        do
            result := disp
        end
----------------------

    set_dispatcher (d : DISPATCHER) is

        do
            if d /= void then
                -- move the pending events from disp to d
                disp.move (d)
            end
            disp := d
        end
----------------------
feature { INVOCATION_ADAPTER } -- IAI (Invocation Adapter Interface)

    invoke3 (obj      : CORBA_OBJECT;
             req      : ORB_REQUEST;
             pr       : PRINCIPAL) : INTEGER is
        -- Pass a method invocation (synchronously) to the
        -- apprpropriate object adapter.

        do
            result := invoke4 (obj, req, pr, true)
        end
----------------------

    invoke4 (obj      : CORBA_OBJECT;
            req       : ORB_REQUEST;
            pr        : PRINCIPAL;
            reply_exp : BOOLEAN) : INTEGER is
        -- Pass a method invocation (synchronously) to the
        -- apprpropriate object adapter.

        require
            nonvoid_arg : obj /= void

        local
            id    : INTEGER
            r     : BOOLEAN
            o     : ANY_REF
            orr   : ANY_REF

        do
            id := invoke_async4 (obj, req, pr, reply_exp)
            if not reply_exp then
                result := Invoke_ok
            else
                check
                    nonzero_id : id /= 0
                end
                r := wait1 (id)
                check
                    wait_ok : r
                end
                create orr
                orr.set_item (req)
                create o
                o.set_item (obj)
                result  := get_invoke_reply (id, o, orr)
            end
        end
----------------------

    locate (obj : CORBA_OBJECT) : INTEGER is
        -- Locate (synchronously) the servant for the object represented
        -- by `obj' (objects can migrate).

        local
            id : INTEGER
            o  : ANY_REF
            o1 : CORBA_OBJECT
            r  : BOOLEAN

        do
            id := locate_async1 (obj)
            r  := wait1 (id)
            check
                wait_ok : r
            end
            create o
            result := get_locate_reply (id, o)
            o1     ?= o.item
            obj.make_with_ior (o1.get_ior)
        end
----------------------

    invoke_async3 (obj :  CORBA_OBJECT;
                   req :  ORB_REQUEST;
                   princ : PRINCIPAL) : INTEGER is
        -- Pass a method invocation (asynchronously) to the
        -- apprpropriate object adapter.

        do
            result := invoke_async6 (obj, req, princ, true, void, 0)
        end
----------------------

    invoke_async4 (obj   : CORBA_OBJECT;
                   req   : ORB_REQUEST;
                   princ : PRINCIPAL;
                   rply  : BOOLEAN) : INTEGER is
        -- Pass a method invocation (asynchronously) to the
        -- apprpropriate object adapter.

        do
            result := invoke_async6 (obj, req, princ, rply, void, 0)
        end
----------------------

    invoke_async5 (obj   : CORBA_OBJECT;
                   req   : ORB_REQUEST;
                   princ : PRINCIPAL;
                   rply  : BOOLEAN;
                   ocb   : ORB_CALLBACK) : INTEGER is
        -- Pass a method invocation (asynchronously) to the
        -- apprpropriate object adapter.

        do
            result := invoke_async6 (obj, req, princ, rply, ocb, 0)
        end
----------------------

    invoke_async6 (obj   : CORBA_OBJECT;
                   req   : ORB_REQUEST;
                   princ : PRINCIPAL;
                   rply  : BOOLEAN;
                   ocb   : ORB_CALLBACK;
                   msgid : INTEGER) : INTEGER is
        -- Pass a method invocation (asynchronously) to the
        -- apprpropriate object adapter.

        local
            mid  : INTEGER
            rec  : INVOKE_RECORD
            oa   : OBJECT_ADAPTER
            ex   : OBJECT_NOT_EXIST
            dum  : BOOLEAN

        do
            logger.trace_enter ("ORB", "invoke_async6")
            if msgid = 0 then
                mid := new_msgid
            else
                mid := msgid
            end
            if rply then
                create rec.make_invoke4 (current, mid, req, ocb)
                add_invoke (rec)
            end            

            if not builtin_invoke (mid, obj, req, princ) then
                oa := get_oa (obj)
                if oa = void then
                    create ex.make
                    req.set_out_args_ex (ex)
                    answer_invoke (mid, Invoke_sys_ex, void, req)
                    result := mid
                else
                    if rply then
                        rec.set_oa (oa)
                    end
                    dum := oa.invoke5 (mid, obj, req, princ, rply)
                end
            end
            if rply then
                result := mid
            end
            logger.trace_leave ("ORB", "invoke_async6")
        end
----------------------

    locate_async1 (obj : CORBA_OBJECT) : INTEGER is
        -- Locate (asynchronously) the servant for the object represented
        -- by `obj' (objects can migrate).

     do
            result := locate_async3 (obj, void, 0)
        end
----------------------

    locate_async2 (obj : CORBA_OBJECT; ocb : ORB_CALLBACK) : INTEGER is
        -- Locate (asynchronously) the servant for the object represented
        -- by `obj' (objects can migrate).

        do
            result := locate_async3 (obj, ocb, 0)
        end
----------------------

    locate_async3 (obj   : CORBA_OBJECT;
                   ocb   : ORB_CALLBACK;
                   msgid : INTEGER) : INTEGER is
        -- Locate (asynchronously) the servant for the object represented
        -- by `obj' (objects can migrate).

        local
            oa  : OBJECT_ADAPTER
            mid : INTEGER

        do
            if msgid = 0 then
                mid := new_msgid
            else
                mid := msgid
            end
            oa := get_oa (obj)
            if oa = void then
                answer_locate (mid, Locate_unknown, void)
            else
                oa.locate (mid, obj)
            end
            result := mid
        end
----------------------

    cancel (id : INTEGER) is
        -- Cancel the invoke or locate request with request identifier
        -- `id'.

        local
            rec : INVOKE_RECORD

        do
            rec := get_invoke (id)
            if rec /= void then
                if rec.oa /= void then
                    rec.oa.cancel (id)
                end
                del_invoke (id)
            end
        end
----------------------

    wait1 (id : INTEGER) : BOOLEAN is
        -- Wait for completion of the (asynchronous) invoke or locate
        -- operation with request identifier `id'.

        do
            result := wait2 (id,  -1)
        end
----------------------
    
    wait2 (id, tmout : INTEGER) : BOOLEAN is
        -- Wait for completion of the (asynchronous) invoke or locate
        -- operation with request identifier `id'. Timeout after time
        -- `tmout'.

        local
            t    : TIMEOUT
            rec  : INVOKE_RECORD
            done : BOOLEAN

        do
            from
                create t.make (disp, tmout)
                rec := get_invoke (id)
            until
                done
            loop
                if rec.completed then
                    result := true
                    done   := true
                elseif t.done then
                    result := false
                    done   := true
                else
                    disp.run
                end
            end
        end
----------------------

    wait_vec1 (ids : INDEXED_LIST [INTEGER]) : INTEGER is
        -- Wait for completion of any of the (asynchronous) invoke or
        -- locate operations with a request identifier in `ids'.

        do
            result := wait_vec2 (ids, -1)
        end
----------------------

    wait_vec2 (ids : INDEXED_LIST [INTEGER]; tmout : INTEGER) : INTEGER is
        -- Wait for completion of any of the (asynchronous) invoke or
        -- locate operations with a request identifier in `ids'. Timeout
        -- after time `tmout'.

        local
            t     : TIMEOUT
            rec   : INVOKE_RECORD
            done  : BOOLEAN
            i, n  : INTEGER
            ready : INDEXED_LIST [INTEGER]

        do
            create t.make (disp, tmout)

            from
                create ready.make (false)
            until
                done
            loop
                from
                    i := ids.low_index
                    n := ids.high_index
                until
                    i > n
                loop
                    rec := get_invoke (ids.at (i))
                    check
                        rec_nonvoid : rec /= void
                    end
                    if rec.completed then
                        ready.append (ids.at (i))
                    end
                    i := i + 1
                end
                if ready.count > 0 then
                    ids.copy (ready)
                    result := ready.count
                    done   := true
                elseif t.done then
                    done := true
                end
                disp.run
            end
        end
----------------------

    get_invoke_reply (id  : INTEGER;
                      obj : ANY_REF;
                      req : ANY_REF) : INTEGER is
        -- Get the reply from the invoke operation with request
        -- identifier `id'. The value of `req' will be a thunk
        -- representing the reply.

        require
            nonvoid_args : obj    /= void and then
                           req    /= void

        local
            rec   : INVOKE_RECORD
            state : INTEGER_REF
            ret   : BOOLEAN

        do
            rec := get_invoke (id)
            check
                nonvoid_rec : rec /= void
            end
            create state
            ret  := rec.get_answer_invoke (state, obj, req)
            check
                got_answer_invoke : ret
            end
            del_invoke (id)
            result := state.item
        end
----------------------

    get_locate_reply (id : INTEGER; obj : ANY_REF) : INTEGER is
        -- Get the reply to the locate operation with request
        -- identifier `id'. The value returned in `obj' represents
        -- the reply to this operation.

        require
            nonvoid_arg : obj /= void

        local
            rec   : INVOKE_RECORD
            state : INTEGER_REF
            r     : BOOLEAN

        do
            rec := get_invoke (id)
            check
                nonvoid_rec : rec /= void
            end
            create state
            r := rec.get_answer_locate (state, obj)
            check
                got_answer_locate : r
            end
            del_invoke (id)
            result := state.item
        end
----------------------
feature { ANY}
    -- The following 5 `bind' routines con be used by application
    -- classes. `bind' is special to MICO. i. e. not specified by
    -- the OMG.


    bind (obj  : CORBA_OBJECT;
          addr : STRING) : CORBA_OBJECT is

        do
            result := bind_o3 (obj.repoid, obj.tag, addr)
        end
----------------------

    bind1 (repoid : STRING) : CORBA_OBJECT is
        -- Get reference for an anonymous servant with type
        -- described by `repoid'. Look for it on server with
        -- address specified by an option -ORBBindAddr <addr>
        -- in the command line.

        do
            result := bind_o2 (repoid, void)
        end
----------------------

    bind2 (repoid, name : STRING) : CORBA_OBJECT is
        -- Get reference for a servant with name `name' and
        -- type described by `repoid'. Look for it on server with
        -- address specified by an option -ORBBindAddr <addr>
        -- in the command line.

        require
            nonvoid_arg : name /= void

        do
            result := bind_o3 (repoid, string_to_tag (name), void)
        end
----------------------

    bind1_3 (repoid, addr : STRING) : CORBA_OBJECT is
        -- Get reference for an anonymous servant with type
        -- specified by `repoid'. Look for it on server with
        -- address `addr'.

        do
            result := bind_o2 (repoid, addr)
        end
----------------------

    bind3 (repoid, name, addr : STRING) : CORBA_OBJECT is
        -- Get reference for a servant with name `name' and type
        -- specified by `repoid'. Look for it on server with
        -- address `addr'.

        require
            nonvoid_arg : name /= void

        do
            result := bind_o3 (repoid, string_to_tag (name), addr)
        end
----------------------
feature { INVOCATION_ADAPTER, OBJECT_ADAPTER, THE_ORB }
    -- We have to make an exception for THE_ORB because
    -- ORB_init, which is (unfortunately) in THE_ORB,
    -- calls `bind'.

    bind_s (repoid : STRING;
            oid    : ARRAY [INTEGER];
            addr   : ADDRESS;
            obj    : ANY_REF) : INTEGER is
        -- Note: this routine may perfectly well fail
        -- if `addr' wasn't the right bind address.

        local
            id  : INTEGER
            o1  : CORBA_OBJECT
            r   : BOOLEAN
            log : IO_MEDIUM

        do
            id := bind_async3 (repoid, oid, addr)
            if id = 0 then
                result := Locate_unknown
            else
                r := wait1 (id)
                check
                    wait_ok : r
                end
                result := get_bind_reply (id, obj)
                o1     ?= obj.item
                if o1 = void then
                    log := logger.log (logger.Log_info, "General",
                                       "ORB", "bind_s")
                    log.put_string ("bind to address: ")
                    log.put_string (addr.stringify)
                    log.put_string (" failed")
                    log.new_line
                else
                    log := logger.log (logger.Log_info, "General",
                                       "ORB", "bind_s")
                    log.put_string ("bind to address: ")
                    log.put_string (addr.stringify)
                    log.put_string (" succeeded")
                    log.new_line
                end
            end
        end
----------------------

    bind_o1 (repoid : STRING) : CORBA_OBJECT is

        do
            result := bind_o2 (repoid, void)
        end
----------------------

    bind_o2 (repoid : STRING; addr : STRING) : CORBA_OBJECT is

        local
            oid : ARRAY [INTEGER]

        do
            create oid.make (1, 0)
            result := bind_o3 (repoid, oid, addr)
        end
----------------------

    bind_o2a (repoid : STRING;
              oid    : ARRAY [INTEGER]) : CORBA_OBJECT is

        do
            result := bind_o3 (repoid, oid, void)
        end
----------------------

    bind_o3 (repoid : STRING;
             oid    : ARRAY [INTEGER];
             addr   : STRING) : CORBA_OBJECT is

        local
            addrs : INDEXED_LIST [STRING]
            i, n  : INTEGER
            s     : INTEGER
            a     : ADDRESS
            log   : IO_MEDIUM
            res   : ANY_REF

        do
            if addr /= void then
                -- use given addresss
                create addrs.make (false)
                addrs.append (addr)
            else
                -- use default addresses
                addrs := bindaddrs
            end
            if addrs = void then
                logger.log (logger.Log_warning, "General",
                            "ORB", "bind_o3").put_string ("No bind addresses %
                                                          %known%N")
            else
                from
                    i := addrs.low_index
                    n := addrs.high_index
                until
                    i > n or else result /= void
                loop
                    a := address_parse (addrs.at (i))
                    if a /= void then
                        create res
                        s := bind_s (repoid, oid, a, res)
                        if s = Locate_here then
                            result ?= res.item
                        end
                    else
                        log := logger.log (logger.Log_warning, "General",
                                           "ORB", "bind_o3")
                        log.put_string ("bad address: ")
                        log.put_string (addrs.at (i))
                        log.new_line
                    end -- if a /= void then ...
                    i := i + 1
                end -- loop over i
            end -- if addrs = void then ...

        ensure
            nonvoid_result : result /= void
        end
----------------------

    bind_async3 (repoid : STRING;
                 oid    : ARRAY [INTEGER];
                 addr   : ADDRESS) : INTEGER is

        do
            result := bind_async5 (repoid, oid, addr, void, 0)
        end
----------------------

    bind_async4 (repoid : STRING
                 oid    : ARRAY [INTEGER];
                 addr   : ADDRESS;
                 ocb    : ORB_CALLBACK) : INTEGER is

        do
            result := bind_async5 (repoid, oid, addr, ocb, 0)
        end
----------------------

    bind_async5 (repoid : STRING;
                 oid    : ARRAY [INTEGER];
                 addr   : ADDRESS;
                 ocb    : ORB_CALLBACK;
                 msgid  : INTEGER) : INTEGER is

        local
            mid  : INTEGER
            rec  : INVOKE_RECORD
            i, n : INTEGER
            done : BOOLEAN

        do
            logger.trace_enter ("ORB", "bind_async5")
            if msgid = 0 then
                mid := new_msgid
            else
                mid := msgid
            end
            create rec.make_bind5 (current, mid, repoid, oid, ocb)
            add_invoke (rec)
            from
                i := adapters.low_index
                n := adapters.high_index
            until
                i > n or else done
            loop
                rec.set_oa (adapters.at (i))
                if adapters.at (i).bind (mid, repoid, rec.tag, addr) then
                    result := mid
                    done   := true
                else
                    i := i + 1
                end
            end
            if not done then
                answer_bind (mid, Locate_unknown, void)
                result := mid
            end    
            logger.trace_leave ("ORB", "bind_async5")
        end
----------------------

    get_bind_reply (id : INTEGER; obj : ANY_REF) : INTEGER is

        require
            nonvoid_arg : obj /= void

        local
            rec   : INVOKE_RECORD
            state : INTEGER_REF
            r     : BOOLEAN

        do
            rec := get_invoke (id)
            check
                nonvoid_rec : rec /= void
            end
            create state
            r := rec.get_answer_bind (state, obj)
            check
                got_answer_bind : r
            end
            del_invoke (id)
            result := state.item 
        end
----------------------
feature { OBJECT_ADAPTER, REQUEST_QUEUE_RECORD }
    -- OAI (Object Adapter Interface}
    -- We make an exception for REQUEST_QUEUE_RECORD rather than
    -- letting REQUEST_QUEUE_RECORD inherit from OBJECT_ADAPTER
    -- which would seem ridiculous.

    register_oa (oa : OBJECT_ADAPTER) is

        do
            if oa.is_local then
                adapters.insert (oa, 0) -- Put local ones at front.
            else
                adapters.append (oa)
            end
        end
----------------------

    unregister_oa (oa : OBJECT_ADAPTER) is

        do
            adapters.remove (oa)
        end
----------------------

    answer_invoke (id, stat : INTEGER;
                   obj : CORBA_OBJECT; req : ORB_REQUEST) is

        local
            rec : INVOKE_RECORD

        do
            logger.trace_enter ("ORB", "answer_invoke")
            rec := get_invoke (id)
            if rec /= void then
                rec.set_answer_invoke (stat, obj, req)
                if rec.callback /= void then
                    rec.callback.callback_o (current, rec.id, ORB_invoke)
                end
            end
            logger.trace_leave ("ORB", "answer_invoke")
        end
----------------------

    answer_locate (id, stat : INTEGER; obj : CORBA_OBJECT) is

        local
            rec : INVOKE_RECORD

        do
            rec := get_invoke (id)
            if rec /= void then
                rec.set_answer_locate (stat, obj)
                if rec.callback /= void then
                    rec.callback.callback_o (current, rec.id, ORB_locate)
                end
            end
        end
----------------------

    answer_bind (id, stat : INTEGER; obj : CORBA_OBJECT) is

        local
            rec : INVOKE_RECORD

        do
            logger.trace_enter ("ORB", "answer_bind")
            rec := get_invoke (id)
            if rec /= void then
                rec.set_answer_bind (stat, obj)
                if rec.callback /= void then
                    rec.callback.callback_o (current, rec.id, ORB_bind)
                end
            end
            logger.trace_leave ("ORB", "answer_bind")
        end
----------------------

    answer_shutdown (oa : OBJECT_ADAPTER) is

        local
            i, n : INTEGER

        do
            from
                i := shutting_down_adapters.low_index
                n := shutting_down_adapters.high_index
            until
                i > n
            loop
                if shutting_down_adapters.at (i) = oa then
                    shutting_down_adapters.remove_at (i)
                    i := n
                end
                i := i + 1
            end
        end
----------------------
feature { ANY }

    request_type (id : INTEGER) : INTEGER is

        local
            rec : INVOKE_RECORD

        do
            rec := get_invoke (id)
            if rec /= void then
                result := rec.request_type
            else
                result := Request_unknown
            end
        end
----------------------

    get_iface (o : CORBA_OBJECT) : CORBA_INTERFACEDEF is

        do
        end
----------------------

    non_existent (obj : CORBA_OBJECT) : BOOLEAN is

        require
            nonvoid_arg : obj /= void

        local
            req  : CORBA_REQUEST

        do
            -- [12-17]
            -- XXX is this really called "_not_exitent" and
            -- not "_non_existent" ? 
            req := obj.request ("_not_t_existent")
            req.invoke_result.value.set_type (Tc_boolean)
            req.invoke
            if req.env.exception /= void then
                --an exception means we cannot contact the object ...
                result := true
            else
                result := req.invoke_result.value.get_boolean
            end
        end
----------------------

    get_impl (obj : CORBA_OBJECT) : IMPLEMENTATION_DEFINITION is

        require
            nonvoid_arg : obj /= void

        local
            req  : CORBA_REQUEST

        do
            -- [12-17]
            req := obj.request ("_implementation")
--            req.invoke_result.value.set_type (Tc_implementation_def)
            req.invoke
            check
                not_exception : req.env.exception = void
            end
            -- XXX incomplete; we need to extend the class CORBA_ANY
            -- to handle IMPLEMENTATION_DEFINITIONS
        end
----------------------

    is_a (obj : CORBA_OBJECT; repo_id : STRING) : BOOLEAN is

        require
            nonvoid_args : obj     /= void and then
                           repo_id /= void

        local
            key  : STRING
            req  : CORBA_REQUEST

        do
            -- XXX this assumes idents are globally unique
            key := clone (obj.get_ident)
            key.extend ('$')
            key.append (repo_id)
            isa_cache.search (key)
            if isa_cache.found then
                isa_cache.remove_at (isa_cache.index)
                isa_cache.insert (key, isa_cache.low_index - 1)
                    -- move it to the front, so we'll find it
                    -- faster next time.
                    result := true
            end
            if not result then
                req := obj.request ("_is_a")
                req.add_in_arg_with_name
                      ("logical_type_id").put_string (repo_id, repo_id.count)
                req.set_return_type (Tc_boolean)
                req.invoke
                check
                    not_exception : req.env.exception = void
                end
                result := req.return_value.get_boolean
                if result then
                    isa_cache.insert (key, isa_cache.low_index - 1)
                    -- XXX CACHE size = 50
                    if isa_cache.count > 50 then
                        isa_cache.remove_at (isa_cache.high_index)
                    end
                end
            end
        end
----------------------

    ior_template : IOR is

        do
            result := tmpl
        end
----------------------

    set_pending_exception (e : CORBA_EXCEPTION) is
        -- This is special to mico/E.

        do
            pending_exception := e
        end
----------------------

    get_pending_exception : CORBA_EXCEPTION is
        -- This is special to mico/E.

        do
            result := pending_exception
        end
----------------------
feature { ORB } -- Implementation

    adapters               : INDEXED_LIST [OBJECT_ADAPTER]
    shutting_down_adapters : INDEXED_LIST [OBJECT_ADAPTER]
    invokes                : DICTIONARY [INVOKE_RECORD, INTEGER]
        -- The microORB handles asynchronous invocations, so it
        -- has to keep a record of those operations still pending.
        -- This where it does that. The keys are the request
        -- identifiers.
    init_refs              : DICTIONARY [CORBA_OBJECT, STRING]
    isa_cache              : INDEXED_LIST [STRING]
    bindaddrs              : INDEXED_LIST [STRING]
    disp                   : DISPATCHER
    tmpl                   : IOR
    theid                  : INTEGER
    rcfile                 : STRING
    stopped                : BOOLEAN
    wait_for_completion    : BOOLEAN
    pending_exception      : CORBA_EXCEPTION
----------------------

    get_oa (o : CORBA_OBJECT) : OBJECT_ADAPTER is

        local
            i, n : INTEGER
            addr : ADDRESS

        do
            -- first try local adapters
            from
                i := adapters.low_index
                n := adapters.high_index
            until
                i > n or else result /= void
            loop
                if adapters.at (i).is_local   and then
                   adapters.at (i).has_object (o) then
                    result := adapters.at (i)
                else
                    i := i + 1
                end
            end
            -- and now non local adapters
            if result = void then
                from
                    i := adapters.low_index
                    n := adapters.high_index
                until
                    i > n or else result /= void
                loop
                    if not adapters.at (i).is_local and then
                       adapters.at (i).has_object (o)   then
                        result := adapters.at (i)
                        addr   := result.address_used_for_object (o)
                        if is_local_address (addr) then
                            result := void
                            i      := n + 1
                            -- Otherwise we get into an endless loop.
                            -- Returning void will likely cause the
                            -- client to get an OBJECT_NOT_EXIST exception.
                            -- If no local OA claimed `o' then this is
                            -- the correct reaction.
                        end
                    else
                        i := i + 1
                    end
                end
            end
        end
----------------------

    is_local_address (addr : ADDRESS) : BOOLEAN is

        do
            result := tmpl.has_address (addr)
        end
----------------------

    add_invoke (irec : INVOKE_RECORD) is

        do
            invokes.put (irec, irec.id)
        end
----------------------

    get_invoke (id : INTEGER) : INVOKE_RECORD is

        do
            if invokes.has (id) then
                result := invokes.at (id)
            end

        ensure
            ids_match : result /= void implies result.id = id
        end
----------------------

    del_invoke (id : INTEGER) is

        do
            invokes.remove (id)
        end
----------------------

    builtin_invoke (msgid : INTEGER;
                    obj   : CORBA_OBJECT;
                    req   : ORB_REQUEST;
                    princ : PRINCIPAL) : BOOLEAN is

        local
            res  : CORBA_ANY
            nvl  : CORBA_NV_LIST
            ex   : MARSHAL

        do
            -- _not_existent is the only special one,
            -- _implementation, _interface and _is_a are
            -- just passed through to the OA.
            if equal (req.op_name, "_not_existent") then
                if get_oa (obj) = void then
                    create res.make
                    res.put_boolean (true)
                    create nvl.make
                    if not req.set_out_args_nvl (res, nvl) then
                        create ex.make
                        req.set_out_args_ex (ex)
                        answer_invoke (msgid, Invoke_sys_ex, void, req)
                    else
                        answer_invoke (msgid, Invoke_ok, void, req)
                    end
                    result := true
                end
            end
        end
----------------------

    int2character (n : INTEGER) : CHARACTER is

        external "C"
        alias    "CORBA_int2character"

        end

end -- class ORB

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
